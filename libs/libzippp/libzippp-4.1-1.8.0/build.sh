#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libzippp 4.1-1.8.0

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

    sed -i.orig -e 's/find_package(LIBZIP MODULE REQUIRED)/#find_package(LIBZIP MODULE REQUIRED)/' \
        -e 's/target_link_libraries/#target_link_libraries/' \
        -e 's/"libzippp_static"/"libzippp"/' ./CMakeLists.txt

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DBUILD_SHARED_LIBS=False -DLIBZIPPP_BUILD_TESTS=False \
        -DCMAKE_C_FLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}" -DCMAKE_CXX_FLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}" \
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "LIBZIPPP"
