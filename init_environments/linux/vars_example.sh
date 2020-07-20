#!/bin/bash

# Number of parallel jobs for make
export FM_GLOBAL_NUM_PROCESSES=$(nproc)

# Android NDK path and API level
export FM_GLOBAL_ANDROID_API_LEVEL=29
export FM_GLOBAL_ANDROID_NDK_INSTALL_PATH=/home/fabrizio/Android/ndk/android-ndk-r21d

# LAN cache configuration
#export FM_GLOBAL_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
#export FM_GLOBAL_LAN_TARBALL_CACHE_GET_CMD='curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"'
#export FM_GLOBAL_LAN_TARBALL_CACHE_GET_CMD='smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${FM_SOURCE_TARBALL_NAME} ${FM_TARGET_TARBALL_PATH}"'

export FM_GLOBAL_TARBALL_CACHE=/home/fabrizio/libs/libs_source
export FM_GLOBAL_BUILD_ROOT=/home/fabrizio/libs/build
export FM_GLOBAL_DEPLOY_ROOT=/home/fabrizio/libs/libs

# Optional commands to execute when the build completes
#export FM_GLOBAL_ON_BUILD_SUCCESS=
#export FM_GLOBAL_ON_BUILD_ERROR=

# To disable certificate validation:
#export FM_GLOBAL_OPTION_DISABLE_SSL_CERTIFICATE_VALIDATION=true
