#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Number of parallel jobs for make
export FM_CONFIG_NUM_PROCESSES=$(sysctl -n hw.logicalcpu)

# C++ standard version (14|17|20)
export FM_CONFIG_CXX_STANDARD=20

# Paths of local tools
export FM_CONFIG_CMAKE_COMMAND="$(which cmake)"
export FM_CONFIG_CURL_COMMAND="$(which curl)"
export FM_CONFIG_PERL_COMMAND="$(which perl)"
export FM_CONFIG_PYTHON_COMMAND="$(which python)"
export FM_CONFIG_TAR_COMMAND="$(which tar)"
export FM_CONFIG_UNZIP_COMMAND="$(which unzip)"
export FM_CONFIG_PATCH_COMMAND="$(which patch)"
export FM_CONFIG_LIPO_COMMAND="$(which lipo)"

# LAN cache configuration
#export FM_CONFIG_LAN_TARBALL_CACHE_USE=(NO|YES|ONLY)
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='curl -o "${DESTINATION_PATH}" "https://SERVER_AND_PATH/${TARBALL_NAME}"'
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='curl -u : -o "${DESTINATION_PATH}" "smb://SERVER/libs_cache/${TARBALL_NAME}"'
#export FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD='smbclient '"'"'\\SERVER\libs_cache'"'"' --no-pass -c "get \\${TARBALL_NAME} ${DESTINATION_PATH}"'

# Working directories
export FM_CONFIG_TARBALL_CACHE=/Users/fabrizio/libs/cache
export FM_CONFIG_BUILD_ROOT=/Users/fabrizio/libs/build
export FM_CONFIG_DEPLOY_ROOT=/Users/fabrizio/libs/libs

# Optional commands to execute when the build completes
#export FM_CONFIG_ON_BUILD_SUCCESS=
#export FM_CONFIG_ON_BUILD_ERROR=

# Uncomment to increase the log verbosity
#export FM_CONFIG_VERBOSE_LOGS=true

# Uncomment to deploy the provided cmake find modules
export FM_CONFIG_DEPLOY_CMAKE_FIND_MODULES=true

# Uncomment to disable certificate validation
#export FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION=true

# Library specific configuration
#export FM_OPC_UA_NODESETS=/Users/fabrizio/github/OPCFoundation/UA-Nodeset
