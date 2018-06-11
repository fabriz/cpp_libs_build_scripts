#!/bin/bash


FM_BUILD_ALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_BUILD_ALL_SCRIPT_DIR}/utility.sh"


LIBS_TO_BUILD=(
    0100_build_zlib
    0110_build_bzip2
    0200_build_sqlite
    0300_build_openssl
    1100_build_boost
    1200_build_botan
    1300_build_odb
    1310_build_odb_sqlite
    1320_build_odb_boost
    1400_build_thrift
    1900_build_ical
)


# Check command line parameters
if [ ! $# = 3 ]; then
    echo "Usage: $0 <toolchain> <architecture> <variant(s)>"
    printToolchains
    exit 1
fi


BLOCK_SEPARATOR="------------------------------------------------------------"


for LIB_TO_BUILD in "${LIBS_TO_BUILD[@]}"
do
    echo ${BLOCK_SEPARATOR}
    ./libs/${LIB_TO_BUILD}.sh "$@"
    if [ $? -ne 0 ]; then
        error "Build failed"
    fi
done

playBeep
echo ${BLOCK_SEPARATOR}
echo "OK: All libraries built successfully"
echo
