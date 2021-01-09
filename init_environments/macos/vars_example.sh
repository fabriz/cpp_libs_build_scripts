#!/bin/bash

# Number of parallel jobs for make
export FM_CONFIG_NUM_PROCESSES=$(sysctl -n hw.logicalcpu)

# Paths of local tools
export FM_CONFIG_CMAKE_COMMAND="$(which cmake)"
export FM_CONFIG_CURL_COMMAND="$(which curl)"
export FM_CONFIG_PERL_COMMAND="$(which perl)"
export FM_CONFIG_PYTHON_COMMAND="$(which python)"
export FM_CONFIG_TAR_COMMAND="$(which tar)"

# LAN cache configuration
#export FM_CONFIG_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"'
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${FM_SOURCE_TARBALL_NAME} ${FM_TARGET_TARBALL_PATH}"'

# Working directories
export FM_CONFIG_TARBALL_CACHE=/Users/fabrizio/libs/cache
export FM_CONFIG_BUILD_ROOT=/Users/fabrizio/libs/build
export FM_CONFIG_DEPLOY_ROOT=/Users/fabrizio/libs/libs

# Optional commands to execute when the build completes
#export FM_CONFIG_ON_BUILD_SUCCESS=
#export FM_CONFIG_ON_BUILD_ERROR=

# To disable certificate validation:
#export FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION=true
