#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for argon2 2019.07.02

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


buildCurrentArchitecture__linux_gcc()
{
    export LIBRARY_REL="lib"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
    
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.so"
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.so.1"
}

buildCurrentArchitecture__android_clang()
{
    export LIBRARY_REL="lib"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
        
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.so"
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.so.1"
}

buildCurrentArchitecture__macos_clang()
{
    export LIBRARY_REL="lib"

    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="i386"
    elif [ ${FM_TARGET_ARCHITECTURE} = "x86_64" ]; then
        BUILD_PLATFORM="x86_64"
    elif [ ${FM_TARGET_ARCHITECTURE} = "arm64" ]; then
        BUILD_PLATFORM="aarch64"
    else
        error "Unsupported architecture: ${FM_TARGET_ARCHITECTURE}"
    fi

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} OPTTARGET=${BUILD_PLATFORM} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install OPTTARGET=${BUILD_PLATFORM} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.dylib"
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.1.dylib"
}

buildCurrentArchitecture__ios_clang()
{
    export LIBRARY_REL="lib"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.dylib"
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.1.dylib"
}

buildCurrentArchitecture__windows_mingw()
{
    export LIBRARY_REL="lib"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libargon2.dll"
}

#buildCurrentArchitecture__windows_msvc()
#{
#}


buildLibrary "ARGON2"
