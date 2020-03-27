#!/bin/bash

export FM_LIBS_BUILD_ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/utility.sh"

BLOCK_SEPARATOR="------------------------------------------------------------"

# Check command line parameters
if [ ! $# = 2 ]; then
    echo "Usage: $0 LIBNAME/LIBVERSION <variant(s)>"
    printLibsets
    exit 1
fi

LIB_TO_BUILD="$(echo $1 | tr '[:upper:]' '[:lower:]')"
LIB_TO_BUILD_NAME="${LIB_TO_BUILD%%/*}"
LIB_TO_BUILD_VERSION="${LIB_TO_BUILD#*/}"
LIB_INFO_FILE="${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/libs/${LIB_TO_BUILD_NAME}/${LIB_TO_BUILD_NAME}-${LIB_TO_BUILD_VERSION}/config.sh"

# Check library
LIBS_CHECK_OK="true"
printf "Checking ${LIB_TO_BUILD} ... "
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

if [ ${LIBS_CHECK_OK} = "false" ]; then
    error "Library check failed."
fi

echo ${BLOCK_SEPARATOR}

# Build library
./libs/${LIB_TO_BUILD_NAME}/${LIB_TO_BUILD_NAME}-${LIB_TO_BUILD_VERSION}/build.sh "${FM_GLOBAL_TOOLCHAIN}" "${FM_GLOBAL_ARCHITECTURE}" "$2"
if [ $? -ne 0 ]; then
    error "Build failed"
fi

echo ${BLOCK_SEPARATOR}
echo "OK: All libraries built successfully"
echo

success
