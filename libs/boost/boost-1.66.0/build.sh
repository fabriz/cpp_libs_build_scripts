#!/bin/bash
# Build script for boost 1.66.0

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/common.sh"


# Useful bjam flags
# --debug-configuration
# --reconfigure

beforeBuildCurrentArchitecture()
{
    FM_BOOST_OPTIONAL_LIBS=""

    if isLibraryInstalled "BZIP2"; then
        echo "Enabling support for library bzip2"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export BZIP2_NAME="libbz2"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export BZIP2_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_BZIP2_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export BZIP2_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export BZIP2_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "ZLIB"; then
        echo "Enabling support for library zlib"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES_WINDOWS}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS_WINDOWS}"
            export ZLIB_NAME="zlib"
        elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
            export ZLIB_SOURCE="${FM_LIBS_BUILD_SOURCE}/${FM_ZLIB_FULL_NAME}/${FM_IOS_SDK_ARCHITECTURE}"
        else
            export ZLIB_INCLUDE="${FM_LIBS_INSTALL_INCLUDES}"
            export ZLIB_LIBRARY_PATH="${FM_LIBS_INSTALL_LIBS}"
        fi
    fi

    if isLibraryInstalled "ICU4C"; then
        echo "Enabling support for library icu4c"
        export ICU_PATH="${FM_LIBS_INSTALL_PREFIX}"
    else
        FM_BOOST_OPTIONAL_LIBS="${FM_BOOST_OPTIONAL_LIBS} --disable-icu"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${FM_BOOST_OPTIONAL_LIBS}\
        --toolset=gcc variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    local BOOST_ANDROID_ARCH="arm"

    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${FM_BOOST_OPTIONAL_LIBS} --without-python\
        --toolset=clang variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} architecture=${BOOST_ANDROID_ARCH} target-os=android cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} darwin.jam ... "
    sed -i.orig -e '/-fcoalesce-templates/d' -e '/-Wno-long-double/d' "./tools/build/src/tools/darwin.jam"
    checkBuildStep

    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${FM_BOOST_OPTIONAL_LIBS}\
        --toolset=darwin variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    unset AR
    unset CC
    unset CXX
    unset NM
    unset RANLIB
    unset CFLAGS
    unset CXXFLAGS
    unset LDFLAGS

    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} darwin.jam ... "
    sed -i.orig "s/-arch arm/-arch ${FM_IOS_SDK_ARCHITECTURE}/g" "./tools/build/src/tools/darwin.jam"
    checkBuildStep

    local BOOST_IOS_ARCH=""
    local BOOST_IOS_SDK=""
    if [ ${FM_IOS_CURRENT_SDK_NAME} = "iphoneos" ]; then
        BOOST_IOS_ARCH="arm"
        BOOST_IOS_SDK="iphone"
    else
        BOOST_IOS_ARCH="x86"
        BOOST_IOS_SDK="iphonesim"
    fi

cat > ./user-ios-config.jam <<EOF
using darwin : ${FM_IOS_SDK_VERSION}~${BOOST_IOS_SDK}
: ${FM_IOS_XCODE_ROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -arch ${FM_IOS_SDK_ARCHITECTURE} ${FM_TARGET_TOOLCHAIN_CFLAGS}
: <striper> <root>${FM_IOS_XCODE_ROOT}/Platforms/${FM_IOS_SDK_PLATFORM}.platform/Developer <architecture>${BOOST_IOS_ARCH} <target-os>iphone
;
EOF

    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -sBOOST_BUILD_USER_CONFIG=./user-ios-config.jam\
        -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths ${FM_BOOST_OPTIONAL_LIBS}\
        --toolset=darwin-${FM_IOS_SDK_VERSION}~${BOOST_IOS_SDK} variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL}\
        cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}" define=_LITTLE_ENDIAN\
        macosx-version=${BOOST_IOS_SDK}-${FM_IOS_SDK_VERSION} architecture=${BOOST_IOS_ARCH} target-os=iphone\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.sh > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    local PYTON_HEADER_FIX="-D_hypot=hypot"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths\
        --toolset=gcc variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL} cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} ${PYTON_HEADER_FIX}"\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Bootstrapping ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./bootstrap.bat > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./b2 -j${FM_GLOBAL_NUM_PROCESSES} threading=multi link=static runtime-link=shared --layout=system --abbreviate-paths\
        --toolset=msvc-${FM_TARGET_TOOLCHAIN_VERSION} variant=${FM_TARGET_BUILD_VARIANT} address-model=${FM_TARGET_ADDRESS_MODEL}\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} --build-dir=./tmp_build install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "BOOST"

