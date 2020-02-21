#!/bin/bash
# Build script for icu4c 63.1

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/common.sh"


decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"

    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    prepareBuildStep "Decompressing ${LIB_TARBALL_LOCAL_PATH} ... "
    ${FM_CMD_TAR} -xz -f ${LIB_TARBALL_LOCAL_PATH} -C ${FM_CURRENT_LIB_SOURCE_DIR} || error "Cannot decompress file ${LIB_TARBALL_LOCAL_PATH} to ${FM_CURRENT_LIB_SOURCE_DIR}"
    checkBuildStep

    moveDirectory "${FM_CURRENT_LIB_SOURCE_DIR}/icu" "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

buildCurrentArchitecture__linux_gcc()
{
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${FM_TARGET_TOOLCHAIN_CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    cd ./source

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${FM_TARGET_TOOLCHAIN_CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    cd ./source

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-cross-build=/fabri_libs/build/linux_gcc_x64_release/source/icu4c-63_1/x64/source\
        --enable-tools=no --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    :
}

buildCurrentArchitecture__ios_clang()
{
    :
}

buildCurrentArchitecture__windows_mingw()
{
    :
}

buildCurrentArchitecture__windows_msvc()
{
    :
}


buildLibrary "ICU4C"
