#!/bin/bash

FM_UTILITY_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


playBeep()
{
    local SYSTEM_NAME="$(uname | tr '[:upper:]' '[:lower:]')"

    if [ ${SYSTEM_NAME} = "darwin" ]; then
        local ECHO_CMD=`which gecho`
    else
        local ECHO_CMD=`which echo`
    fi

    if [ -n "${ECHO_CMD}" ]; then
        "${ECHO_CMD}" -en "\a"
    fi
}

success()
{
    playBeep

    if [ -n "${FM_GLOBAL_ON_BUILD_SUCCESS-}" ]; then
        eval "${FM_GLOBAL_ON_BUILD_SUCCESS}"
    fi

    exit 0
}

error()
{
    playBeep
    echo "ERROR: $@"

    if [ -n "${FM_GLOBAL_ON_BUILD_ERROR-}" ]; then
        eval "${FM_GLOBAL_ON_BUILD_ERROR}"
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

printLibsets()
{
    pushd "${FM_UTILITY_SCRIPT_DIR}/libsets"
    local FM_AVAILABLE_LIBSETS=(*.sh)
    popd

    echo "Available libsets are: "
    for FM_AVAILABLE_LIBSET in "${FM_AVAILABLE_LIBSETS[@]}"
    do
        echo "    ${FM_AVAILABLE_LIBSET%.*}"
    done
}

printToolchains()
{
    pushd "${FM_UTILITY_SCRIPT_DIR}/toolchains"
    local FM_AVAILABLE_TOOLCHAINS=(*.sh)
    popd

    echo "Available toolchains are: "
    for FM_AVAILABLE_TOOLCHAIN in "${FM_AVAILABLE_TOOLCHAINS[@]}"
    do
        echo "    ${FM_AVAILABLE_TOOLCHAIN%.*}"
    done
}

isFunctionDefined()
{
    [ $# = 1 ] || error "isFunctionDefined(): invalid number of arguments"

    local FUNCTION_NAME=$1

    declare -Ff "${FUNCTION_NAME}" >/dev/null;
}

createDirectory()
{
    [ $# = 1 ] || error "createDirectory(): invalid number of arguments"

    local DIRECTORY_PATH=$1

    if [ ! -f "${DIRECTORY_PATH}" ]; then
        mkdir -p "${DIRECTORY_PATH}" || error "Cannot create directory ${DIRECTORY_PATH}"
    fi
}

deleteDirectory()
{
    [ $# = 1 ] || error "deleteDirectory(): invalid number of arguments"

    local DIRECTORY_PATH=$1

    if [ -d "${DIRECTORY_PATH}" ]; then
        rmdir "${DIRECTORY_PATH}" || error "Cannot delete directory ${DIRECTORY_PATH}"
    fi
}

deleteDirectoryRecursive()
{
    [ $# = 1 ] || error "deleteDirectoryRecursive(): invalid number of arguments"

    local DIRECTORY_PATH=$1

    # Sanity check: refuse to delete if path is too short
    if [ ${#DIRECTORY_PATH} -le 20 ]; then
        error "deleteDirectoryRecursive(): path too short: ${DIRECTORY_PATH}"
    fi

    if [ -d "${DIRECTORY_PATH}" ]; then
        rm -rf "${DIRECTORY_PATH}" || error "Cannot delete directory ${DIRECTORY_PATH}"
    fi
}

moveDirectory()
{
    [ $# = 2 ] || error "moveDirectory(): invalid number of arguments"

    local MOVE_SOURCE=$1
    local MOVE_DESTINATION=$2

    mv "${MOVE_SOURCE}" "${MOVE_DESTINATION}" || error "Cannot move directory ${MOVE_SOURCE} to ${MOVE_DESTINATION}"
}

moveFile()
{
    [ $# = 2 ] || error "moveFile(): invalid number of arguments"

    local MOVE_SOURCE=$1
    local MOVE_DESTINATION=$2

    mv "${MOVE_SOURCE}" "${MOVE_DESTINATION}" || error "Cannot move file ${MOVE_SOURCE} to ${MOVE_DESTINATION}"
}

copyFile()
{
    [ $# = 2 ] || error "copyFile(): invalid number of arguments"

    local COPY_SOURCE=$1
    local COPY_DESTINATION=$2

    cp "${COPY_SOURCE}" "${COPY_DESTINATION}" || error "Cannot copy file ${COPY_SOURCE} to ${COPY_DESTINATION}"
}

