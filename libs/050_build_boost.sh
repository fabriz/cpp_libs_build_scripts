#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


# Useful bjam flags
# --debug-configuration
# --reconfigure

beforeBuildCurrentArchitecture()
{
    isLibraryInstalled "BZIP2"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library bzip2"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export BZIP2_NAME="libbz2"
        else
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    isLibraryInstalled "ZLIB"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library zlib"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export ZLIB_NAME="zlib"
        else
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths --disable-icu\
        --toolset=gcc variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths --disable-icu\
        --toolset=darwin variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    local PYTON_HEADER_FIX="-D_hypot=hypot"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths\
        --toolset=gcc variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} ${PYTON_HEADER_FIX}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.bat > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=versioned --abbreviate-paths\
        --toolset=msvc-${FM_TARGET_TOOLCHAIN_VERSION} variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL}\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    local BASE_INCLUDE_DIR="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include"
    mv ${BASE_INCLUDE_DIR}/boost-*/boost ${BASE_INCLUDE_DIR}
    rmdir ${BASE_INCLUDE_DIR}/boost-*
}


buildLibrary "BOOST"

