#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for curl 8.10.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    # Avoid the "-d" suffix for debug libraries
    sed -i.orig 's/CMAKE_DEBUG_POSTFIX "-d"/CMAKE_DEBUG_POSTFIX ""/' ./CMakeLists.txt

    configureCMakeOutOfSourceBuild
    
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="-DBUILD_SHARED_LIBS=False -DBUILD_STATIC_LIBS=True -DUSE_NGHTTP2=False -DCURL_USE_LIBPSL=False"
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"
    
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DENABLE_UNICODE=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
    
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}


buildLibrary "CURL"
