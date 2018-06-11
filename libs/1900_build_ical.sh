#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    
    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    prepareBuildStep "Decompressing ${LIB_TARBALL_LOCAL_PATH} ... "
    tar --exclude=*/ReadMe.md -xz -f ${LIB_TARBALL_LOCAL_PATH} -C ${FM_CURRENT_LIB_SOURCE_DIR} || error "Cannot decompress file ${LIB_TARBALL_LOCAL_PATH} to ${FM_CURRENT_LIB_SOURCE_DIR}"
    checkBuildStep

    mv "${FM_CURRENT_LIB_SOURCE_DIR}/${FM_CURRENT_LIB_NAME}"-* "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

buildCurrentArchitecture__linux_gcc()
{
    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="Debug"
    else
        BUILD_CONFIGURATION="Release"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION} -DSTATIC_ONLY=True\
        -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DWITH_CXX_BINDINGS=False -DGOBJECT_INTROSPECTION=False\
        -DICAL_GLIB_VAPI=False -DICAL_GLIB=False -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    :
}

buildCurrentArchitecture__ios_clang()
{
    :
}

buildCurrentArchitecture__windows_mingw()
{
    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="Debug"
    else
        BUILD_CONFIGURATION="Release"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    cmake -G"MSYS Makefiles" -DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION} -DSTATIC_ONLY=True\
        -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DWITH_CXX_BINDINGS=False -DGOBJECT_INTROSPECTION=False\
        -DICAL_GLIB_VAPI=False -DICAL_GLIB=False -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="Debug"
    else
        BUILD_CONFIGURATION="Release"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=${BUILD_CONFIGURATION} -DSTATIC_ONLY=True\
        -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DWITH_CXX_BINDINGS=False -DGOBJECT_INTROSPECTION=False\
        -DICAL_GLIB_VAPI=False -DICAL_GLIB=False -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
    
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        copyFile ./src/libical/CMakeFiles/ical.dir/ical.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
        copyFile ./src/libicalss/CMakeFiles/icalss.dir/icalss.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
        copyFile ./src/libicalvcal/CMakeFiles/icalvcal.dir/icalvcal.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    fi
    
    rm ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/*-static.lib
    rm -rf ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/cmake
    rm -rf ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig
}


buildLibrary "ICAL"

