#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for boost 1.75.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${FM_TARGET_BUILD_FLAGS_FOR_BOOST-}"

    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} variant=debug"
    elif [ ${FM_TARGET_BUILD_VARIANT} = "release" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} variant=release"
    elif [ ${FM_TARGET_BUILD_VARIANT} = "profile" ]; then
        # Don't use "variant=profile" because it also introduces -pg for gcc
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} variant=release debug-symbols=on"
    else
        error "Unsupported build variant: ${FM_TARGET_BUILD_VARIANT}."
    fi

    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} include=${FM_LIBS_INSTALL_INCLUDES_WINDOWS} library-path=${FM_LIBS_INSTALL_LIBS_WINDOWS}"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} include=${FM_LIBS_INSTALL_INCLUDES} library-path=${FM_LIBS_INSTALL_LIBS}"
    fi

    if [ ${FM_CONFIG_VERBOSE_LOGS:-false} = true ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --debug-configuration --debug-building -d2"
    fi

    if isLibraryInstalled "BZIP2"; then
        echo "Enabling support for library bzip2"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export BZIP2_NAME="libbz2"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export BZIP2_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_BZIP2_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "XZ"; then
        echo "Enabling support for library xz/lzma"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export LZMA_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export LZMA_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export LZMA_NAME="libzlma"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export LZMA_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_XZ_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export LZMA_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export LZMA_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "ZLIB"; then
        echo "Enabling support for library zlib"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export ZLIB_NAME="zlib"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export ZLIB_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_ZLIB_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "ZSTD"; then
        echo "Enabling support for library zstd"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export ZSTD_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export ZSTD_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export ZSTD_NAME="libzstd"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export ZSTD_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_ZSTD_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export ZSTD_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export ZSTD_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "ICU4C"; then
        echo "Enabling support for library icu4c"
        export ICU_PATH="${FM_LIBS_INSTALL_PREFIX}"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --disable-icu"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    (
        unset AR
        unset CC
        unset CXX
        unset NM
        unset RANLIB
        unset CPPFLAGS
        unset CFLAGS
        unset CXXFLAGS
        unset LDFLAGS

        ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    )
    checkBuildStep

cat > ./user-cross-config.jam <<EOF
using gcc : ${FM_TARGET_ARCHITECTURE} : ${CXX} ;
EOF

    local TOOLSET_NAME="gcc"
    local CROSS_COMPILE_OPTIONS=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        TOOLSET_NAME="gcc-${FM_TARGET_ARCHITECTURE}"
        CROSS_COMPILE_OPTIONS="-sBOOST_BUILD_USER_CONFIG=./user-cross-config.jam"
    fi

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=${TOOLSET_NAME} ${CROSS_COMPILE_OPTIONS} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    (
        unset AR
        unset CC
        unset CXX
        unset NM
        unset RANLIB
        unset CPPFLAGS
        unset CFLAGS
        unset CXXFLAGS
        unset LDFLAGS

        ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    )
    checkBuildStep

cat > ./user-cross-config.jam <<EOF
using clang : ${FM_TARGET_ARCHITECTURE} : ${CXX} ;
EOF

    local TOOLSET_NAME="clang"
    local CROSS_COMPILE_OPTIONS=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        TOOLSET_NAME="clang-${FM_TARGET_ARCHITECTURE}"
        CROSS_COMPILE_OPTIONS="-sBOOST_BUILD_USER_CONFIG=./user-cross-config.jam"
    fi

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=${TOOLSET_NAME} ${CROSS_COMPILE_OPTIONS} address-model=${FM_TARGET_ADDRESS_MODEL} target-os=android cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} darwin.jam ... "
    sed -i.orig -e '/-fcoalesce-templates/d' -e '/-Wno-long-double/d' "./tools/build/src/tools/darwin.jam"
    checkBuildStep

    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=darwin address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    unset AR
    unset CC
    unset CXX
    unset NM
    unset RANLIB
    unset CPPFLAGS
    unset CFLAGS
    unset CXXFLAGS
    unset LDFLAGS

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} darwin.jam ... "
    sed -i.orig "s/-arch arm/-arch ${FM_IOS_SDK_ARCHITECTURE}/g" "./tools/build/src/tools/darwin.jam"
    checkBuildStep

    local BOOST_IOS_ARCH=""
    local BOOST_IOS_SDK=""
    if [ ${FM_IOS_CURRENT_SDK_NAME} = "iphoneos" ]; then
        BOOST_IOS_ARCH="arm"
        BOOST_IOS_SDK="iphone"
    else
        BOOST_IOS_ARCH="x86"
        BOOST_IOS_SDK="iphonesim"
    fi

cat > ./user-ios-config.jam <<EOF
using darwin : ${FM_IOS_SDK_VERSION}~${BOOST_IOS_SDK}
: ${FM_IOS_XCODE_ROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -arch ${FM_IOS_SDK_ARCHITECTURE} ${FM_TARGET_TOOLCHAIN_CFLAGS}
: <striper> <root>${FM_IOS_XCODE_ROOT}/Platforms/${FM_IOS_SDK_PLATFORM}.platform/Developer <architecture>${BOOST_IOS_ARCH} <target-os>iphone
;
EOF

    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -sBOOST_BUILD_USER_CONFIG=./user-ios-config.jam\
        -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=darwin-${FM_IOS_SDK_VERSION}~${BOOST_IOS_SDK} address-model=${FM_TARGET_ADDRESS_MODEL}\
        cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}" define=_LITTLE_ENDIAN\
        macosx-version=${BOOST_IOS_SDK}-${FM_IOS_SDK_VERSION} architecture=${BOOST_IOS_ARCH} target-os=iphone\
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
    ./b2 -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=gcc address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} ${PYTON_HEADER_FIX}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.bat > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_ARG_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
        --toolset=msvc-${FM_TARGET_COMPILER_VERSION} address-model=${FM_TARGET_ADDRESS_MODEL}\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "BOOST"

