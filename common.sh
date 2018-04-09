#!/bin/bash

# Treat undefined variables as an error
set -o nounset

FM_COMMON_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_COMMON_SCRIPT_DIR}/utility.sh"
source "${FM_COMMON_SCRIPT_DIR}/functions.sh"
source "${FM_COMMON_SCRIPT_DIR}/versions.sh"

# Get command line parameters
if [ ! $# = 3 ]; then
    echo "Usage: $0 <toolchain> <architecture> <variant>"
    printToolchains
    exit 1
fi

FM_ARG_TOOLCHAIN="$(echo $1 | tr '[:upper:]' '[:lower:]')"
FM_ARG_ARCHITECTURE="$(echo $2 | tr '[:upper:]' '[:lower:]')"
FM_ARG_BUILD_VARIANT="$(echo $3 | tr '[:upper:]' '[:lower:]')"


# Disable the option to allow checks
set +o nounset

# Check environment variables
if [ -z "${FM_GLOBAL_TARBALL_CACHE}" ]; then
    error "Tarball cache directory variable FM_GLOBAL_TARBALL_CACHE not set!"
fi

if [ -z "${FM_GLOBAL_BUILD_ROOT}" ]; then
    error "Build root directory variable FM_GLOBAL_BUILD_ROOT not set!"
fi

if [ -z "${FM_GLOBAL_DEPLOY_ROOT}" ]; then
    error "Library deploy  root directory variable FM_GLOBAL_DEPLOY_ROOT not set!"
fi

if [ -z "${FM_GLOBAL_NUM_PROCESSES}" ]; then
    FM_GLOBAL_NUM_PROCESSES=8
fi

# Enable the option again
set -o nounset


# Load toolchain script
FM_TOOLCHAIN_INIT_SCRIPT="${FM_COMMON_SCRIPT_DIR}/toolchains/${FM_ARG_TOOLCHAIN}.sh"
if [ ! -f ${FM_TOOLCHAIN_INIT_SCRIPT} ]; then
    echo "Invalid toolchain: ${FM_ARG_TOOLCHAIN}"
    printToolchains
    exit 1
fi

source ${FM_TOOLCHAIN_INIT_SCRIPT}



FM_TARGET_BUILD_TAG="${FM_TARGET_PLATFORM}_${FM_TARGET_ARCHITECTURE}_${FM_TARGET_BUILD_VARIANT}"

# Build folders
FM_LIBS_BUILD_FOLDER="${FM_GLOBAL_BUILD_ROOT}/${FM_TARGET_BUILD_TAG}"
FM_LIBS_BUILD_SOURCE="${FM_LIBS_BUILD_FOLDER}/source"
FM_LIBS_BUILD_LOGS="${FM_LIBS_BUILD_FOLDER}/logs"

# Install folders
FM_LIBS_INSTALL_PREFIX="${FM_GLOBAL_DEPLOY_ROOT}/${FM_TARGET_BUILD_TAG}"
FM_LIBS_INSTALL_INCLUDES="${FM_LIBS_INSTALL_PREFIX}/include"
FM_LIBS_INSTALL_LIBS="${FM_LIBS_INSTALL_PREFIX}/lib"
FM_LIBS_INSTALL_DLLS="${FM_LIBS_INSTALL_PREFIX}/dll"


# Directory creation
createDirectory ${FM_GLOBAL_TARBALL_CACHE}

createDirectory ${FM_LIBS_BUILD_FOLDER}
createDirectory ${FM_LIBS_BUILD_SOURCE}
createDirectory ${FM_LIBS_BUILD_LOGS}

createDirectory ${FM_LIBS_INSTALL_PREFIX}
createDirectory ${FM_LIBS_INSTALL_INCLUDES}
createDirectory ${FM_LIBS_INSTALL_LIBS}

if [ ${FM_TARGET_HAS_DLLS} = "true" ]; then
    createDirectory ${FM_LIBS_INSTALL_DLLS}
fi

