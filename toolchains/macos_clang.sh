#!/bin/bash


initToolchainConfiguration()
{
    FM_CONFIG_ARCHITECTURE=""
    FM_CONFIG_ADDRESS_MODEL=""
    FM_CONFIG_BUILD_VARIANT=""

    FM_CONFIG_COMMON_CFLAGS=""
    FM_CONFIG_COMMON_CXXFLAGS=""
    FM_CONFIG_COMMON_LDFLAGS=""
    FM_CONFIG_ARCHITECTURE_CFLAGS=""
    FM_CONFIG_ARCHITECTURE_CXXFLAGS=""
    FM_CONFIG_ARCHITECTURE_LDFLAGS=""
    FM_CONFIG_BUILD_VARIANT_CFLAGS=""
    FM_CONFIG_BUILD_VARIANT_CXXFLAGS=""
    FM_CONFIG_BUILD_VARIANT_LDFLAGS=""

    case ${FM_ARG_ARCHITECTURE} in
        i386)
            FM_CONFIG_ARCHITECTURE="i386"
            FM_CONFIG_ARCHITECTURE_CFLAGS=""
            FM_CONFIG_ADDRESS_MODEL="32"
        ;;
        x64)
            FM_CONFIG_ARCHITECTURE="x64"
            FM_CONFIG_ARCHITECTURE_CFLAGS="-arch x86_64"
            FM_CONFIG_ADDRESS_MODEL="64"
        ;;
        *)
            error "Invalid architecture ${FM_ARG_ARCHITECTURE}. Valid values are (i386, x64)"
    esac

    case ${FM_ARG_BUILD_VARIANT} in
        debug)
            FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            FM_CONFIG_BUILD_VARIANT_CFLAGS="-g"
        ;;
        release)
            FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            FM_CONFIG_BUILD_VARIANT_CFLAGS="-O2"
        ;;
        *)
            error "Invalid variant ${FM_ARG_BUILD_VARIANT}. Valid values are (debug, release)"
    esac

    FM_TARGET_PLATFORM="macos_clang"
    FM_TARGET_TOOLCHAIN="macos_clang"
    FM_TARGET_TOOLCHAIN_VERSION=`clang -dumpversion`
    FM_TARGET_TOOLCHAIN_HOST_OS="macos"
    FM_TARGET_HAS_DLLS="false"
    FM_TARGET_ARCHITECTURE="${FM_CONFIG_ARCHITECTURE}"
    FM_TARGET_ADDRESS_MODEL="${FM_CONFIG_ADDRESS_MODEL}"
    FM_TARGET_BUILD_VARIANT="${FM_CONFIG_BUILD_VARIANT}"
}


initToolchainTools()
{
    FM_CONFIG_COMMON_CFLAGS="-I${FM_LIBS_INSTALL_INCLUDES} -fPIC -Wextra -Wall -W -mmacosx-version-min=10.10"
    FM_CONFIG_COMMON_CXXFLAGS="-stdlib=libc++ -std=c++14"
    FM_CONFIG_COMMON_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS}"
    
    FM_TARGET_TOOLCHAIN_CFLAGS="${FM_CONFIG_COMMON_CFLAGS} ${FM_CONFIG_ARCHITECTURE_CFLAGS} ${FM_CONFIG_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${FM_CONFIG_COMMON_CXXFLAGS} ${FM_CONFIG_ARCHITECTURE_CXXFLAGS} ${FM_CONFIG_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${FM_CONFIG_COMMON_LDFLAGS} ${FM_CONFIG_ARCHITECTURE_LDFLAGS} ${FM_CONFIG_BUILD_VARIANT_LDFLAGS}"

    FM_TARGET_TOOLCHAIN_AR="ar"
    FM_TARGET_TOOLCHAIN_CC="clang"
    FM_TARGET_TOOLCHAIN_CXX="clang++"
    FM_TARGET_TOOLCHAIN_NM="nm"
    FM_TARGET_TOOLCHAIN_RANLIB="ranlib"

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"
}

