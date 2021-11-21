#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

playBeep()
{
    local LOCAL_SYSTEM_NAME="$(uname | tr '[:upper:]' '[:lower:]')"

    if [ ${LOCAL_SYSTEM_NAME} = "darwin" ]; then
        local LOCAL_ECHO_CMD=$(which gecho)
    else
        local LOCAL_ECHO_CMD=$(which echo)
    fi

    if [ -n "${LOCAL_ECHO_CMD}" ]; then
        "${LOCAL_ECHO_CMD}" -en "\a"
    fi
}

success()
{
    playBeep

    if [ -n "${FM_CONFIG_ON_BUILD_SUCCESS-}" ]; then
        eval "${FM_CONFIG_ON_BUILD_SUCCESS}"
    fi

    exit 0
}

error()
{
    playBeep
    echo "ERROR: $@"

    if [ -n "${FM_CONFIG_ON_BUILD_ERROR-}" ]; then
        eval "${FM_CONFIG_ON_BUILD_ERROR}"
    fi

    exit 1
}

pushd()
{
    command pushd "$@" > /dev/null
}

popd()
{
    command popd "$@" > /dev/null
}

isFunctionDefined()
{
    [ $# = 1 ] || error "isFunctionDefined(): invalid number of arguments"

    local LOCAL_FUNCTION_NAME=$1

    declare -Ff "${LOCAL_FUNCTION_NAME}" >/dev/null;
}

isItemInArray()
{
    [ $# = 2 ] || error "isItemInArray(): invalid number of arguments"

    local LOCAL_ITEM="$1"
    local LOCAL_ARRAY="$2"

    local LOCAL_ARRAY_ITEM=""
    for LOCAL_ARRAY_ITEM in ${LOCAL_ARRAY}
    do
        if [ "${LOCAL_ITEM}" = "${LOCAL_ARRAY_ITEM}" ]; then
            return 0
        fi
    done

    return 1
}

createDirectory()
{
    [ $# = 1 ] || error "createDirectory(): invalid number of arguments"

    local LOCAL_DIRECTORY_PATH=$1

    if [ ! -f "${LOCAL_DIRECTORY_PATH}" ]; then
        mkdir -p "${LOCAL_DIRECTORY_PATH}" || error "Cannot create directory ${LOCAL_DIRECTORY_PATH}"
    fi
}

deleteDirectory()
{
    [ $# = 1 ] || error "deleteDirectory(): invalid number of arguments"

    local LOCAL_DIRECTORY_PATH=$1

    if [ -d "${LOCAL_DIRECTORY_PATH}" ]; then
        rmdir "${LOCAL_DIRECTORY_PATH}" || error "Cannot delete directory ${LOCAL_DIRECTORY_PATH}"
    fi
}

deleteDirectoryRecursive()
{
    [ $# = 1 ] || error "deleteDirectoryRecursive(): invalid number of arguments"

    local LOCAL_DIRECTORY_PATH=$1

    # Sanity check: refuse to delete if path is too short
    if [ ${#LOCAL_DIRECTORY_PATH} -le 20 ]; then
        error "deleteDirectoryRecursive(): path too short: ${LOCAL_DIRECTORY_PATH}"
    fi

    if [ -d "${LOCAL_DIRECTORY_PATH}" ]; then
        rm -rf "${LOCAL_DIRECTORY_PATH}" || error "Cannot delete directory ${LOCAL_DIRECTORY_PATH}"
    fi
}

moveDirectory()
{
    [ $# = 2 ] || error "moveDirectory(): invalid number of arguments"

    local LOCAL_MOVE_SOURCE=$1
    local LOCAL_MOVE_DESTINATION=$2

    local LOCAL_MAX_TRY=10
    local LOCAL_I_TRY=1
    while true; do
        mv "${LOCAL_MOVE_SOURCE}" "${LOCAL_MOVE_DESTINATION}" > /dev/null 2>&1 && break || {
            echo "Move directory failed ($LOCAL_I_TRY/$LOCAL_MAX_TRY)"
            echo "    From: ${LOCAL_MOVE_SOURCE}"
            echo "      To: ${LOCAL_MOVE_DESTINATION}"
            if [ $LOCAL_I_TRY -lt $LOCAL_MAX_TRY ]; then
              ((LOCAL_I_TRY++))
              playBeep
              sleep 5
            else
                error "Cannot move directory ${LOCAL_MOVE_SOURCE} to ${LOCAL_MOVE_DESTINATION}"
            fi
        }
    done
}

moveDirectoryIfPresent()
{
    [ $# = 2 ] || error "moveDirectoryIfPresent(): invalid number of arguments"

    local LOCAL_MOVE_SOURCE=$1
    local LOCAL_MOVE_DESTINATION=$2

    if [ -d "${LOCAL_MOVE_SOURCE}" ]; then
        moveDirectory "${LOCAL_MOVE_SOURCE}" "${LOCAL_MOVE_DESTINATION}"
    fi
}

moveFile()
{
    [ $# = 2 ] || error "moveFile(): invalid number of arguments"

    local LOCAL_MOVE_SOURCE=$1
    local LOCAL_MOVE_DESTINATION=$2

    local LOCAL_MAX_TRY=10
    local LOCAL_I_TRY=1
    while true; do
        mv "${LOCAL_MOVE_SOURCE}" "${LOCAL_MOVE_DESTINATION}" > /dev/null 2>&1 && break || {
            echo "Move file failed ($LOCAL_I_TRY/$LOCAL_MAX_TRY)"
            echo "    From: ${LOCAL_MOVE_SOURCE}"
            echo "      To: ${LOCAL_MOVE_DESTINATION}"
            if [ $LOCAL_I_TRY -lt $LOCAL_MAX_TRY ]; then
              ((LOCAL_I_TRY++))
              playBeep
              sleep 5
            else
                error "Cannot move file ${LOCAL_MOVE_SOURCE} to ${LOCAL_MOVE_DESTINATION}"
            fi
        }
    done
}

moveFileIfPresent()
{
    [ $# = 2 ] || error "moveFileIfPresent(): invalid number of arguments"

    local LOCAL_MOVE_SOURCE=$1
    local LOCAL_MOVE_DESTINATION=$2

    if [ -f "${LOCAL_MOVE_SOURCE}" ]; then
        moveFile "${LOCAL_MOVE_SOURCE}" "${LOCAL_MOVE_DESTINATION}"
    fi
}

copyFile()
{
    [ $# = 2 ] || error "copyFile(): invalid number of arguments"

    local LOCAL_COPY_SOURCE=$1
    local LOCAL_COPY_DESTINATION=$2

    cp "${LOCAL_COPY_SOURCE}" "${LOCAL_COPY_DESTINATION}" || error "Cannot copy file ${LOCAL_COPY_SOURCE} to ${LOCAL_COPY_DESTINATION}"
}

copyFileIfPresent()
{
    [ $# = 2 ] || error "copyFileIfPresent(): invalid number of arguments"

    local LOCAL_COPY_SOURCE=$1
    local LOCAL_COPY_DESTINATION=$2

    if [ -f "${LOCAL_COPY_SOURCE}" ]; then
        moveFile "${LOCAL_COPY_SOURCE}" "${LOCAL_COPY_DESTINATION}"
    fi
}

deleteFile()
{
    [ $# = 1 ] || error "deleteFile(): invalid number of arguments"

    local LOCAL_DELETE_TARGET=$1

    rm "${LOCAL_DELETE_TARGET}" || error "Cannot delete file ${LOCAL_DELETE_TARGET}"
}

acquireLock()
{
    [ $# = 1 ] || error "acquireLock(): invalid number of arguments"

    local LOCAL_LOCK_DIRECTORY_PATH=$1
    local LOCAL_LOCK_INITIALLY_BUSY=false

    while true; do
        if mkdir "${LOCAL_LOCK_DIRECTORY_PATH}" > /dev/null 2>&1; then
            if [ ${LOCAL_LOCK_INITIALLY_BUSY} = true ]; then
                echo "ACQUIRED"
            fi
            break;
        else
            if [ ${LOCAL_LOCK_INITIALLY_BUSY} = false ]; then
                LOCAL_LOCK_INITIALLY_BUSY=true
                printf "Waiting to acquire lock: ${LOCAL_LOCK_DIRECTORY_PATH} ... "
            fi
            sleep 1
        fi
    done
}

releaseLock()
{
    [ $# = 1 ] || error "releaseLock(): invalid number of arguments"

    local LOCAL_LOCK_DIRECTORY_PATH=$1

    deleteDirectory "${LOCAL_LOCK_DIRECTORY_PATH}"
}
