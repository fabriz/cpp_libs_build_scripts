#!/bin/bash

export FM_LIBS_BUILD_ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/utility.sh"

BLOCK_SEPARATOR="------------------------------------------------------------"

# Check command line parameters
if [ ! $# = 4 ]; then
    echo "Usage: $0 <libset> <toolchain> <architecture> <variant(s)>"
    printLibsets
    printToolchains
    exit 1
fi

# Load the selected libset
LIBSET_NAME="$(echo $1 | tr '[:upper:]' '[:lower:]')"
LIBSET_FILE="${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/libsets/${LIBSET_NAME}.sh"
printf "Loading libset ${LIBSET_NAME} ... "
if [ -f ${LIBSET_FILE} ]; then
    source "${LIBSET_FILE}"
    echo "OK"
else
    echo "NOT FOUND"
    printLibsets
    exit 1
fi

# Check libraries in the set
LIBS_CHECK_OK="true"
for LIB_TO_BUILD in "${FM_LIBS_TO_BUILD[@]}"
do
    printf "Checking ${LIB_TO_BUILD} ... "

    LIB_TO_BUILD_TAG="${LIB_TO_BUILD%%/*}"
    LIB_TO_BUILD_NAME="${LIB_TO_BUILD_TAG#*_}"
    LIB_TO_BUILD_VERSION="${LIB_TO_BUILD#*/}"
    LIB_INFO_FILE="${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/libs/${LIB_TO_BUILD_TAG}/${LIB_TO_BUILD_NAME}-${LIB_TO_BUILD_VERSION}/config.sh"

    if [ ! -f ${LIB_INFO_FILE} ]; then
        LIBS_CHECK_OK="false"
        echo "NOT FOUND"
    else
        source "${LIB_INFO_FILE}"
        if [ $? -ne 0 ]; then
            LIBS_CHECK_OK="false"
            echo "ERROR"
        else
            echo "OK"
        fi
    fi
done

if [ ${LIBS_CHECK_OK} = "false" ]; then
    error "Libraries check failed."
fi

# Build libraries in the set
for LIB_TO_BUILD in "${FM_LIBS_TO_BUILD[@]}"
do
    echo ${BLOCK_SEPARATOR}

    LIB_TO_BUILD_TAG="${LIB_TO_BUILD%%/*}"
    LIB_TO_BUILD_NAME="${LIB_TO_BUILD_TAG#*_}"
    LIB_TO_BUILD_VERSION="${LIB_TO_BUILD#*/}"

    ./libs/${LIB_TO_BUILD_TAG}/${LIB_TO_BUILD_NAME}-${LIB_TO_BUILD_VERSION}/build.sh "$@"
    if [ $? -ne 0 ]; then
        error "Build failed"
    fi
done

playBeep
echo ${BLOCK_SEPARATOR}
echo "OK: All libraries built successfully"
echo
