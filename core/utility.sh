#!/bin/bash


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

copyFile()
{
    [ $# = 2 ] || error "copyFile(): invalid number of arguments"

    local LOCAL_COPY_SOURCE=$1
    local LOCAL_COPY_DESTINATION=$2

    cp "${LOCAL_COPY_SOURCE}" "${LOCAL_COPY_DESTINATION}" || error "Cannot copy file ${LOCAL_COPY_SOURCE} to ${LOCAL_COPY_DESTINATION}"
}

deleteFile()
{
    [ $# = 1 ] || error "deleteFile(): invalid number of arguments"

    local LOCAL_DELETE_TARGET=$1

    rm "${LOCAL_DELETE_TARGET}" || error "Cannot delete file ${LOCAL_DELETE_TARGET}"
}
