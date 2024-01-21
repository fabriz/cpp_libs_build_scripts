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

export FM_TARGET_OS_TYPE=macos
export FM_TARGET_COMPILER=clang
export FM_TARGET_TOOLCHAIN=macos_clang
export FM_TARGET_PLATFORM=macos_clang
export FM_TARGET_CMAKE_GENERATOR="Unix Makefiles"
export FM_TARGET_CMAKE_TOOLCHAIN_FILE="${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/../../core/toolchains/cmake/macos.toolchain.cmake"
export FM_TARGET_HAS_PKGCONFIG=false
export FM_TARGET_ALL_ARCHITECTURES=x86_64,arm64,fat
export FM_TARGET_ALL_BUILD_VARIANTS=release,debug,profile

export FM_TARGET_TOOLCHAIN_AR=ar
export FM_TARGET_TOOLCHAIN_CC=clang
export FM_TARGET_TOOLCHAIN_CXX=clang++
export FM_TARGET_TOOLCHAIN_NM=nm
export FM_TARGET_TOOLCHAIN_RANLIB=ranlib

export FM_TARGET_TOOLCHAIN_COMMON_CFLAGS="-fPIC -Wextra -Wall -W -mmacosx-version-min=10.15"
export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="-stdlib=libc++"
export FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS=""

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

export FM_TARGET_COMPILER_VERSION="$(clang -dumpversion)"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
