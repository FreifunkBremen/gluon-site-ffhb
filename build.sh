#! /usr/bin/env sh

# environmental and build settings
KEYFILE="${KEYFILE:-"$HOME/.ecdsakey"}"
export BROKEN=1
GLUON_TARGETS="${GLUON_TARGETS:-"ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-64 ramips-mt7621"}"
GLUON_PRIORITY="${GLUON_PRIORITY:-7}"

# start of script
set -eu

# determine absolute path of site repository
if which realpath > /dev/null; then
    export GLUON_SITEDIR="$(dirname "$(realpath "$0")")"
else
    export GLUON_SITEDIR="$(dirname "$(readlink -f "$0")")"
fi
GLUON_DIR="${GLUON_SITEDIR}/gluon/"

# start building
cd "${GLUON_DIR}"
make update V=s

if [ -z "${GLUON_TARGETS:-}" ]; then
    GLUON_TARGETS="$(make list-targets)"
fi

for target in $GLUON_TARGETS; do
    echo "Building target ${target}"
    schedtool -B -e \
        make --jobs=$(grep -c '^processor' /proc/cpuinfo) GLUON_TARGET="$target" || \
        make -j1 --output-sync=recurse GLUON_TARGET="$target" V=s
done

# generate manifests
make manifest

if [ -z "${GLUON_BRANCH:-}" ]; then
    make manifest GLUON_BRANCH=testing GLUON_PRIORITY=0
    # add BRANCH=nightly line below BRANCH=testing line
    sed -i -e "/^BRANCH=testing/ a BRANCH=nightly" \
        "${GLUON_DIR}/output/images/sysupgrade/testing.manifest"
    ln -sf testing.manifest "${GLUON_DIR}/output/images/sysupgrade/nightly.manifest"
    ln -sf testing.manifest "${GLUON_DIR}/output/images/sysupgrade/manifest"
fi

# sign testing/nightly manifest if key is present
if [ -n "$KEYFILE" -a -r "$KEYFILE" ]; then
    "${GLUON_DIR}/contrib/sign.sh" "$KEYFILE" \
        "${GLUON_DIR}/output/images/sysupgrade/testing.manifest"
fi
