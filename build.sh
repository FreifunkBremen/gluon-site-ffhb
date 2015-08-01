#!/bin/sh

FIRMWARE_URL="http://downloads.bremen.freifunk.net/firmware/"
LOCAL_SUFFIX="bremen"
GLUON_DIR="gluon/"
KEYFILE="$HOME/.ecdsakey"

set -eu

export GLUON_SITEDIR="$(dirname "$(readlink -f "$0")")"

get_gluon_tag() {
  if ! git --git-dir="${GLUON_DIR}/.git" describe --exact-match; then
    echo 'The gluon tree is not checked out at a tag.'
    echo 'Please use `git checkout <tagname>` to use an official gluon release'
    echo 'or build it manually. Only with at a tag we can autogenerate the'
    echo 'release string!'
    exit 1
  fi
}

get_last_release() {
  branch="$1"
  wget -q -O- "${FIRMWARE_URL}/${branch}/sysupgrade/${branch}.manifest" | \
    awk 'parse == 1 { print $2; exit } /^$/ { parse=1 }'
}

is_based_on() {
  [ "${1#$2}" != "${1}" ]
  return $?
}

extract_local_version() {
  local_version_tmp="${1#*+${LOCAL_SUFFIX}}"
  echo "${local_version_tmp%~testing}"
}

if [ "$#" != 1 ]; then
  cat <<USAGE
Usage: $(basename $0) <branch>

This script takes the intended branch, "testing" or "stable", as the single
parameter. It then tries to autodetermine the correct release name, builds
gluon for the corresponding branch and all supported platforms (excluding
x86*), and optionally signs it if an ecdsutils keyfile is found (standard path:
~/.ecdsakey)
USAGE
  exit 1
fi

branch="$1"
case "$branch" in
  testing|stable)
    gluon_tag="$(get_gluon_tag)"
    # remove prefixed "v"
    gluon_tag="${gluon_tag#v}"
    echo "Building Gluon ${gluon_tag} as ${branch}"
    last_release_testing="$(get_last_release testing)"
    last_release_stable="$(get_last_release stable)"
    echo "Last release in branch testing was ${last_release_testing}"
    if is_based_on "$last_release_testing" "$gluon_tag"; then
      local_version="$(extract_local_version "$last_release_testing")"
      if [ "$branch" != "stable" ]; then
        local_version="$(($local_version + 1))"
      fi
    elif [ "$branch" = "stable" ] && is_based_on "$last_release_stable" "$gluon_tag"; then
      local_version="$(extract_local_version "$last_release_stable")"
      local_version="$(($local_version + 1))"
    else
      # new gluon version => reset local version number
      local_version=1
    fi
    if [ "$branch" = "testing" ]; then
      local_version="${local_version}~testing"
    fi
    auto_determined_release="${gluon_tag}+${LOCAL_SUFFIX}${local_version}"
    read -p "Release name for this build [default: ${auto_determined_release}]: " GLUON_RELEASE
    export GLUON_RELEASE="${GLUON_RELEASE:-$auto_determined_release}"
    export GLUON_BRANCH="$branch"
    ;;
  *)
    echo "Branch not supported yet!"
    exit 1
    ;;
esac

cd "$GLUON_DIR"
make update
for target in ar71xx-generic ar71xx-nand mpc85xx-generic; do
  make clean GLUON_TARGET="$target"
  make -j5 GLUON_TARGET="$target"
done
make manifest
cd ..
if [ -n "$KEYFILE" -a -r "$KEYFILE" ]; then
	"${GLUON_DIR}/contrib/sign.sh" "$KEYFILE" "${GLUON_DIR}/images/sysupgrade/${GLUON_BRANCH}.manifest"
fi
