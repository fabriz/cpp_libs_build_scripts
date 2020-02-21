#!/bin/bash
# Build script for odb 2.4.0

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_LIBS_BUILD_ROOT_SCRIPT_DIR}/common.sh"


afterBuildCurrentArchitecture()
{
    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig"
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --disable-shared --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    make -j${FM_GLOBAL_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
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
    if [ ${FM_TARGET_ARCHITECTURE} = "i386" ]; then
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

    local TOOLS_VERSION=""
    if [ ${FM_TARGET_TOOLCHAIN_VERSION} = "14.0" ]; then
        TOOLS_VERSION="14.0"
    elif [ ${FM_TARGET_TOOLCHAIN_VERSION} = "14.1" ]; then
        TOOLS_VERSION="15.0"
    else
        error "Unsupported MSVC toolchain: ${FM_TARGET_TOOLCHAIN_VERSION}."
    fi

    local LIBS_INTERMEDIATE_BUILD_WIN=`cygpath -w ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/intermediate/`
    local LIBS_OUT_BUILD_WIN=`cygpath -w ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/`
    
    # Patch files
    sed -i.orig '/<ImportLibrary>/d' ./odb/libodb-vc12.vcxproj
    
    echo "" >> ./odb/compilers/vc/pre.hxx
    echo "#pragma warning (disable:4275)" >> ./odb/compilers/vc/pre.hxx
    
    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

    devenv ./libodb-vc12.sln -upgrade
    
    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    msbuild.exe libodb-vc12.sln /toolsversion:${TOOLS_VERSION} /target:Build /property:Platform=${BUILD_PLATFORM}\
        /property:Configuration=${BUILD_CONFIGURATION} /property:TargetName="odb" /property:IntermediateOutputPath="${LIBS_INTERMEDIATE_BUILD_WIN}"\
        /property:OutDir="${LIBS_OUT_BUILD_WIN}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/odb
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll
    /usr/bin/find ./odb \( -name "*.h" -o -name "*.hxx" -o -name "*.ixx" -o -name "*.txx" \) -exec cp --parents "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/ ';'
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb.dll ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll
    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/tmp_build/odb.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll
    checkBuildStep
}


buildLibrary "ODB"
