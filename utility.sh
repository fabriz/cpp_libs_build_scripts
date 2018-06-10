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

error()
{
    playBeep
    echo "ERROR: $@"
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

createDirectory()
{
    [ $# = 1 ] || error "createDirectory(): invalid number of arguments"

    local DIRECTORY_PATH=$1

    if [ ! -f "${DIRECTORY_PATH}" ]; then
        mkdir -p "${DIRECTORY_PATH}" || error "Cannot create directory ${DIRECTORY_PATH}"
    fi
}

copyFile()
{
    [ $# = 2 ] || error "copyFile(): invalid number of arguments"

    local COPY_SOURCE=$1
    local COPY_DESTINATION=$2
    
    cp "${COPY_SOURCE}" "${COPY_DESTINATION}" || error "Cannot copy file ${COPY_SOURCE} to ${COPY_DESTINATION}"
}

downloadFile()
{
    [ $# = 2 ] || error "downloadFile(): invalid number of arguments"

    local DOWNLOAD_SOURCE=$1
    local DOWNLOAD_DESTINATION=$2

    echo "Downloading ${DOWNLOAD_SOURCE} to ${DOWNLOAD_DESTINATION}"

    local DOWNLOAD_OPTIONS=""
    #local DOWNLOAD_OPTIONS="--insecure"

    curl ${DOWNLOAD_OPTIONS} -L -o ${DOWNLOAD_DESTINATION} ${DOWNLOAD_SOURCE} || error "Cannot download ${DOWNLOAD_SOURCE} to ${DOWNLOAD_DESTINATION}"
}

