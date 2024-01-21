#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for botan2 2.18.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS=""

    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --debug-mode"
    fi

    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-external-includedir=${FM_LIBS_INSTALL_INCLUDES_WINDOWS} --with-external-libdir=${FM_LIBS_INSTALL_LIBS_WINDOWS}"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-external-includedir=${FM_LIBS_INSTALL_INCLUDES} --with-external-libdir=${FM_LIBS_INSTALL_LIBS}"
    fi

    if isLibraryInstalled "BZIP2"; then
        echo "Enabling support for library bzip2"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-bzip2"
    fi

    if isLibraryInstalled "XZ"; then
        echo "Enabling support for library xz/lzma"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-lzma"
    fi

    if isLibraryInstalled "ZLIB"; then
        echo "Enabling support for library zlib"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-zlib"
    fi

    if isLibraryInstalled "SQLITE"; then
        echo "Enabling support for library sqlite"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-sqlite3"
    fi

    if isLibraryInstalled "OPENSSL"; then
        echo "Enabling support for library openssl"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-openssl"
    fi

    if isLibraryInstalled "BOOST"; then
        echo "Enabling support for library boost"
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-boost"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --boost-library-name=libboost_system --boost-library-name=libboost_date_time"
        fi
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=linux --cc=gcc --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=android --cc=clang --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=macos --cc=clang --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local BUILD_PLATFORM=""
    case ${FM_IOS_SDK_ARCHITECTURE} in
        armv7)
            BUILD_PLATFORM="armv7"
        ;;
        armv7s)
            BUILD_PLATFORM="armv7s"
        ;;
        arm64)
            BUILD_PLATFORM="armv8-a"
        ;;
        x86)
            BUILD_PLATFORM="i386"
        ;;
        x86_64)
            BUILD_PLATFORM="x86_64"
        ;;
        *)
            error "Unsupported architecture: ${FM_IOS_SDK_ARCHITECTURE}"
        ;;
    esac

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=ios --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=mingw --cc=gcc --cpu=${FM_TARGET_ARCHITECTURE}\
        --build-targets=static --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --without-stack-protector --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_WINDOWS_COMMAND}" ./configure.py --os=windows --cc=msvc --cpu=${FM_TARGET_ARCHITECTURE} --cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} -DBOOST_ALL_NO_LIB -UUNICODE"\
        --build-targets=static --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --link-method=copy --without-documentation --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    sed -E -i.orig 's/LIB_FLAGS( +)=(.+)/LIB_FLAGS = \/Fd\"build\/botan.pdb\"/' ./Makefile

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_NMAKE_COMMAND}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_NMAKE_COMMAND}" install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    copyFileIfPresent build/botan.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
}


buildLibrary "BOTAN2"
