#!/bin/bash
# Build script for icu4c 67.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    cd ./source
}

afterBuildCurrentArchitecture()
{
    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/icu"

    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" ]; then
        moveDirectory "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/pkgconfig" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig"
    fi
}

buildCurrentArchitecture__linux_gcc()
{
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST} --with-cross-build=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source"
    fi

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-cross-build=${FM_ARG_BUILD_ROOT}/linux_gcc_x86_64_release/source/${FM_ICU4C_FULL_NAME}/x86_64/source\
        --enable-tools=no --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
    export CFLAGS="-DU_CHARSET_IS_UTF8=1 ${CFLAGS}"

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
#    :
#}

buildCurrentArchitecture__windows_mingw()
{
    sed -i.orig -e '9 i\STATIC_PREFIX =\nSTATIC_PREFIX_WHEN_USED =' \
        -e 's/ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/#ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/' \
        ./config/mh-mingw

    sed -i.orig -e '9 i\STATIC_PREFIX =\nSTATIC_PREFIX_WHEN_USED =' \
        -e 's/ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/#ICULIBSUFFIX:=$(ICULIBSUFFIX)d#M#/' \
        ./config/mh-mingw64

    local BUILD_CONFIGURATION=""
    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
        BUILD_CONFIGURATION="--enable-debug=yes --enable-release=no"
    else
        BUILD_CONFIGURATION="--enable-debug=no --enable-release=yes"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" ${BUILD_CONFIGURATION} --enable-shared=no --enable-static=yes\
        --enable-tests=no --enable-samples=no --with-data-packaging=static\
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
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
#    local BUILD_PLATFORM=""
#    if [ ${FM_TARGET_ARCHITECTURE} = "x86" ]; then
#        BUILD_PLATFORM="Win32"
#    else
#        BUILD_PLATFORM="x64"
#    fi

#    local BUILD_CONFIGURATION=""
#    if [ ${FM_TARGET_BUILD_VARIANT} = "debug" ]; then
#        BUILD_CONFIGURATION="Debug"
#    else
#        BUILD_CONFIGURATION="Release"
#    fi

#    export _CL_="${FM_TARGET_TOOLCHAIN_CFLAGS}"
#    export _LINK_="${FM_TARGET_TOOLCHAIN_LDFLAGS}"

#    devenv ./allinone/allinone.sln -upgrade

#    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    devenv ./allinone/allinone.sln -build "${BUILD_CONFIGURATION}|${BUILD_PLATFORM}" > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
#    checkBuildStep

#    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
#    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
#    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib

#    pushd "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/src/liblzma/api"
#    /usr/bin/find . -name "*.h" -exec cp --parents "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/ ';'
#    popd

#    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/windows/vs2013/${BUILD_CONFIGURATION}/${BUILD_PLATFORM}/liblzma/liblzma.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
#    copyFile ${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/windows/vs2013/${BUILD_CONFIGURATION}/${BUILD_PLATFORM}/liblzma/liblzma.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
#    checkBuildStep
#}


buildLibrary "ICU4C"
