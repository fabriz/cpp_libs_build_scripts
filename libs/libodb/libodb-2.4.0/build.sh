#!/bin/bash
# Build script for odb 2.4.0

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

afterBuildCurrentArchitecture()
{
    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" ]; then
        moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig"
    fi
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

    local FILE_SOURCE_DIR="${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/odb/details/win32"
    local FILE_DEST_DIR="${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/odb/details/win32"
    mkdir "${FILE_DEST_DIR}"
    cp "${FILE_SOURCE_DIR}/windows.hxx" "${FILE_DEST_DIR}"
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
        -e '/<OutDir>/c\<OutDir>..\\tmp_build\\</OutDir>'\
        -e '/<TargetName>/c\<TargetName>odb</TargetName>'\
        -e 's/_USRDLL;LIBODB_DYNAMIC_LIB/LIBODB_STATIC_LIB/'\
        -e '/<SDLCheck>/a <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>\n<ProgramDataBaseFileName>$(OutDir)$(TargetName).pdb</ProgramDataBaseFileName>'\
        ./odb/libodb-vc12.vcxproj

    echo "" >> ./odb/compilers/vc/pre.hxx
    echo "#pragma warning (disable:4275)" >> ./odb/compilers/vc/pre.hxx
    
    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    devenv ./libodb-vc12.sln -upgrade
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    devenv ./libodb-vc12.sln -build "${BUILD_CONFIGURATION}|${BUILD_PLATFORM}" -out "${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE}"
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/odb
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    /usr/bin/find ./odb \( -name "*.h" -o -name "*.hxx" -o -name "*.ixx" -o -name "*.txx" \) -exec cp --parents "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/ ';'
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    checkBuildStep
}


buildLibrary "ODB"
