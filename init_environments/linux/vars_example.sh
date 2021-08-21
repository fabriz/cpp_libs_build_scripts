#!/bin/bash

# Number of parallel jobs for make
export FM_CONFIG_NUM_PROCESSES=$(nproc)

# Paths of local tools
export FM_CONFIG_CMAKE_COMMAND="$(which cmake)"
export FM_CONFIG_CURL_COMMAND="$(which curl)"
export FM_CONFIG_PERL_COMMAND="$(which perl)"
export FM_CONFIG_PYTHON_COMMAND="$(which python)"
export FM_CONFIG_TAR_COMMAND="$(which tar)"

# Android NDK path and API level
#export FM_CONFIG_ANDROID_API_LEVEL=21
#export FM_CONFIG_ANDROID_NDK_INSTALL_PATH=/home/fabrizio/Android/ndk/android-ndk-r21d

# Yocto environment initialization script
#export FM_CONFIG_YOCTO_ARMV7_ENVIRONMENT_INIT_SCRIPT=/path/to/environment-setup-cortexa7hf-neon-poky-linux-gnueabi
#export FM_CONFIG_YOCTO_ARMV8_ENVIRONMENT_INIT_SCRIPT=/path/to/environment-setup-aarch64-poky-linux

# LAN cache configuration
#export FM_CONFIG_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"'
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${FM_SOURCE_TARBALL_NAME} ${FM_TARGET_TARBALL_PATH}"'

# Working directories
export FM_CONFIG_TARBALL_CACHE=/home/fabrizio/libs/cache
export FM_CONFIG_BUILD_ROOT=/home/fabrizio/libs/build
export FM_CONFIG_DEPLOY_ROOT=/home/fabrizio/libs/libs

# Optional commands to execute when the build completes
#export FM_CONFIG_ON_BUILD_SUCCESS=
#export FM_CONFIG_ON_BUILD_ERROR=

# To disable certificate validation:
#export FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION=true
