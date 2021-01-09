#!/bin/bash

LOCAL_ARCHITECTURE=""
LOCAL_ADDRESS_MODEL=""
LOCAL_BUILD_VARIANT=""

LOCAL_COMMON_CFLAGS=""
LOCAL_COMMON_CXXFLAGS=""
LOCAL_COMMON_LDFLAGS=""
LOCAL_ARCHITECTURE_CFLAGS=""
LOCAL_ARCHITECTURE_CXXFLAGS=""
LOCAL_ARCHITECTURE_LDFLAGS=""
LOCAL_BUILD_VARIANT_CFLAGS=""
LOCAL_BUILD_VARIANT_CXXFLAGS=""
LOCAL_BUILD_VARIANT_LDFLAGS=""


case ${FM_ARG_ARCHITECTURE} in
    fat)
        LOCAL_ARCHITECTURE="fat"
        LOCAL_ARCHITECTURE_CFLAGS=""
        LOCAL_ADDRESS_MODEL="32"
    ;;
    *)
        error "Invalid architecture ${FM_ARG_ARCHITECTURE}. Valid values are (fat)"
    ;;
esac

case ${FM_ARG_BUILD_VARIANT} in
    debug)
        LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
        LOCAL_BUILD_VARIANT_CFLAGS="-g"
    ;;
    release)
        LOCAL_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
        LOCAL_BUILD_VARIANT_CFLAGS="-O2"
    ;;
    *)
        error "Invalid variant ${FM_ARG_BUILD_VARIANT}. Valid values are (debug, release)"
    ;;
esac


initToolchainConfigurationForSdk()
{
    [ $# = 1 ] || error "initToolchainConfigurationForSdk(): invalid number of arguments"

    FM_IOS_CURRENT_SDK_NAME=$1

    FM_IOS_SDK_MIN_VERSION=6.0
    FM_IOS_SDK_VERSION=$(xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} --show-sdk-version)
    FM_IOS_XCODE_ROOT=$(xcode-select -print-path)

    case ${FM_IOS_CURRENT_SDK_NAME} in
        iphoneos)
            FM_IOS_SDK_PLATFORM="iPhoneOS"
        ;;
        iphonesimulator)
            FM_IOS_SDK_PLATFORM="iPhoneSimulator"
        ;;
        *)
            error "Invalid SDK ${FM_IOS_CURRENT_SDK_NAME}. Valid values are (iphoneos, iphonesimulator)"
        ;;
    esac

    FM_IOS_CROSS_SYS_ROOT="${FM_IOS_XCODE_ROOT}/Platforms/${FM_IOS_SDK_PLATFORM}.platform/Developer/SDKs/${FM_IOS_SDK_PLATFORM}${FM_IOS_SDK_VERSION}.sdk"

    LOCAL_COMMON_CFLAGS="-isysroot ${FM_IOS_CROSS_SYS_ROOT} -I${FM_LIBS_INSTALL_INCLUDES} -I${FM_IOS_CROSS_SYS_ROOT}/usr/include\
        -mios-version-min=${FM_IOS_SDK_MIN_VERSION} -miphoneos-version-min=${FM_IOS_SDK_MIN_VERSION}\
        -fPIC -Wextra -Wall -W -fvisibility=hidden -fvisibility-inlines-hidden"
    LOCAL_COMMON_CXXFLAGS="-stdlib=libc++ -std=c++14"
    LOCAL_COMMON_LDFLAGS="-L${FM_LIBS_INSTALL_LIBS} -L${FM_IOS_CROSS_SYS_ROOT}/usr/lib"

    FM_TARGET_TOOLCHAIN_CFLAGS="${LOCAL_COMMON_CFLAGS} ${LOCAL_ARCHITECTURE_CFLAGS} ${LOCAL_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${LOCAL_COMMON_CXXFLAGS} ${LOCAL_ARCHITECTURE_CXXFLAGS} ${LOCAL_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${LOCAL_COMMON_LDFLAGS} ${LOCAL_ARCHITECTURE_LDFLAGS} ${LOCAL_BUILD_VARIANT_LDFLAGS}"

    FM_TARGET_TOOLCHAIN_AR="xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} ar"
    FM_TARGET_TOOLCHAIN_CC="xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} clang"
    FM_TARGET_TOOLCHAIN_CXX="xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} clang++"
    FM_TARGET_TOOLCHAIN_NM="xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} nm"
    FM_TARGET_TOOLCHAIN_RANLIB="xcrun -sdk ${FM_IOS_CURRENT_SDK_NAME} ranlib"
}

initToolchainConfigurationForArchitecture()
{
    [ $# = 1 ] || error "initToolchainConfigurationForArchitecture(): invalid number of arguments"

    FM_IOS_CURRENT_ARCHITECTURE_NAME=$1

    export AR="${FM_TARGET_TOOLCHAIN_AR}"
    export CC="${FM_TARGET_TOOLCHAIN_CC} -arch ${FM_IOS_CURRENT_ARCHITECTURE_NAME}"
    export CXX="${FM_TARGET_TOOLCHAIN_CXX} -arch ${FM_IOS_CURRENT_ARCHITECTURE_NAME}"
    export NM="${FM_TARGET_TOOLCHAIN_NM}"
    export RANLIB="${FM_TARGET_TOOLCHAIN_RANLIB}"

    export CFLAGS="-arch ${FM_IOS_CURRENT_ARCHITECTURE_NAME} ${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export CXXFLAGS="-arch ${FM_IOS_CURRENT_ARCHITECTURE_NAME} ${FM_TARGET_TOOLCHAIN_CXXFLAGS}"
    export LDFLAGS="${FM_TARGET_TOOLCHAIN_LDFLAGS}"
}

buildLibrary()
{
    [ $# = 1 ] || error "buildLibrary(): invalid number of arguments"

    local CURRENT_LIBRARY_NAME=$1

    local FM_IOS_IPHONEOS_SDK_ARCHITECTURES=("armv7" "armv7s" "arm64")
    local FM_IOS_IPHONESIMULATOR_SDK_ARCHITECTURES=("i386" "x86_64")
    local FM_IOS_ALL_SDK_ARCHITECTURES=("${FM_IOS_IPHONEOS_SDK_ARCHITECTURES[@]} ${FM_IOS_IPHONESIMULATOR_SDK_ARCHITECTURES[@]}")
    local FM_IOS_BUILT_ARCHITECTURES=()

    initCurrentLibraryVariables "${CURRENT_LIBRARY_NAME}"
    checkCurrentLibraryInstallStatus
    downloadCurrentLibTarballIfMissing

    initToolchainConfigurationForSdk "iphoneos"
    for FM_IOS_SDK_ARCHITECTURE in "${FM_IOS_IPHONEOS_SDK_ARCHITECTURES[@]}"
    do
        FM_TARGET_ADDRESS_MODEL=""
        if [ ${FM_IOS_SDK_ARCHITECTURE} = "arm64" ]; then
            FM_TARGET_ADDRESS_MODEL="64"
        else
            FM_TARGET_ADDRESS_MODEL="32"
        fi

        initToolchainConfigurationForArchitecture "${FM_IOS_SDK_ARCHITECTURE}"
        initCurrentArchitectureVariables "${FM_IOS_SDK_ARCHITECTURE}"
        decompressTarballForCurrentArchitecture
        buildCurrentArchitecture

        FM_IOS_BUILT_ARCHITECTURES+=(${FM_IOS_SDK_ARCHITECTURE})
    done

    initToolchainConfigurationForSdk "iphonesimulator"
    for FM_IOS_SDK_ARCHITECTURE in "${FM_IOS_IPHONESIMULATOR_SDK_ARCHITECTURES[@]}"
    do
        FM_TARGET_ADDRESS_MODEL=""
        if [ ${FM_IOS_SDK_ARCHITECTURE} = "x86_64" ]; then
            FM_TARGET_ADDRESS_MODEL="64"
        else
            FM_TARGET_ADDRESS_MODEL="32"
        fi

        initToolchainConfigurationForArchitecture "${FM_IOS_SDK_ARCHITECTURE}"
        initCurrentArchitectureVariables "${FM_IOS_SDK_ARCHITECTURE}"
        decompressTarballForCurrentArchitecture
        buildCurrentArchitecture

        FM_IOS_BUILT_ARCHITECTURES+=(${FM_IOS_SDK_ARCHITECTURE})
    done

    installFatLibraries "${FM_CURRENT_LIB_FULL_NAME}" "${FM_IOS_BUILT_ARCHITECTURES}"

    echo "Library ${FM_CURRENT_LIB_FULL_NAME} successfully installed"
}

# To list architectures in a fat library:
# lipo -info libz.a


FM_TARGET_PLATFORM="ios_clang"
FM_TARGET_TOOLCHAIN_VERSION="$(clang -dumpversion)"
FM_TARGET_ARCHITECTURE="${LOCAL_ARCHITECTURE}"
#FM_TARGET_ADDRESS_MODEL="${LOCAL_ADDRESS_MODEL}"
FM_TARGET_BUILD_VARIANT="${LOCAL_BUILD_VARIANT}"

