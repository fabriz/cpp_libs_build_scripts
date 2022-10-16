#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for wt 4.2.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    # Avoid the "d" suffix for debug libraries
    sed -i.orig 's/DEBUG_LIB_POSTFIX "d"/DEBUG_LIB_POSTFIX ""/' ./CMakeLists.txt

    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/Wt/Dbo/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/Wt/Dbo/backend/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/fcgi/CMakeLists.txt
    sed -i.orig -e 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' -e '/Android.C/d' ./src/http/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/isapi/CMakeLists.txt
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSHARED_LIBS=False -DBoost_USE_STATIC_LIBS=True -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True \
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False \
        -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSHARED_LIBS=False -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True \
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False \
        -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSHARED_LIBS=False -DBoost_USE_STATIC_LIBS=True -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True \
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False \
        -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__ios_clang()
#{
#    :
#}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSHARED_LIBS=False -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True -DWT_WRASTERIMAGE_IMPLEMENTATION=none \
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False \
        -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE} -UUNICODE -U_UNICODE"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSHARED_LIBS=False -DBOOST_PREFIX=${FM_LIBS_INSTALL_PREFIX} -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True \
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False \
        -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    /usr/bin/find ./src -name "*.pdb" -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/ ';'
}


buildLibrary "WT"
