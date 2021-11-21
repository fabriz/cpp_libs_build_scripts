#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Build script for sqlite 3.23.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    if [ -n "${CFLAGS-}" ]; then
        export CFLAGS="${CFLAGS} -DSQLITE_ENABLE_UNLOCK_NOTIFY=1"
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
    ADDITIONAL_FLAG=""
    case ${FM_TARGET_BUILD_VARIANT} in
        debug)
            ADDITIONAL_FLAG="-MDd -Zi -Fdsqlite3.pdb -DSQLITE_ENABLE_API_ARMOR=1"
        ;;
        release)
            ADDITIONAL_FLAG="-MD -O2 -DNDEBUG"
        ;;
        profile)
            ADDITIONAL_FLAG="-MD -Zi -Fdsqlite3.pdb -O2 -DNDEBUG"
        ;;
    esac

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "

    cl -W4 -Fosqlite3.obj -c -fp:precise -I. ${ADDITIONAL_FLAG}\
        -DINCLUDE_MSVC_H=1 -DSQLITE_OS_WIN=1 -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE \
        -D_CRT_NONSTDC_NO_WARNINGS -DSQLITE_THREADSAFE=1 -DSQLITE_THREAD_OVERRIDE_LOCK=-1 -DSQLITE_TEMP_STORE=1\
        -DSQLITE_MAX_TRIGGER_DEPTH=100  -DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_RTREE=1 -DSQLITE_ENABLE_GEOPOLY=1 -DSQLITE_ENABLE_JSON1=1\
        -DSQLITE_ENABLE_STMTVTAB=1 -DSQLITE_ENABLE_DBPAGE_VTAB=1 -DSQLITE_ENABLE_DBSTAT_VTAB=1 -DSQLITE_ENABLE_DESERIALIZE=1\
        -DSQLITE_ENABLE_COLUMN_METADATA=1 -DSQLITE_ENABLE_UNLOCK_NOTIFY=1\
         sqlite3.c > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1

    lib /OUT:sqlite3.lib sqlite3.obj >> ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1

    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    createDirectory ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFile sqlite3.h ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    copyFile sqlite3ext.h ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include
    copyFile sqlite3.lib ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    copyFileIfPresent sqlite3.pdb ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib
    checkBuildStep
}


buildLibrary "SQLITE"
