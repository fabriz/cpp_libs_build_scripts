#!/bin/bash

FM_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_SCRIPT_PATH}/vars.sh"

export FM_GLOBAL_HOST=linux
export FM_GLOBAL_COMPILER=gcc
export FM_GLOBAL_ARCHITECTURE=x64

cd "${FM_SCRIPT_PATH}/../.."

echo
echo To build all libraries:
echo ./build_all.sh ${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER} ${FM_GLOBAL_ARCHITECTURE} debug,release,profile
echo
echo To build a single library:
echo cd libs
echo ./nnnn_build_libname.sh ${FM_GLOBAL_HOST}_${FM_GLOBAL_COMPILER} ${FM_GLOBAL_ARCHITECTURE} debug,release,profile
echo

/bin/bash
