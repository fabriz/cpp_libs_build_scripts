#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libmusicbrainz 5.1.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} makefile ... "

    sed -i.orig -e 's/ADD_SUBDIRECTORY(tests)/#ADD_SUBDIRECTORY(tests)/' \
                -e 's/ADD_SUBDIRECTORY(examples)/#ADD_SUBDIRECTORY(examples)/' ./CMakeLists.txt

    if [ ${FM_TARGET_TOOLCHAIN} = "macos_clang" ]; then
        sed -i.orig -e 's/SHARED/STATIC/' \
                    -e 's/${LIBXML2_LIBRARIES}/${LIBXML2_LIBRARIES} lzma z iconv/' ./src/CMakeLists.txt
#    elif [ ${FM_TARGET_TOOLCHAIN} = "ios_clang" ]; then
#        sed -i.orig -e 's/SHARED/STATIC/' \
#                    -e 's/${LIBXML2_LIBRARIES}/${LIBXML2_LIBRARIES} lzma z iconv/' ./src/CMakeLists.txt
    elif [ ${FM_TARGET_TOOLCHAIN} = "windows_mingw" ]; then
        sed -i.orig -e 's/SHARED/STATIC/' \
                    -e 's/${LIBXML2_LIBRARIES}/${LIBXML2_LIBRARIES} lzma z iconv wsock32 winmm ws2_32/' ./src/CMakeLists.txt

        # Implementation of timersub taken from https://github.com/msysgit/msys/blob/master/newlib/libc/include/sys/time.h
        sed -i.orig -e '1s/^/#define timersub(a, b, result) do {(result)->tv_sec = (a)->tv_sec - (b)->tv_sec;(result)->tv_usec = (a)->tv_usec - (b)->tv_usec;if ((result)->tv_usec < 0) {--(result)->tv_sec;(result)->tv_usec += 1000000;}} while (0) /' ./src/Query.cc

    else
        sed -i.orig -e 's/SHARED/STATIC/' \
                    -e 's/${LIBXML2_LIBRARIES}/${LIBXML2_LIBRARIES} lzma z/' ./src/CMakeLists.txt
    fi

    checkBuildStep
    
    THIS_SCRIPT_OPTIONAL_BUILD_FLAGS=""
    if isLibraryInstalled "LIBXML2"; then
        THIS_SCRIPT_OPTIONAL_BUILD_FLAGS="${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DLIBXML2_INCLUDE_DIR=${FM_LIBS_INSTALL_INCLUDES}/libxml2"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILATION_FLAGS=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILATION_FLAGS="-DCMAKE_SYSTEM_NAME=Linux -DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_MUSICBRAINZ_FULL_NAME}/x86_64/ImportExecutables.cmake"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        ${CROSS_COMPILATION_FLAGS} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DBUILD_SHARED_LIBS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local CROSS_COMPILATION_FLAGS="-DCMAKE_SYSTEM_NAME=Linux -DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_MUSICBRAINZ_FULL_NAME}/x86_64/ImportExecutables.cmake"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        ${CROSS_COMPILATION_FLAGS} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DBUILD_SHARED_LIBS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local CROSS_COMPILATION_FLAGS=""
    if [ ${FM_TARGET_IS_CROSS_COMPILING} = true ]; then
        CROSS_COMPILATION_FLAGS="-DCMAKE_SYSTEM_NAME=Darwin -DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/macos_clang_${FM_HOST_ARCHITECTURE}_release/source/${FM_MUSICBRAINZ_FULL_NAME}/${FM_HOST_ARCHITECTURE}/ImportExecutables.cmake"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        ${CROSS_COMPILATION_FLAGS} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DBUILD_SHARED_LIBS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local CROSS_COMPILATION_FLAGS="-DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/macos_clang_${FM_HOST_ARCHITECTURE}_release/source/${FM_MUSICBRAINZ_FULL_NAME}/${FM_HOST_ARCHITECTURE}/ImportExecutables.cmake"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        ${CROSS_COMPILATION_FLAGS} ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DBUILD_SHARED_LIBS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CXXFLAGS="${CXXFLAGS} -DLIBXML_STATIC"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_GENERATE} \
        ${THIS_SCRIPT_OPTIONAL_BUILD_FLAGS} -DBUILD_SHARED_LIBS=False > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_BUILD} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" ${FM_TARGET_CMAKE_ARGUMENTS_INSTALL} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__windows_msvc()
#{
#}


buildLibrary "MUSICBRAINZ"
