#! /usr/bin/env sh

LOCAL_SUFFIX="breminale"
GLUON_DIR="gluon/"
KEYFILE="$HOME/.ecdsakey"
local_version=1

set -eu

if which realpath > /dev/null; then
  GLUON_SITEDIR="$(dirname "$(realpath "$0")")"
else
  GLUON_SITEDIR="$(dirname "$(readlink -f "$0")")"
fi
export GLUON_SITEDIR

get_GLUON_TAG() {
  if ! git --git-dir="${GLUON_DIR}/.git" describe --exact-match; then
    echo 'The gluon tree is not checked out at a tag.'
    echo 'Please use `git checkout <tagname>` to use an official gluon release'
    echo 'or build it manually. Only with at a tag we can autogenerate the'
    echo 'release string!'
    exit 1
  fi
}


debug=
if [ "$#" -gt 0 ]; then
  if [ "$1" = '-h' -o "$1" = '--help' ]; then
    cat <<USAGE
Usage: $(basename $0) [--debug]

This script tries to autodetermine the correct release name, builds gluon for
all supported platforms (excluding x86*), and optionally signs it if an
ecdsutils keyfile is found (standard path: ~/.ecdsakey)
USAGE
    exit 1
  fi

  if [ "$1" = "--debug" ]; then
      debug=1
      shift
  fi
fi

GLUON_BRANCH="stable"
GLUON_TAG="$(get_GLUON_TAG)"
# remove prefixed "v"
GLUON_TAG="${GLUON_TAG#v}"

echo "Building Gluon ${GLUON_TAG} as ${GLUON_BRANCH}"
auto_determined_release="${GLUON_TAG}+${LOCAL_SUFFIX}${local_version}"
read -p "Release name for this build [default: ${auto_determined_release}]: " GLUON_RELEASE
GLUON_RELEASE="${GLUON_RELEASE:-$auto_determined_release}"


# calculate number of threads
if [ -z "$debug" ]; then
    proc_num="$(($(grep -c '^processor\s' /proc/cpuinfo) + 1))"
else
    proc_num=1
fi

cd "$GLUON_DIR"
export GLUON_BRANCH GLUON_RELEASE
make update ${debug:+V=s}

for target in ar71xx-generic; do
  #make clean GLUON_TARGET="$target" ${debug:+V=s}
  make -j${proc_num} GLUON_TARGET="$target" ${debug:+V=s}
done
