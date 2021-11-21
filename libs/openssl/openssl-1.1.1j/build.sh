#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for openssl 1.1.1j

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


afterBuildCurrentArchitecture()
{
    moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"/lib/engines* "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"
}

buildCurrentArchitecture__linux_gcc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="linux-x86"
    elif [ ${FM_TARGET_ARCHITECTURE} = "x86_64" ]; then
        BUILD_PLATFORM="linux-x86_64"
    elif [ ${FM_TARGET_ARCHITECTURE} = "armv7" ]; then
        BUILD_PLATFORM="linux-generic32"
    elif [ ${FM_TARGET_ARCHITECTURE} = "armv8" ]; then
        BUILD_PLATFORM="linux-generic64"
    else
        error "Unsupported architecture: ${FM_TARGET_ARCHITECTURE}"
    fi

    export CROSS_COMPILE=""

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "armv7" ]; then
        BUILD_PLATFORM="linux-generic32"
    elif [ ${FM_TARGET_ARCHITECTURE} = "armv8" ]; then
        BUILD_PLATFORM="linux-generic64"
    elif [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="linux-generic32"
    elif [ ${FM_TARGET_ARCHITECTURE} = "x86_64" ]; then
        BUILD_PLATFORM="linux-generic64"
    else
        error "Unsupported architecture: ${FM_TARGET_ARCHITECTURE}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="darwin-i386-cc"
    else
        BUILD_PLATFORM="darwin64-x86_64-cc"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    local BUILD_PLATFORM=""
    case ${FM_IOS_SDK_ARCHITECTURE} in
        armv7)
            BUILD_PLATFORM="ios-cross-armv7"
        ;;
        armv7s)
            BUILD_PLATFORM="ios-cross-armv7s"
        ;;
        arm64)
            BUILD_PLATFORM="ios64-cross-arm64"
        ;;
        x86)
            BUILD_PLATFORM="ios-sim-cross-i386"
        ;;
        x86_64)
            BUILD_PLATFORM="ios-sim-cross-x86_64"
        ;;
        *)
            error "Unsupported architecture: ${FM_IOS_SDK_ARCHITECTURE}"
        ;;
    esac

    export CROSS_TOP="${FM_IOS_XCODE_ROOT}/Platforms/${FM_IOS_SDK_PLATFORM}.platform/Developer"
    export CROSS_SDK="${FM_IOS_SDK_PLATFORM}.sdk"

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} configuration ... "
    cp "${FM_PATH_SCRIPTS_ROOT_DIRECTORY}/support/openssl/20-ios-tvos-cross.conf" "./Configurations/"
    checkBuildStep

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared no-dso no-hw no-engine --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="mingw"
    else
        BUILD_PLATFORM="mingw64"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="VC-WIN32"
    else
        BUILD_PLATFORM="VC-WIN64A"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PERL_WINDOWS_COMMAND}" ./Configure ${BUILD_PLATFORM} no-shared no-asm --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --openssldir=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/openssl > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}


buildLibrary "OPENSSL"
