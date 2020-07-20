#!/bin/bash
# Build script for botan 2.14.0

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/common.sh"


decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    
    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    prepareBuildStep "Decompressing ${LIB_TARBALL_LOCAL_PATH} ... "
    ${FM_CMD_TAR} --exclude=*/.lgtm.yml --exclude=*/.travis.yml -x -f ${LIB_TARBALL_LOCAL_PATH} -C ${FM_CURRENT_LIB_SOURCE_DIR} || error "Cannot decompress file ${LIB_TARBALL_LOCAL_PATH} to ${FM_CURRENT_LIB_SOURCE_DIR}"
    checkBuildStep

    moveDirectory "${FM_CURRENT_LIB_SOURCE_DIR}/${FM_CURRENT_LIB_FULL_NAME}" "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

beforeBuildCurrentArchitecture()
{
    FM_BUILD_DEBUG_MODE=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        FM_BUILD_DEBUG_MODE="--debug-mode"
    fi

    FM_BOTAN_OPTIONAL_LIBS=""
    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        FM_BOTAN_OPTIONAL_LIBS="--with-external-includedir=${FM_LIBS_INSTALL_INCLUDES_WINDOWS} --with-external-libdir=${FM_LIBS_INSTALL_LIBS_WINDOWS}"
    else
        FM_BOTAN_OPTIONAL_LIBS="--with-external-includedir=${FM_LIBS_INSTALL_INCLUDES} --with-external-libdir=${FM_LIBS_INSTALL_LIBS}"
    fi

    if isLibraryInstalled "BZIP2"; then
        echo "Enabling support for library bzip2"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-bzip2"
    fi

    if isLibraryInstalled "ZLIB"; then
        echo "Enabling support for library zlib"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-zlib"
    fi

    if isLibraryInstalled "SQLITE"; then
        echo "Enabling support for library sqlite"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-sqlite3"
    fi

    if isLibraryInstalled "OPENSSL"; then
        echo "Enabling support for library openssl"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-openssl"
    fi

    if isLibraryInstalled "BOOST"; then
        echo "Enabling support for library boost"
        FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --with-boost"
        if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
            FM_BOTAN_OPTIONAL_LIBS="${FM_BOTAN_OPTIONAL_LIBS} --boost-library-name=libboost_system --boost-library-name=libboost_date_time"
        fi
    fi
}

afterBuildCurrentArchitecture()
{
    local BASE_INCLUDE_DIR=""
    
    moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2/botan" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include"
    deleteDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2"
    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig"
}

buildCurrentArchitecture__linux_gcc()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
        BUILD_PLATFORM="x86"
    elif [ ${FM_TARGET_ARCHITECTURE} = "x64" ]; then
        BUILD_PLATFORM="x86_64"
    elif [ ${FM_TARGET_ARCHITECTURE} = "armv7" ]; then
        BUILD_PLATFORM="armv7"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=linux --cc=gcc --cpu=${BUILD_PLATFORM}\
        --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "armv7" ]; then
        BUILD_PLATFORM="armv7"
    elif [ ${FM_TARGET_ARCHITECTURE} = "armv8" ]; then
        BUILD_PLATFORM="armv8"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=android --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=macos --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=ios --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=mingw --cc=gcc --cpu=${BUILD_PLATFORM}\
        --build-targets=static --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS} --without-documentation\
        --link-method=copy --without-stack-protector --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure.py --os=windows --cc=msvc --cpu=${BUILD_PLATFORM} --cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} -DBOOST_ALL_NO_LIB -UUNICODE"\
        --build-targets=static --disable-shared ${FM_BUILD_DEBUG_MODE} ${FM_BOTAN_OPTIONAL_LIBS}\
        --link-method=copy --without-documentation --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    sed -E -i.orig 's/LIB_FLAGS( +)=(.+)/LIB_FLAGS = \/Fd\"build\/botan.pdb\"/' ./Makefile

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    copyFile build/botan.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
}


buildLibrary "BOTAN"
