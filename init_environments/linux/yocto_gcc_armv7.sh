#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

export FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/vars.sh"

source "${FM_CONFIG_YOCTO_ARMV7_ENVIRONMENT_INIT_SCRIPT}"

export FM_TARGET_COMPILER_VERSION="$(${CC} -dumpversion)"
if [ ${#FM_TARGET_COMPILER_VERSION} -le 2 ]; then
    export FM_TARGET_COMPILER_VERSION="$(${CC} -dumpfullversion)"
fi

export FM_TARGET_OS_TYPE=linux
export FM_TARGET_COMPILER=gcc
export FM_TARGET_TOOLCHAIN=linux_gcc
export FM_TARGET_PLATFORM="yocto_gcc${FM_TARGET_COMPILER_VERSION}"
export FM_TARGET_CMAKE_GENERATOR="Unix Makefiles"
export FM_TARGET_CMAKE_TOOLCHAIN_FILE="${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/../../core/toolchains/cmake/yocto.toolchain.cmake"
export FM_TARGET_HAS_PKGCONFIG=true
export FM_TARGET_CROSS_COMPILER_HOST=arm-poky-linux-gnueabi
export FM_TARGET_ALL_ARCHITECTURES=armv7
export FM_TARGET_ALL_BUILD_VARIANTS=debug,release,profile
export FM_TARGET_IS_CROSS_COMPILING=true

export FM_TARGET_TOOLCHAIN_AR="${AR}"
export FM_TARGET_TOOLCHAIN_CC="${CC}"
export FM_TARGET_TOOLCHAIN_CXX="${CXX}"
export FM_TARGET_TOOLCHAIN_NM="${NM}"
export FM_TARGET_TOOLCHAIN_RANLIB="${RANLIB}"

export FM_TARGET_TOOLCHAIN_COMMON_CPPFLAGS="${CPPFLAGS-}"
export FM_TARGET_TOOLCHAIN_COMMON_CFLAGS="${CFLAGS-}"
export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="${CXXFLAGS-}"
export FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS="${LDFLAGS-}"

export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_DEBUG="-g"
export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_RELEASE="-O2"
export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_PROFILE="-O2 -g"

case ${FM_CONFIG_CXX_STANDARD} in
    14)
        export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="${FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS} -std=c++14"
    ;;
    17)
        export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="${FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS} -std=c++17"
    ;;
    20)
        export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="${FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS} -std=c++20"
    ;;
    *)
        echo "ERROR: Invalid C++ standard '${FM_CONFIG_CXX_STANDARD}'."
        exit 1
    ;;
esac

export FM_TARGET_BUILD_FLAGS_FOR_BOOST="--without-python"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
