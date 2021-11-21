#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libpng 1.6.37

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


afterBuildCurrentArchitecture()
{
    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/png.h"
    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/pngconf.h"
    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/pnglibconf.h"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/libpng16/png.h" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/png.h"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/libpng16/pngconf.h" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/pngconf.h"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/libpng16/pnglibconf.h" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/pnglibconf.h"

    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng.a"
    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng.la"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng16.a" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng.a"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng16.la" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng.la"

    deleteFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig/libpng.pc"
    copyFile "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig/libpng16.pc" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig/libpng.pc"
    sed -i.to_patch -e 's/png16/png/' -e 's+/include/libpng+/include+' "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig/libpng.pc"

    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libpng"
}

buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared --prefix="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --disable-shared --prefix="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" --disable-shared --prefix="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__windows_msvc()
#{
#    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"
#
#    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    "${FM_CONFIG_CMAKE_COMMAND}" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} \
#        -DPNG_SHARED=False -DPNG_STATIC=True -DPNG_TESTS=False \
#        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
#        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
#    checkBuildStep

#    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
#    checkBuildStep

#    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
#    checkBuildStep
#}


buildLibrary "LIBPNG"
