#!/bin/bash

export FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/vars.sh"

export FM_TARGET_OS_TYPE=macos
export FM_TARGET_COMPILER=clang
export FM_TARGET_TOOLCHAIN=macos_clang
export FM_TARGET_PLATFORM=macos_clang
export FM_TARGET_HAS_PKGCONFIG=false
export FM_TARGET_ALL_ARCHITECTURES=x86_64
export FM_TARGET_ALL_BUILD_VARIANTS=debug,release,profile

export FM_TARGET_COMPILER_VERSION="$(clang -dumpversion)"

source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
