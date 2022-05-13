#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for thrift 0.11.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    # Avoid the "d" suffix for debug libraries
    sed -i.orig 's/CMAKE_DEBUG_POSTFIX "d"/CMAKE_DEBUG_POSTFIX ""/' ./build/cmake/ThriftMacros.cmake
}

afterBuildCurrentArchitecture()
{
    local CONFIG_FILE="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/thrift/config.h"

    if [ -f "${CONFIG_FILE}" ]; then
        sed -i.orig 's/\/\* #undef USE_STD_THREAD \*\//#define USE_STD_THREAD 1/' "${CONFIG_FILE}"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS} \
        -DWITH_STDTHREADS=ON -DWITH_LIBEVENT=OFF -DWITH_SHARED_LIB=OFF -DWITH_STATIC_LIB=ON -DWITH_CPP=ON \
        -DWITH_C_GLIB=OFF -DWITH_JAVA=OFF -DWITH_PYTHON=OFF -DWITH_PERL=OFF  -DWITH_BOOST_STATIC=ON \
        -DBUILD_COMPILER=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_TUTORIALS=OFF > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS} \
        -DWITH_STDTHREADS=ON -DWITH_LIBEVENT=OFF -DWITH_SHARED_LIB=OFF -DWITH_STATIC_LIB=ON -DWITH_CPP=ON \
        -DWITH_C_GLIB=OFF -DWITH_JAVA=OFF -DWITH_PYTHON=OFF -DWITH_PERL=OFF -DWITH_BOOST_STATIC=ON \
        -DBUILD_COMPILER=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_TUTORIALS=OFF > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS} \
        -DWITH_STDTHREADS=ON -DWITH_LIBEVENT=OFF -DWITH_SHARED_LIB=OFF -DWITH_STATIC_LIB=ON -DWITH_CPP=ON \
        -DWITH_C_GLIB=OFF -DWITH_JAVA=OFF -DWITH_PYTHON=OFF -DWITH_PERL=OFF -DWITH_BOOST_STATIC=ON \
        -DBUILD_COMPILER=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_TUTORIALS=OFF > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__ios_clang()
#{
#}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS} \
        -DWITH_STDTHREADS=ON -DWITH_LIBEVENT=OFF -DWITH_SHARED_LIB=OFF -DWITH_STATIC_LIB=ON -DWITH_CPP=ON \
        -DWITH_JAVA=OFF -DWITH_PYTHON=OFF -DWITH_PERL=OFF -DWITH_BOOST_STATIC=ON \
        -DBUILD_COMPILER=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_TUTORIALS=OFF > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS} \
        -DWITH_STDTHREADS=ON -DWITH_LIBEVENT=OFF -DWITH_SHARED_LIB=OFF -DWITH_STATIC_LIB=ON -DWITH_CPP=ON \
        -DWITH_JAVA=OFF -DWITH_PYTHON=OFF -DWITH_PERL=OFF -DWITH_BOOST_STATIC=ON \
        -DBUILD_COMPILER=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_TUTORIALS=OFF > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
    
    /usr/bin/find ./lib/cpp -name "*.pdb" -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/ ';'    
}


buildLibrary "THRIFT"
