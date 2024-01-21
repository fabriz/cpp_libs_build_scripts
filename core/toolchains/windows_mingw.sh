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
    local LOCAL_MINGW_PLATFORM=""
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

    case ${FM_ARG_ARCHITECTURE} in
        x86)
            LOCAL_ARCHITECTURE="x86"
            LOCAL_ADDRESS_MODEL="32"
            LOCAL_MINGW_PLATFORM="i686-w64-mingw32"
        ;;
        x86_64)
            LOCAL_ARCHITECTURE="x86_64"
            LOCAL_ADDRESS_MODEL="64"
            LOCAL_MINGW_PLATFORM="x86_64-w64-mingw32"
        ;;
        *)
            error "Invalid architecture '${FM_ARG_ARCHITECTURE}'."
        ;;
    esac

    case ${FM_ARG_BUILD_VARIANT} in
        debug)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-g -Og"
        ;;
        release)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-O2"
        ;;
        profile)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-O2 -g"
        ;;
        *)
            error "Invalid build variant '${FM_ARG_BUILD_VARIANT}'."
        ;;
    esac

    FM_TARGET_ARCHITECTURE="${LOCAL_ARCHITECTURE}"
    FM_TARGET_ADDRESS_MODEL="${LOCAL_ADDRESS_MODEL}"
    FM_TARGET_MINGW_PLATFORM="${LOCAL_MINGW_PLATFORM}"
    FM_TARGET_BUILD_VARIANT="${LOCAL_BUILD_VARIANT}"
    FM_TARGET_IS_CROSS_COMPILING=false

    LOCAL_COMMON_CPPFLAGS="-I${FM_LIBS_INSTALL_INCLUDES}"
    LOCAL_COMMON_CFLAGS="-Wextra -Wall -W -fexceptions -mthreads -D_WIN32_WINNT=0x0601"
    LOCAL_COMMON_CXXFLAGS=""
    LOCAL_COMMON_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS}"
        
    case ${FM_CONFIG_CXX_STANDARD} in
        14)
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -std=gnu++14"
        ;;
        17)
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -std=gnu++17"
        ;;
        20)
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -std=gnu++20"
        ;;
        *)
            error "Invalid C++ standard '${FM_CONFIG_CXX_STANDARD}'."
        ;;
    esac

    FM_TARGET_TOOLCHAIN_CPPFLAGS="${LOCAL_COMMON_CPPFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CPPFLAGS-}"
    FM_TARGET_TOOLCHAIN_CFLAGS="${LOCAL_COMMON_CFLAGS} ${LOCAL_ARCHITECTURE_CFLAGS} ${LOCAL_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${LOCAL_COMMON_CXXFLAGS} ${LOCAL_ARCHITECTURE_CXXFLAGS} ${LOCAL_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${LOCAL_COMMON_LDFLAGS} ${LOCAL_ARCHITECTURE_LDFLAGS} ${LOCAL_BUILD_VARIANT_LDFLAGS}"

    FM_TARGET_TOOLCHAIN_AR="ar"
    FM_TARGET_TOOLCHAIN_CC="gcc"
    FM_TARGET_TOOLCHAIN_CXX="g++"
    FM_TARGET_TOOLCHAIN_NM="nm"
    FM_TARGET_TOOLCHAIN_RANLIB="ranlib"

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CPPFLAGS="${FM_TARGET_TOOLCHAIN_CPPFLAGS}"
    export CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    export FM_LIBS_INSTALL_PREFIX
    export CMAKE_GENERATOR="${FM_TARGET_CMAKE_GENERATOR}"
    export PKG_CONFIG_PATH=${FM_LIBS_INSTALL_PKGCONFIG}:${PKG_CONFIG_PATH-}
}
