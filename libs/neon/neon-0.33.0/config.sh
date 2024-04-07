#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for neon 0.33.0
# Library release date: 2024/01/29

export FM_NEON_NAME="neon"
export FM_NEON_VERSION="0.33.0"
export FM_NEON_FULL_NAME="${FM_NEON_NAME}-${FM_NEON_VERSION}"
export FM_NEON_TARBALL_NAME="${FM_NEON_FULL_NAME}.tar.gz"
export FM_NEON_TARBALL_DOWNLOAD_URL="https://notroj.github.io/neon/${FM_NEON_TARBALL_NAME}"
export FM_NEON_INSTALL_CHECK="include/neon/ne_defs.h"
export FM_NEON_HASH="659a5cc9cea05e6e7864094f1e13a77abbbdbab452f04d751a8c16a9447cf4b8"
export FM_NEON_HASH_TYPE="SHA-256"
