#!/bin/bash

FM_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_SCRIPT_PATH}/vars.sh"

export FM_GLOBAL_HOST=linux
export FM_GLOBAL_TARGET="raspberry_pi"
export FM_GLOBAL_COMPILER=gcc_cross
export FM_GLOBAL_TOOLCHAIN=${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER}
export FM_GLOBAL_ARCHITECTURE=armv7
export FM_GLOBAL_ADDRESS_MODEL=32
export FM_GLOBAL_SYSROOT=${FM_GLOBAL_RASPBERRY_PI_CROSS_SYSROOT_PATH}
export FM_GLOBAL_CROSS_COMPILER_HOST="arm-linux-gnueabihf"
export FM_GLOBAL_CFLAGS=""
export FM_GLOBAL_CXXFLAGS=""
export FM_GLOBAL_LDFLAGS=""

export PATH=${FM_GLOBAL_RASPBERRY_PI_CROSS_TOOLCHAIN_PATH}:$PATH

cd "${FM_SCRIPT_PATH}/../.."

echo
echo To build all libraries:
echo ./build_libset.sh latest debug,release,profile
echo
echo To build a single library:
echo ./build_lib.sh "LIBNAME/LIBVERSION" debug,release,profile
echo

/bin/bash
