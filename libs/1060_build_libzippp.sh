#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"

    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    decompressArchive "${LIB_TARBALL_LOCAL_PATH}" "${FM_CURRENT_LIB_SOURCE_DIR}"

    moveDirectory "${FM_CURRENT_LIB_SOURCE_DIR}/ctabin-libzippp"-* "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

afterBuildCurrentArchitecture()
{
    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile src/libzippp.h ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include

    if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
        copyFile libzippp.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib

        if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
            copyFile ./CMakeFiles/libzippp.dir/libzippp.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
        fi
    else
        copyFile libzippp.a ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    fi

    checkBuildStep
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    :
}

buildCurrentArchitecture__ios_clang()
{
    :
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make libzippp-static -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    # Build just the static library
    sed -i.orig 's/ADD_LIBRARY(libzippp_static/ADD_LIBRARY(libzippp/' ./CMakeLists.txt
    sed -i.orig 's/ADD_LIBRARY(libzippp_shared/#ADD_LIBRARY(libzippp_shared/' ./CMakeLists.txt
    sed -i.orig 's/ADD_EXECUTABLE/#ADD_EXECUTABLE/' ./CMakeLists.txt
    sed -i.orig 's/SET_TARGET_PROPERTIES/#SET_TARGET_PROPERTIES/' ./CMakeLists.txt
    sed -i.orig '/TARGET_LINK_LIBRARIES(/,/)/d' ./CMakeLists.txt

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="Debug"
    else
        BUILD_CONFIGURATION="Release"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION} -DBUILD_SHARED_LIBS=False\
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep
}


buildLibrary "LIBZIPPP"

