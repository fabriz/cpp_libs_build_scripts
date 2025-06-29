#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libiconv 1.18

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ./config.h ... "
    sed -i.orig -e '/#define gid_t int/d' \
                -e '/#define uid_t int/d' ./config.h
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
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
        BUILD_PLATFORM="i686-w64-mingw32"
    else
        BUILD_PLATFORM="x86_64-w64-mingw32"
    fi

    local AUX_TOOLS="${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/build-aux"

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ./Makefile.in ... "
    sed -i.orig -e '/cd src && $(MAKE) all/d' \
                -e '/cd po && $(MAKE) all/d' \
                -e '/cd man && $(MAKE) all/d' \
                -e '/if test -d tests; then cd tests && $(MAKE) all; fi/d' \
                -e '/cd src && $(MAKE) install prefix='\''$(prefix)'\'' exec_prefix='\''$(exec_prefix)'\'' libdir='\''$(libdir)'\''/d' \
                -e '/cd po && $(MAKE) install prefix='\''$(prefix)'\'' exec_prefix='\''$(exec_prefix)'\'' datarootdir='\''$(datarootdir)'\'' datadir='\''$(datadir)'\''/d' \
                -e '/cd man && $(MAKE) install prefix='\''$(prefix)'\'' exec_prefix='\''$(exec_prefix)'\'' datarootdir='\''$(datarootdir)'\'' datadir='\''$(datadir)'\'' mandir='\''$(mandir)'\''/d' ./Makefile.in
    checkBuildStep

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ./lib/Makefile.in ... "
    sed -i.orig -e 's/OBJECTS_RES_yes = libiconv.res.lo/OBJECTS_RES_yes =/' \
                -e 's/OBJECTS_RES_no =/OBJECTS_RES_no = libiconv.res.lo/' ./lib/Makefile.in
    checkBuildStep

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${BUILD_PLATFORM} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} \
        CC="${AUX_TOOLS}/compile cl -nologo" \
        CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}" \
        CXX="${AUX_TOOLS}/compile cl -nologo" \
        CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}" \
        CPPFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}" \
        LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}" \
        LD="link" \
        NM="dumpbin -symbols" \
        STRIP=":" \
        AR="${AUX_TOOLS}/ar-lib lib" \
        RANLIB=":" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libcharset.la"
    deleteFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libiconv.la"
}


buildLibrary "LIBICONV"
