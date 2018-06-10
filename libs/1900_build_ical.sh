#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPT_DIR}/../common.sh"


buildCurrentArchitecture__linux_gcc()
{
    :
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
    :
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
}


buildLibrary "ICAL"

