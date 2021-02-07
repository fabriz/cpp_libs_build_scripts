#!/bin/bash
# Configuration script for zstd 1.4.8
# Library release date: 2020/12/19

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.4.8"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/tarball/v${FM_ZSTD_VERSION}"
export FM_ZSTD_UNTAR_DIR="facebook-zstd-*"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="e4be41cc2a4008c4140f5b2518e758e62a4efb1c7424ff9b50c436dbbf4152ad"
export FM_ZSTD_HASH_TYPE="SHA-256"
