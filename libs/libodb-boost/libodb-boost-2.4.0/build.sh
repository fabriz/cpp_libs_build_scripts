#!/bin/bash
# Build script for odb_boost 2.4.0

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    # File "version" clashes with a new header of the Standard Library introduced in C++20
    prepareBuildStep "Patching ${FM_CURRENT_ARCHITECTURE_LIB_TAG} configuration ... "
    moveFile "./version" "./version_odb"
    sed -i.orig 's/dist_doc_DATA = GPLv2 LICENSE README NEWS version/dist_doc_DATA = GPLv2 LICENSE README NEWS version_odb/' ./Makefile.in
    checkBuildStep
}

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

buildCurrentArchitecture__ios_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --disable-shared --host=arm-apple-darwin --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CXXFLAGS="-DLIBODB_STATIC_LIB ${FM_TARGET_TOOLCHAIN_CXXFLAGS}"

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
    
    # Patch files
    sed -i.orig -e '/<ImportLibrary>/d' -e '/<WholeProgramOptimization>/d' -e 's/DynamicLibrary/StaticLibrary/'\
        -e '/<OutDir>/c\<OutDir>..\\..\\tmp_build\\</OutDir>'\
        -e '/<TargetName>/c\<TargetName>odb-boost</TargetName>'\
        -e 's/_USRDLL;LIBODB_BOOST_DYNAMIC_LIB/LIBODB_STATIC_LIB;LIBODB_BOOST_STATIC_LIB/'\
        -e '/<SDLCheck>/a <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>\n<ProgramDataBaseFileName>$(OutDir)$(TargetName).pdb</ProgramDataBaseFileName>'\
        ./odb/boost/libodb-boost-vc12.vcxproj
    
    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    devenv ./libodb-boost-vc12.sln -upgrade
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    devenv ./libodb-boost-vc12.sln -build "${BUILD_CONFIGURATION}|${BUILD_PLATFORM}" -out "${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE}"
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/odb
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    /usr/bin/find ./odb \( -name "*.h" -o -name "*.hxx" -o -name "*.ixx" -o -name "*.txx" \) -exec cp --parents "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/ ';'
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb-boost.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb-boost.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    checkBuildStep
}


buildLibrary "ODBBOOST"
