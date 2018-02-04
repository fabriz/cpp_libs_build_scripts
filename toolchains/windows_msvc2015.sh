#!/bin/bash

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
        FM_CONFIG_ADDRESS_MODEL="32"
    ;;
    x64)
        FM_CONFIG_ARCHITECTURE="x64"
        FM_CONFIG_ADDRESS_MODEL="64"
        FM_CONFIG_ARCHITECTURE_CFLAGS="-DWIN64"
    ;;
    *)
        error "Invalid architecture ${FM_ARG_ARCHITECTURE}. Valid values are (i386, x64)"
esac

case ${FM_ARG_BUILD_VARIANT} in
    debug)
        FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
        FM_CONFIG_BUILD_VARIANT_CFLAGS="-MDd"
    ;;
    release)
        FM_CONFIG_BUILD_VARIANT="${FM_ARG_BUILD_VARIANT}"
        FM_CONFIG_BUILD_VARIANT_CFLAGS="-MD -O2 -DNDEBUG"
    ;;
    *)
        error "Invalid variant ${FM_ARG_BUILD_VARIANT}. Valid values are (debug, release)"
esac


initToolchainConfiguration()
{
    FM_LIBS_INSTALL_INCLUDES_WINDOWS=`cygpath -w ${FM_LIBS_INSTALL_INCLUDES}`
    FM_LIBS_INSTALL_LIBS_WINDOWS=`cygpath -w ${FM_LIBS_INSTALL_LIBS}`
    
    FM_CONFIG_COMMON_CFLAGS="-I${FM_LIBS_INSTALL_INCLUDES_WINDOWS} -nologo -Zi -Zc:wchar_t -Zc:strictStrings -bigobj -FS -DUNICODE -DWIN32 -DNOMINMAX -DSTRICT -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=0x0601"
    FM_CONFIG_COMMON_CXXFLAGS="-Zc:throwingNew -GR -EHsc"
    FM_CONFIG_COMMON_LDFLAGS="/LIBPATH:${FM_LIBS_INSTALL_LIBS_WINDOWS}"
    
    FM_TARGET_TOOLCHAIN_CFLAGS="${FM_CONFIG_COMMON_CFLAGS} ${FM_CONFIG_ARCHITECTURE_CFLAGS} ${FM_CONFIG_BUILD_VARIANT_CFLAGS}"
    FM_TARGET_TOOLCHAIN_CXXFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} ${FM_CONFIG_COMMON_CXXFLAGS} ${FM_CONFIG_ARCHITECTURE_CXXFLAGS} ${FM_CONFIG_BUILD_VARIANT_CXXFLAGS}"
    FM_TARGET_TOOLCHAIN_LDFLAGS="${FM_CONFIG_COMMON_LDFLAGS} ${FM_CONFIG_ARCHITECTURE_LDFLAGS} ${FM_CONFIG_BUILD_VARIANT_LDFLAGS}"
}


FM_TARGET_PLATFORM="windows_msvc2015"
FM_TARGET_TOOLCHAIN="windows_msvc"
FM_TARGET_TOOLCHAIN_VERSION="14.0"
FM_TARGET_TOOLCHAIN_HOST_OS="windows"
FM_TARGET_HAS_DLLS="true"
FM_TARGET_ARCHITECTURE="${FM_CONFIG_ARCHITECTURE}"
FM_TARGET_ADDRESS_MODEL="${FM_CONFIG_ADDRESS_MODEL}"
FM_TARGET_BUILD_VARIANT="${FM_CONFIG_BUILD_VARIANT}"

