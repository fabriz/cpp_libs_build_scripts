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

export PATH=${FM_CONFIG_ANDROID_NDK_INSTALL_PATH}/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH

export FM_TARGET_OS_TYPE=android
export FM_TARGET_COMPILER=clang
export FM_TARGET_TOOLCHAIN=android_clang
export FM_TARGET_PLATFORM="android_clang_api${FM_CONFIG_ANDROID_API_LEVEL}"
export FM_TARGET_CMAKE_TOOLCHAIN_FILE="${FM_CONFIG_ANDROID_NDK_INSTALL_PATH}/build/cmake/android.toolchain.cmake"
export FM_TARGET_HAS_PKGCONFIG=false
export FM_TARGET_ALL_ARCHITECTURES=armv7,armv8,x86,x86_64
export FM_TARGET_ALL_BUILD_VARIANTS=debug,release,profile

export FM_TARGET_COMPILER_VERSION="$(clang -dumpversion)"

export FM_TARGET_BUILD_FLAGS_FOR_BOOST="--without-python"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
