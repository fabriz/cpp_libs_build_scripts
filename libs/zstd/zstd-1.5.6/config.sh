#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zstd 1.5.6
# Library release date: 2024/03/30

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.5.6"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/releases/download/v${FM_ZSTD_VERSION}/${FM_ZSTD_TARBALL_NAME}"
export FM_ZSTD_UNTAR_FLAGS="--exclude=*/tests/cli-tests/bin/unzstd"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="8c29e06cf42aacc1eafc4077ae2ec6c6fcb96a626157e0593d5e82a34fd403c1"
export FM_ZSTD_HASH_TYPE="SHA-256"
