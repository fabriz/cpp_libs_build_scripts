#!/bin/bash


initToolchainConfiguration()
{
    FM_CONFIG_ARCHITECTURE=""
    FM_CONFIG_ADDRESS_MODEL=""
    FM_CONFIG_CROSS_COMPILER_HOST="${FM_GLOBAL_CROSS_COMPILER_HOST}"
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
        armv7)
            FM_CONFIG_ARCHITECTURE="armv7"
            FM_CONFIG_ARCHITECTURE_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfp -fno-builtin-memmove"
            FM_CONFIG_ADDRESS_MODEL="32"
        ;;
        armv8)
            FM_CONFIG_ARCHITECTURE="armv8"
            FM_CONFIG_ARCHITECTURE_CFLAGS=""
            FM_CONFIG_ADDRESS_MODEL="64"
        ;;
        *)
            error "Invalid architecture ${FM_ARG_ARCHITECTURE}. Valid values are (armv7, armv8)"
    esac

    case ${FM_ARG_BUILD_VARIANT} in
        debug)
            FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            case ${FM_ARG_ARCHITECTURE} in
                armv7)
                    FM_CONFIG_BUILD_VARIANT_CFLAGS="-g -marm -O0"
                ;;
                armv8)
                    FM_CONFIG_BUILD_VARIANT_CFLAGS="-g"
                ;;
            esac
        ;;
        release)
            FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
            case ${FM_ARG_ARCHITECTURE} in
                armv7)
                    FM_CONFIG_BUILD_VARIANT_CFLAGS="-mthumb -Oz"
                ;;
                armv8)
                    FM_CONFIG_BUILD_VARIANT_CFLAGS="-O2"
                ;;
            esac
        ;;
        *)
            error "Invalid variant ${FM_ARG_BUILD_VARIANT}. Valid values are (debug, release)"
    esac

    FM_TARGET_HAS_DLLS="false"
    FM_TARGET_ARCHITECTURE="${FM_CONFIG_ARCHITECTURE}"
    FM_TARGET_ADDRESS_MODEL="${FM_CONFIG_ADDRESS_MODEL}"
    FM_TARGET_CROSS_COMPILER_HOST="${FM_CONFIG_CROSS_COMPILER_HOST}"
    FM_TARGET_BUILD_VARIANT="${FM_CONFIG_BUILD_VARIANT}"
}

initToolchainTools()
{
    FM_CONFIG_COMMON_CFLAGS="-I${FM_LIBS_INSTALL_INCLUDES} -fPIC -Wextra -Wall -W -DANDROID -DANDROID_HAS_WSTRING -D_REENTRANT -fstack-protector-strong"
    FM_CONFIG_COMMON_CXXFLAGS="-std=gnu++1y"
    FM_CONFIG_COMMON_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS}"

    FM_TARGET_TOOLCHAIN_CFLAGS="${FM_CONFIG_COMMON_CFLAGS} ${FM_CONFIG_ARCHITECTURE_CFLAGS} ${FM_CONFIG_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${FM_CONFIG_COMMON_CXXFLAGS} ${FM_CONFIG_ARCHITECTURE_CXXFLAGS} ${FM_CONFIG_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${FM_CONFIG_COMMON_LDFLAGS} ${FM_CONFIG_ARCHITECTURE_LDFLAGS} ${FM_CONFIG_BUILD_VARIANT_LDFLAGS}"

    FM_TARGET_TOOLCHAIN_AR="${FM_CONFIG_CROSS_COMPILER_HOST}-ar"
    FM_TARGET_TOOLCHAIN_CC="${FM_GLOBAL_CROSS_COMPILER_ROOT_NAME}-clang"
    FM_TARGET_TOOLCHAIN_CXX="${FM_GLOBAL_CROSS_COMPILER_ROOT_NAME}-clang++"
    FM_TARGET_TOOLCHAIN_NM="${FM_CONFIG_CROSS_COMPILER_HOST}-nm"
    FM_TARGET_TOOLCHAIN_RANLIB="${FM_CONFIG_CROSS_COMPILER_HOST}-ranlib"

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"
}


FM_TARGET_PLATFORM="android_clang_api${FM_GLOBAL_ANDROID_API_LEVEL}"
FM_TARGET_TOOLCHAIN="android_clang"
FM_TARGET_TOOLCHAIN_HOST_OS="linux"
FM_TARGET_TOOLCHAIN_VERSION="$(${FM_GLOBAL_CROSS_COMPILER_ROOT_NAME}-clang -dumpversion)"
