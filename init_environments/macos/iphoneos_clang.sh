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

export FM_TARGET_IOS_PLATFORM=iPhoneOS
export FM_TARGET_IOS_SDK=iphoneos
export FM_TARGET_OS_TYPE=ios
export FM_TARGET_COMPILER=clang
export FM_TARGET_TOOLCHAIN=ios_clang
export FM_TARGET_PLATFORM=${FM_TARGET_IOS_SDK}_clang
export FM_TARGET_CMAKE_GENERATOR="Unix Makefiles"
export FM_TARGET_CMAKE_TOOLCHAIN_FILE="${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/../../core/toolchains/cmake/ios.toolchain.cmake"
export FM_TARGET_HAS_PKGCONFIG=false
#export FM_TARGET_ALL_ARCHITECTURES=arm64,armv7,armv7s,fat
export FM_TARGET_ALL_ARCHITECTURES=arm64,fat
export FM_TARGET_ALL_BUILD_VARIANTS=release,debug,profile

export FM_TARGET_TOOLCHAIN_COMMON_CFLAGS="-fPIC -fvisibility=hidden -fvisibility-inlines-hidden -Wextra -Wall -W"
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

export FM_TARGET_COMPILER_VERSION="$(xcrun -sdk ${FM_TARGET_IOS_SDK} clang -dumpversion)"

export FM_TARGET_BUILD_FLAGS_FOR_BOOST="--without-process"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
