#!/bin/bash

# Treat undefined variables as an error
set -o nounset

FM_COMMON_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_COMMON_SCRIPT_DIR}/utility.sh"
source "${FM_COMMON_SCRIPT_DIR}/functions.sh"

# Get command line parameters
if [ ! $# = 4 ]; then
    echo "Usage: $0 <libset> <toolchain> <architecture> <variant(s)>"
    printLibsets
    printToolchains
    exit 1
fi

FM_ARG_TO_BUILD="$(echo $1 | tr '[:upper:]' '[:lower:]')"
FM_ARG_TOOLCHAIN="$(echo $2 | tr '[:upper:]' '[:lower:]')"
FM_ARG_ARCHITECTURE="$(echo $3 | tr '[:upper:]' '[:lower:]')"
FM_ARG_BUILD_VARIANTS="$(echo $4 | tr '[:upper:]' '[:lower:]' | tr "," "\n")"


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

# Identify executables
identifyExecutables

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

