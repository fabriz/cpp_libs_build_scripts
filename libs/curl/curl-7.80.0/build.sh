#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for curl 7.80.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS=""

    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --enable-debug"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --disable-debug"
    fi

    if isLibraryInstalled "OPENSSL"; then
        echo "Enabling support for library openssl"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-openssl"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-ssl"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-libidn2 --without-nghttp2 --without-libpsl \
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
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
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS=""

    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} DEBUG=yes GEN_PDB=yes"
    elif [ ${FM_TARGET_BUILD_VARIANT} = "profile" ]; then
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} DEBUG=no GEN_PDB=yes"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} DEBUG=no GEN_PDB=no"
    fi

    cd ./winbuild

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} MakefileBuild.vc ... "
    sed -i.orig -e 's/$(BASE_NAME)_debug/$(BASE_NAME)/g' -e 's/$(BASE_NAME_STATIC)_debug/$(BASE_NAME_STATIC)/g' "./MakefileBuild.vc"
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake -f Makefile.vc mode=static WITH_DEVEL="${FM_LIBS_INSTALL_PREFIX_WINDOWS}" ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} \
        WITH_PREFIX="${FM_CURRENT_ARCHITECTURE_STAGE_DIR_WINDOWS}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "CURL"
