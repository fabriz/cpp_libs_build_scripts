#!/bin/bash


FM_BUILD_ALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_BUILD_ALL_SCRIPT_DIR}/utility.sh"


LIBS_TO_BUILD=(
    010_build_zlib
    020_build_bzip2
    030_build_sqlite
    040_build_openssl
    050_build_boost
    060_build_botan
    070_build_odb
    080_build_odb_sqlite
    090_build_odb_boost
    100_build_thrift
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
