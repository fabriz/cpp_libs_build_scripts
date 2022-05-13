#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

initToolchain()
{
    local LOCAL_ARCHITECTURE=""
    local LOCAL_ADDRESS_MODEL=""
    local LOCAL_CROSS_COMPILER_HOST=""
    local LOCAL_CROSS_COMPILER_ROOT_NAME=""
    local LOCAL_BUILD_VARIANT=""

    local LOCAL_COMMON_CPPFLAGS=""
    local LOCAL_COMMON_CFLAGS=""
    local LOCAL_COMMON_CXXFLAGS=""
    local LOCAL_COMMON_LDFLAGS=""
    local LOCAL_ARCHITECTURE_CFLAGS=""
    local LOCAL_ARCHITECTURE_CXXFLAGS=""
    local LOCAL_ARCHITECTURE_LDFLAGS=""
    local LOCAL_BUILD_VARIANT_CFLAGS=""
    local LOCAL_BUILD_VARIANT_CXXFLAGS=""
    local LOCAL_BUILD_VARIANT_LDFLAGS=""
    local LOCAL_TARGET_ANDROID_ABI=""

    case ${FM_ARG_ARCHITECTURE} in
        armv7)
            LOCAL_ARCHITECTURE="armv7"
            LOCAL_ARCHITECTURE_CFLAGS=""
            LOCAL_ADDRESS_MODEL="32"
            LOCAL_CROSS_COMPILER_HOST="arm-linux-androideabi"
            LOCAL_CROSS_COMPILER_ROOT_NAME="armv7a-linux-androideabi"${FM_CONFIG_ANDROID_API_LEVEL}
            LOCAL_TARGET_ANDROID_ABI="armeabi-v7a"
        ;;
        armv8)
            LOCAL_ARCHITECTURE="armv8"
            LOCAL_ARCHITECTURE_CFLAGS=""
            LOCAL_ADDRESS_MODEL="64"
            LOCAL_CROSS_COMPILER_HOST="aarch64-linux-android"
            LOCAL_CROSS_COMPILER_ROOT_NAME="aarch64-linux-android"${FM_CONFIG_ANDROID_API_LEVEL}
            LOCAL_TARGET_ANDROID_ABI="arm64-v8a"
        ;;
        x86)
            LOCAL_ARCHITECTURE="x86"
            LOCAL_ARCHITECTURE_CFLAGS="-mstackrealign"
            LOCAL_ADDRESS_MODEL="32"
            LOCAL_CROSS_COMPILER_HOST="i686-linux-android"
            LOCAL_CROSS_COMPILER_ROOT_NAME="i686-linux-android"${FM_CONFIG_ANDROID_API_LEVEL}
            LOCAL_TARGET_ANDROID_ABI="x86"
        ;;
        x86_64)
            LOCAL_ARCHITECTURE="x86_64"
            LOCAL_ARCHITECTURE_CFLAGS=""
            LOCAL_ADDRESS_MODEL="64"
            LOCAL_CROSS_COMPILER_HOST="x86_64-linux-android"
            LOCAL_CROSS_COMPILER_ROOT_NAME="x86_64-linux-android"${FM_CONFIG_ANDROID_API_LEVEL}
            LOCAL_TARGET_ANDROID_ABI="x86_64"
        ;;
        *)
            error "Invalid architecture '${FM_ARG_ARCHITECTURE}'."
        ;;
    esac

    case ${FM_ARG_BUILD_VARIANT} in
        debug)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            case ${FM_ARG_ARCHITECTURE} in
                armv7)
                    LOCAL_BUILD_VARIANT_CFLAGS="-g -O0 -marm"
                ;;
                armv8)
                    LOCAL_BUILD_VARIANT_CFLAGS="-g -O0"
                ;;
                x86)
                    LOCAL_BUILD_VARIANT_CFLAGS="-g -O0"
                ;;
                x86_64)
                    LOCAL_BUILD_VARIANT_CFLAGS="-g -O0"
                ;;
            esac
        ;;
        release)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            case ${FM_ARG_ARCHITECTURE} in
                armv7)
                    LOCAL_BUILD_VARIANT_CFLAGS="-Oz -mthumb"
                ;;
                armv8)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2"
                ;;
                x86)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2"
                ;;
                x86_64)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2"
                ;;
            esac
        ;;
        profile)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            case ${FM_ARG_ARCHITECTURE} in
                armv7)
                    LOCAL_BUILD_VARIANT_CFLAGS="-Oz -g -mthumb"
                ;;
                armv8)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2 -g"
                ;;
                x86)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2 -g"
                ;;
                x86_64)
                    LOCAL_BUILD_VARIANT_CFLAGS="-O2 -g"
                ;;
            esac
        ;;
        *)
            error "Invalid build variant '${FM_ARG_BUILD_VARIANT}'."
        ;;
    esac

    FM_TARGET_ARCHITECTURE="${LOCAL_ARCHITECTURE}"
    FM_TARGET_ADDRESS_MODEL="${LOCAL_ADDRESS_MODEL}"
    FM_TARGET_CROSS_COMPILER_HOST="${LOCAL_CROSS_COMPILER_HOST}"
    FM_TARGET_IS_CROSS_COMPILING=true
    FM_TARGET_BUILD_VARIANT="${LOCAL_BUILD_VARIANT}"

    LOCAL_COMMON_CPPFLAGS="-I${FM_LIBS_INSTALL_INCLUDES}"
    LOCAL_COMMON_CFLAGS="-fPIC -Wextra -Wall -W -DANDROID -DANDROID_HAS_WSTRING -D_REENTRANT -fstack-protector-strong -fno-limit-debug-info"
    LOCAL_COMMON_CXXFLAGS=""
    LOCAL_COMMON_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS}"

    FM_TARGET_TOOLCHAIN_CPPFLAGS="${LOCAL_COMMON_CPPFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CPPFLAGS-}"
    FM_TARGET_TOOLCHAIN_CFLAGS="${LOCAL_COMMON_CFLAGS} ${LOCAL_ARCHITECTURE_CFLAGS} ${LOCAL_BUILD_VARIANT_CFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CFLAGS-}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${LOCAL_COMMON_CXXFLAGS} ${LOCAL_ARCHITECTURE_CXXFLAGS} ${LOCAL_BUILD_VARIANT_CXXFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS-}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${LOCAL_COMMON_LDFLAGS} ${LOCAL_ARCHITECTURE_LDFLAGS} ${LOCAL_BUILD_VARIANT_LDFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS-}"

    FM_TARGET_TOOLCHAIN_AR="${LOCAL_CROSS_COMPILER_HOST}-ar"
    FM_TARGET_TOOLCHAIN_CC="${LOCAL_CROSS_COMPILER_ROOT_NAME}-clang"
    FM_TARGET_TOOLCHAIN_CXX="${LOCAL_CROSS_COMPILER_ROOT_NAME}-clang++"
    FM_TARGET_TOOLCHAIN_NM="${LOCAL_CROSS_COMPILER_HOST}-nm"
    FM_TARGET_TOOLCHAIN_RANLIB="${LOCAL_CROSS_COMPILER_HOST}-ranlib"

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CPPFLAGS="${FM_TARGET_TOOLCHAIN_CPPFLAGS}"
    export CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    export FM_TARGET_ANDROID_ABI=${LOCAL_TARGET_ANDROID_ABI}""
    export FM_LIBS_INSTALL_PREFIX
    export CMAKE_GENERATOR="${FM_TARGET_CMAKE_GENERATOR}"
}
