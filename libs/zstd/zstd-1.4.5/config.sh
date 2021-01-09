#!/bin/bash
# Configuration script for zstd 1.4.5
# Library release date: 2020/05/22

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.4.5"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/tarball/v${FM_ZSTD_VERSION}"
export FM_ZSTD_UNTAR_DIR="facebook-zstd-*"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="0203708402a3386bafea86702e85b503d21ea34c377638eeb5489779064a6b93"
export FM_ZSTD_HASH_TYPE="SHA-256"
