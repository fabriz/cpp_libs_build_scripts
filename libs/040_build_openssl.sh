#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


afterBuildCurrentArchitecture()
{
    mv "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"/lib/engines* "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"
}

buildCurrentArchitecture__linux_gcc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="linux-x86"
    else
        BUILD_PLATFORM="linux-x86_64"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./Configure ${BUILD_PLATFORM} no-shared no-asm --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="darwin-i386-cc"
    else
        BUILD_PLATFORM="darwin64-x86_64-cc"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./Configure ${BUILD_PLATFORM} no-shared no-asm --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="mingw"
    else
        BUILD_PLATFORM="mingw64"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./Configure ${BUILD_PLATFORM} no-shared no-asm --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"
    
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="VC-WIN32"
    else
        BUILD_PLATFORM="VC-WIN64A"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./Configure ${BUILD_PLATFORM} no-shared no-asm --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}


buildLibrary "OPENSSL"

