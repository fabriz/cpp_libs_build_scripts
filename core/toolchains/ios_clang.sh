#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

initToolchain()
{
    local LOCAL_ARCHITECTURE_SUFFIX="$(echo ${FM_ARG_ARCHITECTURE} | tr '[:lower:]' '[:upper:]')"
    local LOCAL_BUILD_VARIANT_SUFFIX="$(echo ${FM_ARG_BUILD_VARIANT} | tr '[:lower:]' '[:upper:]')"

    local LOCAL_VAR_NAME_ARCHITECTURE_CFLAGS="FM_TARGET_TOOLCHAIN_ARCHITECTURE_CFLAGS_${LOCAL_ARCHITECTURE_SUFFIX}"
    local LOCAL_VAR_NAME_ARCHITECTURE_CXXFLAGS="FM_TARGET_TOOLCHAIN_ARCHITECTURE_CXXFLAGS_${LOCAL_ARCHITECTURE_SUFFIX}"
    local LOCAL_VAR_NAME_ARCHITECTURE_LDFLAGS="FM_TARGET_TOOLCHAIN_ARCHITECTURE_LDFLAGS_${LOCAL_ARCHITECTURE_SUFFIX}"

    local LOCAL_VAR_NAME_BUILD_VARIANT_CFLAGS="FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CFLAGS_${LOCAL_BUILD_VARIANT_SUFFIX}"
    local LOCAL_VAR_NAME_BUILD_VARIANT_CXXFLAGS="FM_TARGET_TOOLCHAIN_BUILD_VARIANT_CXXFLAGS_${LOCAL_BUILD_VARIANT_SUFFIX}"
    local LOCAL_VAR_NAME_BUILD_VARIANT_LDFLAGS="FM_TARGET_TOOLCHAIN_BUILD_VARIANT_LDFLAGS_${LOCAL_BUILD_VARIANT_SUFFIX}"

    local LOCAL_ARCHITECTURE_CPPFLAGS=""
    local LOCAL_ARCHITECTURE_CFLAGS=""
    local LOCAL_ARCHITECTURE_ASMFLAGS=""
    local LOCAL_COMPILER_TARGET_PREFIX=""
    local LOCAL_TARGET_IOS_VERSION=""

    FM_TARGET_ARCHITECTURE="${FM_ARG_ARCHITECTURE}"
    FM_TARGET_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
    FM_TARGET_IS_CROSS_COMPILING=true

    export FM_TARGET_IOS_SDK_VERSION="$(xcrun -sdk ${FM_TARGET_IOS_SDK} --show-sdk-version)"
    export FM_TARGET_IOS_SYS_ROOT="$(xcrun -sdk ${FM_TARGET_IOS_SDK} --show-sdk-path)"

    case ${FM_ARG_ARCHITECTURE} in
        x86)
            FM_TARGET_ADDRESS_MODEL="32"
            FM_TARGET_IOS_PROCESSOR="x86"
            FM_TARGET_CROSS_COMPILER_HOST="arm-apple-darwin${FM_TARGET_IOS_SDK_VERSION}"
            LOCAL_COMPILER_TARGET_PREFIX="x86"
            LOCAL_ARCHITECTURE_ASMFLAGS="-arch i386"
        ;;
        x86_64)
            FM_TARGET_ADDRESS_MODEL="64"
            FM_TARGET_IOS_PROCESSOR="x86_64"
            FM_TARGET_CROSS_COMPILER_HOST="arm-apple-darwin${FM_TARGET_IOS_SDK_VERSION}"
            LOCAL_COMPILER_TARGET_PREFIX="x86_64"
            LOCAL_ARCHITECTURE_ASMFLAGS="-arch x86_64"
        ;;
        armv7)
            FM_TARGET_ADDRESS_MODEL="32"
            FM_TARGET_IOS_PROCESSOR="arm"
            FM_TARGET_CROSS_COMPILER_HOST="arm-apple-darwin"
            LOCAL_COMPILER_TARGET_PREFIX="armv7"
            LOCAL_ARCHITECTURE_ASMFLAGS="-arch armv7"
        ;;
        armv7s)
            FM_TARGET_ADDRESS_MODEL="32"
            FM_TARGET_IOS_PROCESSOR="arm"
            FM_TARGET_CROSS_COMPILER_HOST="arm-apple-darwin${FM_TARGET_IOS_SDK_VERSION}"
            LOCAL_COMPILER_TARGET_PREFIX="armv7s"
            LOCAL_ARCHITECTURE_ASMFLAGS="-arch armv7s"
        ;;
        arm64)
            FM_TARGET_ADDRESS_MODEL="64"
            FM_TARGET_IOS_PROCESSOR="aarch64"
            FM_TARGET_CROSS_COMPILER_HOST="arm-apple-darwin${FM_TARGET_IOS_SDK_VERSION}"
            LOCAL_COMPILER_TARGET_PREFIX="arm64"
            LOCAL_ARCHITECTURE_ASMFLAGS="-arch arm64"
        ;;
        *)
            error "Invalid architecture '${FM_ARG_ARCHITECTURE}'."
        ;;
    esac

    case ${FM_TARGET_IOS_SDK} in
        iphoneos)
            case ${FM_ARG_ARCHITECTURE} in
                armv7|armv7s)
                    LOCAL_TARGET_IOS_VERSION="10.3"
                ;;
                arm64)
                    LOCAL_TARGET_IOS_VERSION="13.0"
                ;;
                *)
                    error "Invalid architecture for '${FM_TARGET_IOS_SDK}': '${FM_ARG_ARCHITECTURE}'."
                ;;
            esac

            LOCAL_ARCHITECTURE_CPPFLAGS="${LOCAL_ARCHITECTURE_CPPFLAGS} -target ${LOCAL_COMPILER_TARGET_PREFIX}-apple-ios${LOCAL_TARGET_IOS_VERSION} -mios-version-min=${LOCAL_TARGET_IOS_VERSION}"
        ;;
        iphonesimulator)
            LOCAL_TARGET_IOS_VERSION="13.0"
            LOCAL_ARCHITECTURE_CPPFLAGS="${LOCAL_ARCHITECTURE_CPPFLAGS} -target ${LOCAL_COMPILER_TARGET_PREFIX}-apple-ios${LOCAL_TARGET_IOS_VERSION}-simulator -mios-simulator-version-min=${LOCAL_TARGET_IOS_VERSION}"
        ;;
        *)
            error "Invalid SDK '${FM_TARGET_IOS_SDK}'."
        ;;
    esac

    FM_TARGET_TOOLCHAIN_CPPFLAGS="${LOCAL_ARCHITECTURE_CPPFLAGS} -isysroot ${FM_TARGET_IOS_SYS_ROOT} -I${FM_LIBS_INSTALL_INCLUDES} ${FM_TARGET_TOOLCHAIN_COMMON_CPPFLAGS-}"
    FM_TARGET_TOOLCHAIN_CFLAGS="${FM_TARGET_TOOLCHAIN_CPPFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CFLAGS-} ${!LOCAL_VAR_NAME_ARCHITECTURE_CFLAGS-} ${!LOCAL_VAR_NAME_BUILD_VARIANT_CFLAGS-}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${FM_TARGET_TOOLCHAIN_COMMON_CXXFLAGS-} ${!LOCAL_VAR_NAME_ARCHITECTURE_CXXFLAGS-} ${!LOCAL_VAR_NAME_BUILD_VARIANT_CXXFLAGS-}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS} ${FM_TARGET_TOOLCHAIN_COMMON_LDFLAGS-} ${!LOCAL_VAR_NAME_ARCHITECTURE_LDFLAGS-} ${!LOCAL_VAR_NAME_BUILD_VARIANT_LDFLAGS-}"
    FM_TARGET_TOOLCHAIN_ASMFLAGS="${LOCAL_ARCHITECTURE_ASMFLAGS}"

    FM_TARGET_TOOLCHAIN_AR="$(xcrun -sdk ${FM_TARGET_IOS_SDK} -find ar)"
    FM_TARGET_TOOLCHAIN_CC="$(xcrun -sdk ${FM_TARGET_IOS_SDK} -find clang)"
    FM_TARGET_TOOLCHAIN_CXX="$(xcrun -sdk ${FM_TARGET_IOS_SDK} -find clang++)"
    FM_TARGET_TOOLCHAIN_NM="$(xcrun -sdk ${FM_TARGET_IOS_SDK} -find nm)"
    FM_TARGET_TOOLCHAIN_RANLIB="$(xcrun -sdk ${FM_TARGET_IOS_SDK} -find ranlib)"

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CPPFLAGS="${FM_TARGET_TOOLCHAIN_CPPFLAGS}"
    export CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"
    export ASMFLAGS="${FM_TARGET_TOOLCHAIN_ASMFLAGS}"

    export FM_TARGET_IOS_VERSION="${LOCAL_TARGET_IOS_VERSION}"
    export FM_TARGET_IOS_PROCESSOR
    export FM_LIBS_INSTALL_PREFIX
    export CMAKE_GENERATOR="${FM_TARGET_CMAKE_GENERATOR}"
}
