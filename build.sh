#! /usr/bin/env sh

# environmental and build settings
KEYFILE="${KEYFILE:-"$HOME/.ecdsakey"}"
GLUON_PRIORITY="${GLUON_PRIORITY:-7}"
JOBS=${JOBS:-"$(grep -c '^processor' /proc/cpuinfo)"} 

# start of script
set -eu

# determine absolute path of site repository
if which realpath > /dev/null; then
    GLUON_SITEDIR="$(dirname "$(realpath "$0")")"
else
    GLUON_SITEDIR="$(dirname "$(readlink -f "$0")")"
fi
export GLUON_SITEDIR
GLUON_DIR="${GLUON_SITEDIR}/gluon/"

# start building
cd "${GLUON_DIR}"
make update V=s

GLUON_TARGETS=${GLUON_TARGETS:-"$(make list-targets)"}

for target in $GLUON_TARGETS; do
    echo "Building target ${target}"
    schedtool -B -e \
        make --jobs="$JOBS" --output-sync=recurse \
            GLUON_TARGET="$target" V=s
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
if [ -n "$KEYFILE" ] && [ -r "$KEYFILE" ]; then
    "${GLUON_DIR}/contrib/sign.sh" "$KEYFILE" \
        "${GLUON_DIR}/output/images/sysupgrade/testing.manifest"
fi
