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
    :
}


buildLibrary "LIBZIPPP"

