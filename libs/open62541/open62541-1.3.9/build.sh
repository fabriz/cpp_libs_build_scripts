#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for open62541 1.3.9

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"

beforeBuildCurrentArchitecture()
{
    configureCMakeOutOfSourceBuild

    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="-DUA_NAMESPACE_ZERO=FULL -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=False"

    if [ -n "${FM_OPC_UA_NODESETS-}" ]; then
        echo "Setting OPC-UA nodeset directory to: ${FM_OPC_UA_NODESETS}"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -Dopen62541_NODESET_DIR=${FM_OPC_UA_NODESETS}"
    fi

    if isLibraryInstalled "OPENSSL"; then
        echo "Enabling support for library OpenSSL"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DUA_ENABLE_ENCRYPTION=OPENSSL"
    elif isLibraryInstalled "MBEDTLS"; then
        echo "Enabling support for library MbedTLS"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DUA_ENABLE_ENCRYPTION=MBEDTLS"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DUA_ENABLE_ENCRYPTION=OFF"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        -DBUILD_SHARED_LIBS=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        -DBUILD_SHARED_LIBS=False -DUA_FORCE_WERROR=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        -DBUILD_SHARED_LIBS=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        -DBUILD_SHARED_LIBS=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__windows_mingw()
#{
#    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
#        -DBUILD_SHARED_LIBS=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
#    checkBuildStep
#
#    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
#    checkBuildStep
#
#    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
#    checkBuildStep
#}

buildCurrentArchitecture__windows_msvc()
{
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"

    export Python3_ROOT_DIR="${FM_CONFIG_PYTHON_WINDOWS_INSTALLATION_PATH}"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        -DUA_MSVC_FORCE_STATIC_CRT=False \
        -DBUILD_SHARED_LIBS=False -DUA_BUILD_EXAMPLES=False -DUA_BUILD_UNIT_TESTS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}


buildLibrary "OPEN62541"
