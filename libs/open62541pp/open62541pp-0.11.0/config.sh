#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for open62541pp 0.11.0
# Library release date: 2023/11/01

export FM_OPEN62541PP_NAME="open62541pp"
export FM_OPEN62541PP_VERSION="0.11.0"
export FM_OPEN62541PP_FULL_NAME="${FM_OPEN62541PP_NAME}-${FM_OPEN62541PP_VERSION}"
export FM_OPEN62541PP_TARBALL_NAME="${FM_OPEN62541PP_FULL_NAME}.tar.gz"
export FM_OPEN62541PP_TARBALL_DOWNLOAD_URL="https://github.com/open62541pp/open62541pp/archive/refs/tags/v${FM_OPEN62541PP_VERSION}.tar.gz"
export FM_OPEN62541PP_INSTALL_CHECK="include/open62541pp/open62541pp.h"
export FM_OPEN62541PP_HASH="af2488ef8ac253cf9fc785a93e14947ea6aa10e35c57d40cf14958f8d72244a6"
export FM_OPEN62541PP_HASH_TYPE="SHA-256"
