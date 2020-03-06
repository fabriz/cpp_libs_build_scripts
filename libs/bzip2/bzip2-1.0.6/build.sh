#!/bin/bash
# Build script for bzip2 1.0.6

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/common.sh"


beforeBuildCurrentArchitecture()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} makefile ... "
    sed -i.orig 's/all: libbz2.a bzip2 bzip2recover test/all: libbz2.a bzip2 bzip2recover/' ./Makefile
    checkBuildStep
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} AR="${AR}" CC="${CC}" CFLAGS="${CFLAGS}" RANLIB="${RANLIB}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake -f makefile.msc CFLAGS="${FM_TARGET_TOOLCHAIN_CFLAGS} -D_FILE_OFFSET_BITS=64 -Fd\"libbz2.pdb\"" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile bzlib.h ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    copyFile libbz2.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile libbz2.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    checkBuildStep
}


buildLibrary "BZIP2"
