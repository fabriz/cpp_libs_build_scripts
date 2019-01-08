#!/bin/bash

export FM_GLOBAL_ANDROID_API_LEVEL=21
export FM_GLOBAL_ANDROID_ARMV7_STANDALONE_NDK_INSTALL_PATH=/home/fabrizio/Android/standalone/arm-linux-androideabi_21
export FM_GLOBAL_ANDROID_ARMV8_STANDALONE_NDK_INSTALL_PATH=/home/fabrizio/Android/standalone/aarch64-linux-android_21

export FM_GLOBAL_TARBALL_CACHE=/home/fabrizio/libs/libs_source
export FM_GLOBAL_BUILD_ROOT=/home/fabrizio/libs/build
export FM_GLOBAL_DEPLOY_ROOT=/home/fabrizio/libs/libs

# To disable certificate validation:
#export FM_GLOBAL_OPTION_DISABLE_SSL_CERTIFICATE_VALIDATION=true
