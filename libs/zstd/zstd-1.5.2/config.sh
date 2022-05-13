#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for zstd 1.5.2
# Library release date: 2022/01/20

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.5.2"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/releases/download/v${FM_ZSTD_VERSION}/${FM_ZSTD_TARBALL_NAME}"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="7c42d56fac126929a6a85dbc73ff1db2411d04f104fae9bdea51305663a83fd0"
export FM_ZSTD_HASH_TYPE="SHA-256"
