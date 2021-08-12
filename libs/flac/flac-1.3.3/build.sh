#!/bin/bash
# Build script for flac 1.3.3

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    ./configure --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    sed -i.orig 's/-D_FORTIFY_SOURCE=2//g' ./configure

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    local BUILD_PLATFORM=""
    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
        BUILD_PLATFORM="Win32"
    else
        BUILD_PLATFORM="x64"
    fi

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="Debug"
    else
        BUILD_CONFIGURATION="Release"
    fi

    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    # Patch files
    cp ./src/libFLAC/libFLAC_static.vcxproj ./src/libFLAC/libFLAC.vcxproj
    cp ./src/libFLAC++/libFLAC++_static.vcxproj ./src/libFLAC++/libFLAC++.vcxproj
    sed -i.orig -e 's/libFLAC_static/libFLAC/g' -e 's/libFLAC++_static/libFLAC++/g' ./FLAC.sln
    sed -i.orig -e 's/libFLAC_static/libFLAC/g' ./src/libFLAC/libFLAC.vcxproj
    sed -i.orig -e 's/libFLAC_static/libFLAC/g' -e 's/libFLAC++_static/libFLAC++/g' ./src/libFLAC++/libFLAC++.vcxproj

    devenv ./FLAC.sln -upgrade

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    devenv ./FLAC.sln -build "${BUILD_CONFIGURATION}|${BUILD_PLATFORM}" -project "libFLAC" -out "${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE}"
    devenv ./FLAC.sln -build "${BUILD_CONFIGURATION}|${BUILD_PLATFORM}" -project "libFLAC++" -out "${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE}"
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/FLAC
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/FLAC++
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    /usr/bin/find ./include/FLAC \( -name "*.h" \) -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/FLAC ';'
    /usr/bin/find ./include/FLAC++ \( -name "*.h" \) -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/FLAC++ ';'

    if [ ${BUILD_PLATFORM} = "x64" ]; then
        /usr/bin/find ./objs/${BUILD_PLATFORM}/${BUILD_CONFIGURATION}/lib -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib ';'
    else
        /usr/bin/find ./objs/${BUILD_CONFIGURATION}/lib \( -name "*.lib" -o -name "*.pdb" \) -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib ';'
    fi
    checkBuildStep
}


buildLibrary "FLAC"
