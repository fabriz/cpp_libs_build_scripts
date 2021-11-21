#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for libxslt 1.1.34

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


afterBuildCurrentArchitecture()
{
    moveFileIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/xsltConf.sh" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/xsltConf.sh"

    moveDirectoryIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/libxslt-plugins" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/libxslt-plugins"
    moveDirectoryIfPresent "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/python2.7" "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/python2.7"
}

buildCurrentArchitecture__linux_gcc()
{
    local CROSS_COMPILER_HOST=""
    if [ -n "${FM_TARGET_CROSS_COMPILER_HOST-}" ]; then
        CROSS_COMPILER_HOST="--host=${FM_TARGET_CROSS_COMPILER_HOST}"
    fi

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure ${CROSS_COMPILER_HOST} --disable-shared --without-python \
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
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --host=${FM_TARGET_CROSS_COMPILER_HOST} --disable-shared --without-python \
        --with-libxml-include-prefix="${FM_LIBS_INSTALL_INCLUDES}" --with-libxml-libs-prefix="${FM_LIBS_INSTALL_LIBS}" \
        --prefix=${FM_CURRENT_ARCHITECTURE_STAGE_DIR} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    pushd "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/libxslt"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    popd

    echo "--------------------" >> ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE}
    echo "--------------------" >> ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE}

    pushd "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/libexslt"

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} >> ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install >> ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    popd
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --disable-shared --without-python \
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
#}

buildCurrentArchitecture__windows_mingw()
{
    export CPPFLAGS="${CPPFLAGS} -DLIBXML_STATIC=1"

    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    ./configure --build="${FM_TARGET_MINGW_PLATFORM}" --disable-shared --without-python \
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
#}


buildLibrary "LIBXSLT"
