#!/bin/bash

# Treat undefined variables as an error
set -o nounset

FM_COMMON_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_COMMON_SCRIPT_DIR}/utility.sh"
source "${FM_COMMON_SCRIPT_DIR}/functions.sh"
source "${FM_COMMON_SCRIPT_DIR}/versions.sh"

# Get command line parameters
if [ ! $# = 3 ]; then
    echo "Usage: $0 <toolchain> <architecture> <variant(s)>"
    printToolchains
    exit 1
fi

FM_ARG_TOOLCHAIN="$(echo $1 | tr '[:upper:]' '[:lower:]')"
FM_ARG_ARCHITECTURE="$(echo $2 | tr '[:upper:]' '[:lower:]')"
FM_ARG_BUILD_VARIANTS="$(echo $3 | tr '[:upper:]' '[:lower:]')"


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

# Directory creation
createDirectory ${FM_GLOBAL_TARBALL_CACHE}
createDirectory ${FM_GLOBAL_BUILD_ROOT}
createDirectory ${FM_GLOBAL_DEPLOY_ROOT}

# Load toolchain script
FM_TOOLCHAIN_INIT_SCRIPT="${FM_COMMON_SCRIPT_DIR}/toolchains/${FM_ARG_TOOLCHAIN}.sh"
if [ ! -f ${FM_TOOLCHAIN_INIT_SCRIPT} ]; then
    echo "Invalid toolchain: ${FM_ARG_TOOLCHAIN}"
    printToolchains
    exit 1
fi

source ${FM_TOOLCHAIN_INIT_SCRIPT}

