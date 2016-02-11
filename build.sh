#! /usr/bin/env sh

FIRMWARE_URL="http://downloads.bremen.freifunk.net/firmware/"
LOCAL_SUFFIX="bremen"
GLUON_DIR="gluon/"
KEYFILE="$HOME/.ecdsakey"

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

statefile="${GLUON_SITEDIR}/.build.${GLUON_BRANCH}.${GLUON_TAG}"
cont=false

if [ -f "$statefile" ]; then
  echo "A previous build for this version was aborted."
  echo "These were the parameters:"
  cat "$statefile"
  echo "You can now either continue the previous build or begin a new one"
  echo "and overwrite the old state file."
  read -p "Do you want to continue the previous build? [Yn] " answer
  case "${answer:-y}" in
    [yY]*)
      . "$statefile"
      cont=true
      ;;
    *)
      rm "$statefile"
      ;;
  esac
fi
if ! $cont; then
  echo "Building Gluon ${GLUON_TAG} as ${GLUON_BRANCH}"
  last_release_testing="$(get_last_release testing)"
  last_release_stable="$(get_last_release stable)"
  last_release="$(echo "${last_release_testing}\n${last_release_stable}" | sort -V | tail -n1)"
  echo "Last release was ${last_release}"
  if is_based_on "$last_release" "$GLUON_TAG"; then
    local_version="$(extract_local_version "$last_release")"
    local_version="$(($local_version + 1))"
  else
    # new gluon version => reset local version number
    local_version=1
  fi
  auto_determined_release="${GLUON_TAG}+${LOCAL_SUFFIX}${local_version}"
  read -p "Release name for this build [default: ${auto_determined_release}]: " GLUON_RELEASE
  GLUON_RELEASE="${GLUON_RELEASE:-$auto_determined_release}"

  cat > "$statefile" <<EOF
GLUON_TAG="${GLUON_TAG}"
GLUON_BRANCH="${GLUON_BRANCH}"
GLUON_RELEASE="${GLUON_RELEASE}"
EOF
fi

if [ "$GLUON_BRANCH" = "stable" ]; then
    export GLUON_PRIORITY=7
fi

# calculate number of threads
if [ -z "$debug" ]; then
    proc_num="$(($(grep -c '^processor\s' /proc/cpuinfo) + 1))"
else
    proc_num=1
fi

cd "$GLUON_DIR"
export GLUON_BRANCH GLUON_RELEASE
if ! $cont; then
  make update ${debug:+V=s}
fi

for target in ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic; do
  env_target="$(echo "$target" | tr '-' '_')"
  set +u
  if eval "[ \"\$TARGET_${env_target}_DONE\" = 1 ]"; then
    continue
  fi
  set -u
  echo "Building target ${target}"
  if $cont; then
    cont=false
  else
    make clean GLUON_TARGET="$target" ${debug:+V=s}
  fi
  make -j${proc_num} GLUON_TARGET="$target" ${debug:+V=s}
  echo "TARGET_${env_target}_DONE=1" >> "$statefile"
done
make manifest
make manifest GLUON_BRANCH=testing GLUON_PRIORITY=0
cd ..

if [ -n "$KEYFILE" -a -r "$KEYFILE" ]; then
  "${GLUON_DIR}/contrib/sign.sh" "$KEYFILE" "${GLUON_DIR}/output/images/sysupgrade/${GLUON_BRANCH}.manifest"
fi

rm "$statefile"
