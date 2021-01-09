#!/bin/bash
# Build script for icu4c 62.1

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

#buildCurrentArchitecture__windows_mingw()
#{
#    :
#}

#buildCurrentArchitecture__windows_msvc()
#{
#    :
#}


buildLibrary "ICU4C"
