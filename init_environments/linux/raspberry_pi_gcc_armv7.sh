#!/bin/bash

#export FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/vars.sh"

#export FM_TARGET_OS_TYPE=linux
#export FM_GLOBAL_TARGET="raspberry_pi"
#export FM_TARGET_COMPILER=gcc_cross
#export FM_TARGET_TOOLCHAIN=${FM_TARGET_OS_TYPE}_${FM_TARGET_COMPILER}

#export FM_TARGET_PLATFORM="raspberry_pi_gcc"


#export FM_GLOBAL_ARCHITECTURE=armv7
#export FM_GLOBAL_ADDRESS_MODEL=32
#export FM_GLOBAL_SYSROOT=${FM_GLOBAL_RASPBERRY_PI_CROSS_SYSROOT_PATH}
#export FM_GLOBAL_CROSS_COMPILER_HOST="arm-linux-gnueabihf"
#export FM_GLOBAL_CFLAGS=""
#export FM_GLOBAL_CXXFLAGS=""
#export FM_GLOBAL_LDFLAGS=""


##LOCAL_ARCHITECTURE_CFLAGS="-march=armv8-a -mtune=cortex-a53 -mfpu=crypto-neon-fp-armv8 -mfloat-abi=hard -D_REENTRANT"


#export FM_TARGET_COMPILER_VERSION="$(${FM_GLOBAL_CROSS_COMPILER_HOST}-gcc -dumpversion)"
#if [ ${#FM_TARGET_COMPILER_VERSION} -le 2 ]; then
#    export FM_TARGET_COMPILER_VERSION="$(${FM_GLOBAL_CROSS_COMPILER_HOST}-gcc -dumpfullversion)"
#fi

#export PATH=${FM_GLOBAL_RASPBERRY_PI_CROSS_TOOLCHAIN_PATH}:$PATH

#source "${FM_PATH_ENVIRONMENT_INIT_SCRIPT_DIRECTORY}/start_bash.sh"
