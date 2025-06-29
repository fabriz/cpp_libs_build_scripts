#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for ical 3.0.20

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False -DLIBICAL_BUILD_EXAMPLES=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} makefile ... "
    sed -i.orig 's/add_subdirectory(test)/#add_subdirectory(test)/' ./src/CMakeLists.txt
    checkBuildStep

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__ios_clang()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ./src/libicalss/icalfileset.c ... "
    sed -i.orig 's/if (system(tmp) < 0)/if (1)/' ./src/libicalss/icalfileset.c
    checkBuildStep

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__windows_msvc()
{
    export _CL_="${FM_TARGET_TOOLCHAIN_CXXFLAGS_CMAKE}"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        -DSTATIC_ONLY=True -DCMAKE_DISABLE_FIND_PACKAGE_ICU=True -DGOBJECT_INTROSPECTION=False \
        -DICAL_BUILD_DOCS=False -DLIBICAL_BUILD_TESTING=False -DICAL_GLIB_VAPI=False -DICAL_GLIB=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
    
    copyFileIfPresent ./src/libical/CMakeFiles/ical.dir/ical.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFileIfPresent ./src/libicalss/CMakeFiles/icalss.dir/icalss.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFileIfPresent ./src/libicalss/CMakeFiles/icalss_cxx.dir/icalss_cxx.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFileIfPresent ./src/libicalvcal/CMakeFiles/icalvcal.dir/icalvcal.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFileIfPresent ./src/libical/CMakeFiles/ical_cxx.dir/ical_cxx.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
}


buildLibrary "ICAL"
