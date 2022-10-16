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
    local LOCAL_BUILD_VARIANT=""

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
        ;;
        x86_64)
            LOCAL_ARCHITECTURE="x86_64"
            LOCAL_ADDRESS_MODEL="64"
            LOCAL_ARCHITECTURE_CFLAGS="-DWIN64"
        ;;
        *)
            error "Invalid architecture '${FM_ARG_ARCHITECTURE}'."
        ;;
    esac

    case ${FM_ARG_BUILD_VARIANT} in
        debug)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-MDd"
        ;;
        release)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-MD -O2 -DNDEBUG"
        ;;
        profile)
            LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            LOCAL_BUILD_VARIANT_CFLAGS="-MD -O2 -DNDEBUG"
        ;;
        *)
            error "Invalid build variant '${FM_ARG_BUILD_VARIANT}'."
        ;;
    esac

    FM_TARGET_ARCHITECTURE="${LOCAL_ARCHITECTURE}"
    FM_TARGET_ADDRESS_MODEL="${LOCAL_ADDRESS_MODEL}"
    FM_TARGET_BUILD_VARIANT="${LOCAL_BUILD_VARIANT}"
    FM_TARGET_IS_CROSS_COMPILING=false

    FM_LIBS_INSTALL_PREFIX_WINDOWS="$(cygpath -w "${FM_LIBS_INSTALL_PREFIX}")"
    FM_LIBS_INSTALL_INCLUDES_WINDOWS="$(cygpath -w "${FM_LIBS_INSTALL_INCLUDES}")"
    FM_LIBS_INSTALL_LIBS_WINDOWS="$(cygpath -w "${FM_LIBS_INSTALL_LIBS}")"

    LOCAL_COMMON_CFLAGS="-I${FM_LIBS_INSTALL_INCLUDES_WINDOWS} -nologo -Zc:wchar_t -Zc:strictStrings -bigobj -FS -DUNICODE -D_UNICODE -DWIN32 -D_WIN32_WINNT=0x0601"
    LOCAL_COMMON_CXXFLAGS="-Zc:throwingNew -GR -EHsc"
    LOCAL_COMMON_LDFLAGS="/LIBPATH:${FM_LIBS_INSTALL_LIBS_WINDOWS}"

    case ${FM_TARGET_COMPILER_VERSION} in
        14.0)
            # Nothing to do
        ;;
        14.1|14.2)
            LOCAL_COMMON_CFLAGS="${LOCAL_COMMON_CFLAGS} -Zc:inline -D_ENABLE_EXTENDED_ALIGNED_STORAGE"
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -Zc:rvalueCast -Zc:referenceBinding -Zc:__cplusplus"
        ;;
        *)
        error "Invalid compiler version '${FM_TARGET_COMPILER_VERSION}'."
        ;;
    esac
        
    case ${FM_CONFIG_CXX_STANDARD} in
        14)
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -std:c++14"
        ;;
        17)
            LOCAL_COMMON_CXXFLAGS="${LOCAL_COMMON_CXXFLAGS} -std:c++17"
        ;;
        *)
            error "Invalid C++ standard '${FM_CONFIG_CXX_STANDARD}'."
        ;;
    esac

    FM_TARGET_TOOLCHAIN_CFLAGS="${LOCAL_COMMON_CFLAGS} ${LOCAL_ARCHITECTURE_CFLAGS} ${LOCAL_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${LOCAL_COMMON_CXXFLAGS} ${LOCAL_ARCHITECTURE_CXXFLAGS} ${LOCAL_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${LOCAL_COMMON_LDFLAGS} ${LOCAL_ARCHITECTURE_LDFLAGS} ${LOCAL_BUILD_VARIANT_LDFLAGS}"

    FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE="${LOCAL_COMMON_CFLAGS} ${LOCAL_ARCHITECTURE_CFLAGS} ${LOCAL_COMMON_CXXFLAGS} ${LOCAL_ARCHITECTURE_CXXFLAGS} ${LOCAL_BUILD_VARIANT_CXXFLAGS}"

    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    export FM_LIBS_INSTALL_PREFIX
    export CMAKE_GENERATOR="${FM_TARGET_CMAKE_GENERATOR}"
}
