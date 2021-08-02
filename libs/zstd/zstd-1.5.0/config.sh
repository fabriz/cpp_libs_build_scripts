#!/bin/bash
# Configuration script for zstd 1.5.0
# Library release date: 2021/05/14

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.5.0"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/tarball/v${FM_ZSTD_VERSION}"
export FM_ZSTD_UNTAR_DIR="facebook-zstd-*"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="db4ff12b835456c1d29cde095114181d4929bffc80a9e682b1ece8f4c3794f19"
export FM_ZSTD_HASH_TYPE="SHA-256"
