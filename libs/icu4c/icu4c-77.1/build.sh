#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for icu4c 77.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    cd ./source
}

afterBuildCurrentArchitecture()
{
    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/icu"
}

buildCurrentArchitecture__linux_gcc()
{
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST} --with-cross-build=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source"
    fi

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --enable-dyload=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-cross-build=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source\
        --enable-dyload=no --enable-tools=no --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST} --with-cross-build=${FM_ARG_BUILD_ROOT}/macos_clang_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source"
    fi

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --enable-dyload=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-cross-build=${FM_ARG_BUILD_ROOT}/macos_clang_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source\
        --enable-dyload=no --enable-tools=no --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CXXFLAGS="${CXXFLAGS} -D__STDC_FORMAT_MACROS"

    sed -i.orig -e '9 i\STATIC_PREFIX =\nSTATIC_PREFIX_WHEN_USED =' \
        -e 's/ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/#ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/' \
        ./config/mh-mingw

    sed -i.orig -e '9 i\STATIC_PREFIX =\nSTATIC_PREFIX_WHEN_USED =' \
        -e 's/ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/#ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/' \
        ./config/mh-mingw64

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --enable-dyload=no --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    sed -i.orig -e '7 i\STATIC_PREFIX =\nSTATIC_PREFIX_WHEN_USED =' \
        -e 's/ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/#ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/' \
        ./config/mh-msys-msvc

    moveFileIfPresent "./config/mh-unknown" "./config/mh-unknown.orig"
    copyFile "./config/mh-msys-msvc" "./config/mh-unknown"

    export CC="cl"
    export CXX="cl"
    export CFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes \
        --enable-extras=no --enable-tools=no --enable-tests=no --enable-samples=no \
        --enable-dyload=no --with-data-packaging=static \
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}


buildLibrary "ICU4C"
