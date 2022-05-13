#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for neon 0.32.2
# Library release date: 2022/01/12

export FM_NEON_NAME="neon"
export FM_NEON_VERSION="0.32.2"
export FM_NEON_FULL_NAME="${FM_NEON_NAME}-${FM_NEON_VERSION}"
export FM_NEON_TARBALL_NAME="${FM_NEON_FULL_NAME}.tar.gz"
export FM_NEON_TARBALL_DOWNLOAD_URL="https://notroj.github.io/neon/${FM_NEON_TARBALL_NAME}"
export FM_NEON_INSTALL_CHECK="include/neon/ne_defs.h"
export FM_NEON_HASH="986566468c6295fc5d0fb141a5981e31c9f82ee38e938374abed8471ef2fb286"
export FM_NEON_HASH_TYPE="SHA-256"
