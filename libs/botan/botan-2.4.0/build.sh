#!/bin/bash
# Build script for botan 2.4.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS=""

    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --debug-mode"
    fi

    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-external-includedir=${FM_LIBS_INSTALL_INCLUDES_WINDOWS} --with-external-libdir=${FM_LIBS_INSTALL_LIBS_WINDOWS}"
    else
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-external-includedir=${FM_LIBS_INSTALL_INCLUDES} --with-external-libdir=${FM_LIBS_INSTALL_LIBS}"
    fi

    # The makefiles generated by configure.py causes linking problems with external libraries.

#    if isLibraryInstalled "BZIP2"; then
#        echo "Enabling support for library bzip2"
#        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-bzip2"
#    fi

#    if isLibraryInstalled "ZLIB"; then
#        echo "Enabling support for library zlib"
#        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-zlib"
#    fi

#    if isLibraryInstalled "SQLITE"; then
#        echo "Enabling support for library sqlite"
#        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-sqlite3"
#    fi

#    if isLibraryInstalled "OPENSSL"; then
#        echo "Enabling support for library openssl"
#        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-openssl"
#    fi

#    if isLibraryInstalled "BOOST"; then
#        echo "Enabling support for library boost"
#        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --with-boost"
#    fi
}

afterBuildCurrentArchitecture()
{
    local BASE_INCLUDE_DIR=""
    
    moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2/botan" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include"
    deleteDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/botan-2"

    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" ]; then
        moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig"
    fi

    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"/lib/python* ]; then
        moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"/lib/python* "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=linux --cc=gcc --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=android --cc=clang --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=macos --cc=clang --cpu=${FM_TARGET_ARCHITECTURE}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
        x86)
            BUILD_PLATFORM="i386"
        ;;
        x86_64)
            BUILD_PLATFORM="x86_64"
        ;;
        *)
            error "Unsupported architecture: ${FM_IOS_SDK_ARCHITECTURE}"
        ;;
    esac

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=ios --cc=clang --cpu=${BUILD_PLATFORM}\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    unset CPPFLAGS
    unset CFLAGS
    unset CXXFLAGS

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_COMMAND}" ./configure.py --os=mingw --cc=gcc --cpu=${FM_TARGET_ARCHITECTURE} --cc-abi-flags="${FM_TARGET_TOOLCHAIN_CXXFLAGS} -UUNICODE -U_UNICODE"\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} --without-documentation\
        --link-method=copy --without-stack-protector --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_PYTHON_WINDOWS_COMMAND}" ./configure.py --os=windows --cc=msvc --cpu=${FM_TARGET_ARCHITECTURE} --cxxflags="${FM_TARGET_TOOLCHAIN_CXXFLAGS}"\
        --disable-shared ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS}\
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
