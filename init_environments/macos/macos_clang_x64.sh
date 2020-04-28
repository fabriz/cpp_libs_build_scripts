#!/bin/bash

FM_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_SCRIPT_PATH}/vars.sh"

export FM_GLOBAL_HOST=macos
export FM_GLOBAL_COMPILER=clang
export FM_GLOBAL_TOOLCHAIN=${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER}
export FM_GLOBAL_ARCHITECTURE=x64

cd "${FM_SCRIPT_PATH}/../.."

echo
echo To build all libraries:
echo ./build_libset.sh latest debug,release
echo
echo To build a single library:
echo ./build_lib.sh "LIBNAME/LIBVERSION" debug,release
echo

/bin/bash