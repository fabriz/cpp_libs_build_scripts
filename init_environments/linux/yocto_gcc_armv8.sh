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

source "${FM_CONFIG_YOCTO_ARMV8_ENVIRONMENT_INIT_SCRIPT}"

export FM_TARGET_OS_TYPE=linux
export FM_TARGET_COMPILER=gcc
export FM_TARGET_TOOLCHAIN=linux_gcc
export FM_TARGET_PLATFORM=yocto_gcc
export FM_TARGET_HAS_PKGCONFIG=true
export FM_TARGET_CROSS_COMPILER_HOST=aarch64-poky-linux
export FM_TARGET_ALL_ARCHITECTURES=armv8
export FM_TARGET_ALL_BUILD_VARIANTS=debug,release,profile

export FM_TARGET_TOOLCHAIN_AR="${AR}"
export FM_TARGET_TOOLCHAIN_CC="${CC}"
export FM_TARGET_TOOLCHAIN_CXX="${CXX}"
export FM_TARGET_TOOLCHAIN_NM="${NM}"
export FM_TARGET_TOOLCHAIN_RANLIB="${RANLIB}"

export FM_TARGET_TOOLCHAIN_COMMON_CFLAGS="${CFLAGS}"
export FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS="-std=gnu++1y ${CXXFLAGS}"
export FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS="${LDFLAGS}"

export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_DEBUG="-g"
export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_RELEASE="-O2"
export FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_PROFILE="-O2 -g"

export FM_TARGET_COMPILER_VERSION="$(${FM_TARGET_TOOLCHAIN_CC} -dumpversion)"
if [ ${#FM_TARGET_COMPILER_VERSION} -le 2 ]; then
    export FM_TARGET_COMPILER_VERSION="$(${FM_TARGET_TOOLCHAIN_CC} -dumpfullversion)"
fi

export FM_TARGET_BUILD_FLAGS_FOR_BOOST="--without-python"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
