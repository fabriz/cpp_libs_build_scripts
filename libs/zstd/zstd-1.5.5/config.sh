#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zstd 1.5.5
# Library release date: 2023/04/05

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.5.5"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/releases/download/v${FM_ZSTD_VERSION}/${FM_ZSTD_TARBALL_NAME}"
export FM_ZSTD_UNTAR_FLAGS="--exclude=*/tests/cli-tests/bin/unzstd"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="9c4396cc829cfae319a6e2615202e82aad41372073482fce286fac78646d3ee4"
export FM_ZSTD_HASH_TYPE="SHA-256"
