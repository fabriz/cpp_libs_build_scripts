#!/bin/bash

FM_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_SCRIPT_PATH}/vars.sh"

export FM_GLOBAL_HOST=android
export FM_GLOBAL_COMPILER=clang
export FM_GLOBAL_TOOLCHAIN=${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER}
export FM_GLOBAL_ARCHITECTURE=armv7

export PATH=${FM_GLOBAL_ANDROID_ARMV7_STANDALONE_NDK_INSTALL_PATH}/bin:$PATH

cd "${FM_SCRIPT_PATH}/../.."

echo
echo To build all libraries:
echo ./build_libset.sh latest debug,release
echo
echo To build a single library:
echo ./build_lib.sh "LIBNAME/LIBVERSION" debug,release
echo

/bin/bash
