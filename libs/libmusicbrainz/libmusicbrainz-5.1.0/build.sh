#!/bin/bash
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
}

afterBuildCurrentArchitecture()
{
    moveDirectoryIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig"
}

buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILATION_FLAGS=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILATION_FLAGS="-DCMAKE_SYSTEM_NAME=Linux -DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_MUSICBRAINZ_FULL_NAME}/x86_64/ImportExecutables.cmake"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} ${CROSS_COMPILATION_FLAGS} \
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} \
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local CROSS_COMPILATION_FLAGS="-DCMAKE_SYSTEM_NAME=Linux -DIMPORT_EXECUTABLES=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_MUSICBRAINZ_FULL_NAME}/x86_64/ImportExecutables.cmake"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} ${CROSS_COMPILATION_FLAGS} \
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} \
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} \
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} \
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__ios_clang()
#{
#}

buildCurrentArchitecture__windows_mingw()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} \
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} \
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__windows_msvc()
#{
#}


buildLibrary "MUSICBRAINZ"
