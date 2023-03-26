#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for neon 0.32.5
# Library release date: 2023/01/21

export FM_NEON_NAME="neon"
export FM_NEON_VERSION="0.32.5"
export FM_NEON_FULL_NAME="${FM_NEON_NAME}-${FM_NEON_VERSION}"
export FM_NEON_TARBALL_NAME="${FM_NEON_FULL_NAME}.tar.gz"
export FM_NEON_TARBALL_DOWNLOAD_URL="https://notroj.github.io/neon/${FM_NEON_TARBALL_NAME}"
export FM_NEON_INSTALL_CHECK="include/neon/ne_defs.h"
export FM_NEON_HASH="4872e12f802572dedd4b02f870065814b2d5141f7dbdaf708eedab826b51a58a"
export FM_NEON_HASH_TYPE="SHA-256"
