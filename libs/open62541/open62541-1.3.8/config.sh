#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for open62541 1.3.8
# Library release date: 2023/10/09

export FM_OPEN62541_NAME="open62541"
export FM_OPEN62541_VERSION="1.3.8"
export FM_OPEN62541_FULL_NAME="${FM_OPEN62541_NAME}-${FM_OPEN62541_VERSION}"
export FM_OPEN62541_TARBALL_NAME="${FM_OPEN62541_FULL_NAME}.tar.gz"
export FM_OPEN62541_TARBALL_DOWNLOAD_URL="https://github.com/open62541/open62541/archive/refs/tags/v${FM_OPEN62541_VERSION}.tar.gz"
export FM_OPEN62541_INSTALL_CHECK="include/open62541/config.h"
export FM_OPEN62541_HASH="b6943b564787c4953b77ca8d7f987c4b896b3f3e91f45d9f13e9056b6148bc1d"
export FM_OPEN62541_HASH_TYPE="SHA-256"
