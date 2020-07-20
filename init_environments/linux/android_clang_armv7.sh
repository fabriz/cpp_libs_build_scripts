#!/bin/bash

FM_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_SCRIPT_PATH}/vars.sh"

export FM_GLOBAL_HOST=android
export FM_GLOBAL_COMPILER=clang
export FM_GLOBAL_TOOLCHAIN=${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER}
export FM_GLOBAL_ARCHITECTURE=armv7
export FM_GLOBAL_CROSS_COMPILER_HOST="arm-linux-androideabi"
export FM_GLOBAL_CROSS_COMPILER_ROOT_NAME="armv7a-linux-androideabi"${FM_GLOBAL_ANDROID_API_LEVEL}

export PATH=${FM_GLOBAL_ANDROID_NDK_INSTALL_PATH}/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH

cd "${FM_SCRIPT_PATH}/../.."

echo
echo To build all libraries:
echo ./build_libset.sh latest debug,release
echo
echo To build a single library:
echo ./build_lib.sh "LIBNAME/LIBVERSION" debug,release
echo

/bin/bash
