#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    
    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    prepareBuildStep "Decompressing ${LIB_TARBALL_LOCAL_PATH} ... "
    tar --exclude=*/.travis.yml -xz -f ${LIB_TARBALL_LOCAL_PATH} -C ${FM_CURRENT_LIB_SOURCE_DIR} || error "Cannot decompress file ${LIB_TARBALL_LOCAL_PATH} to ${FM_CURRENT_LIB_SOURCE_DIR}"
    checkBuildStep

    mv "${FM_CURRENT_LIB_SOURCE_DIR}/${FM_CURRENT_LIB_FULL_NAME}" "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

beforeBuildCurrentArchitecture()
{
    FM_BOTAN_OPTIONAL_LIBS=""
    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        FM_BOTAN_OPTIONAL_LIBS="--with-external-includedir=${FM_LIBS_INSTALL_INCLUDES_WINDOWS} --with-external-libdir=${FM_LIBS_INSTALL_LIBS_WINDOWS}"

        # The makefiles generated di configure.py causes linking problems with external libraries.
        return

    else
        FM_BOTAN_OPTIONAL_LIBS="--with-external-includedir=${FM_LIBS_INSTALL_INCLUDES} --with-external-libdir=${FM_LIBS_INSTALL_LIBS}"
    fi

    isLibraryInstalled "BZIP2"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library bzip2"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-bzip2"
    fi

    isLibraryInstalled "ZLIB"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library zlib"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-zlib"
    fi

    isLibraryInstalled "SQLITE"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library sqlite"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-sqlite3"
    fi

    isLibraryInstalled "OPENSSL"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library openssl"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-openssl"
    fi

    isLibraryInstalled "BOOST"
    if [ ${FM_IS_LIBRARY_INSTALLED} = "true" ]; then
        echo "Enabling support for library boost"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-boost"
    fi
}

afterBuildCurrentArchitecture()
{
    local BASE_INCLUDE_DIR=""
    
    mv "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2/botan" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include"
    rmdir "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2"

    mv "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"/lib/python* "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"
}

buildCurrentArchitecture__linux_gcc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="x86"
    else
        BUILD_PLATFORM="x86_64"
    fi

    local BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_DEBUG_MODE="--debug-mode"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=linux --cc=gcc --cpu=${BUILD_PLATFORM}\
        --disable-shared ${BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="x86"
    else
        BUILD_PLATFORM="x86_64"
    fi

    local BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_DEBUG_MODE="--debug-mode"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=macos --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    local BUILD_PLATFORM=""
    case ${FM_IOS_SDK_ARCHITECTURE} in
        armv7)
            BUILD_PLATFORM="armv7"
        ;;
        armv7s)
            BUILD_PLATFORM="armv7s"
        ;;
        arm64)
            BUILD_PLATFORM="armv8-a"
        ;;
        i386)
            BUILD_PLATFORM="i386"
        ;;
        x86_64)
            BUILD_PLATFORM="x86_64"
        ;;
        *)
            error "Unsupported architecture: ${FM_IOS_SDK_ARCHITECTURE}"
    esac

    local BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_DEBUG_MODE="--debug-mode"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=ios --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="x86"
    else
        BUILD_PLATFORM="x86_64"
    fi
    
    local BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_DEBUG_MODE="--debug-mode"
    fi

    export CFLAGS=""
    export CXXFLAGS=""

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=mingw --cc=gcc --cpu=${BUILD_PLATFORM} --cc-abi-flags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} -UUNICODE -U_UNICODE"\
        --disable-shared ${BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --without-stack-protector --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="x86"
    else
        BUILD_PLATFORM="x86_64"
    fi
    
    local BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_DEBUG_MODE="--debug-mode"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=windows --cc=msvc --cpu=${BUILD_PLATFORM} --cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --disable-shared ${BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS}\
        --without-documentation --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    sed -E -i.orig 's/SO_OBJ_FLAGS( +)=( +)/SO_OBJ_FLAGS = -Fd\"botan.pdb\"/' ./Makefile
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    copyFile botan.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
}


buildLibrary "BOTAN"

