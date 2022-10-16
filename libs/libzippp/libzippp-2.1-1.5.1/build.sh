#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libzippp 2.1-1.5.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


afterBuildCurrentArchitecture()
{
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile src/libzippp.h ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include

    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        copyFile libzippp.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
        copyFileIfPresent ./CMakeFiles/libzippp.dir/libzippp.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    else
        copyFile libzippp.a ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    fi

    checkBuildStep
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_ARG_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_ARG_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_ARG_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__ios_clang()
#{
#    :
#}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_ARG_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"

    # Build just the static library
    sed -i.orig 's/ADD_LIBRARY(libzippp_static/ADD_LIBRARY(libzippp/' ./CMakeLists.txt
    sed -i.orig 's/ADD_LIBRARY(libzippp_shared/#ADD_LIBRARY(libzippp_shared/' ./CMakeLists.txt
    sed -i.orig 's/ADD_EXECUTABLE/#ADD_EXECUTABLE/' ./CMakeLists.txt
    sed -i.orig 's/SET_TARGET_PROPERTIES/#SET_TARGET_PROPERTIES/' ./CMakeLists.txt
    sed -i.orig '/TARGET_LINK_LIBRARIES(/,/)/d' ./CMakeLists.txt

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DBUILD_SHARED_LIBS=False -DLIBZIPPP_BUILD_TESTS=False \
        -DCMAKE_C_FLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}" -DCMAKE_CXX_FLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "LIBZIPPP"
