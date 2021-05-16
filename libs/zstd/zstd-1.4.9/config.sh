#!/bin/bash
# Configuration script for zstd 1.4.9
# Library release date: 2021/03/03

export FM_ZSTD_NAME="zstd"
export FM_ZSTD_VERSION="1.4.9"
export FM_ZSTD_FULL_NAME="${FM_ZSTD_NAME}-${FM_ZSTD_VERSION}"
export FM_ZSTD_TARBALL_NAME="${FM_ZSTD_FULL_NAME}.tar.gz"
export FM_ZSTD_TARBALL_DOWNLOAD_URL="https://github.com/facebook/zstd/tarball/v${FM_ZSTD_VERSION}"
export FM_ZSTD_UNTAR_DIR="facebook-zstd-*"
export FM_ZSTD_INSTALL_CHECK="include/zstd.h"
export FM_ZSTD_HASH="427e7f8a0df4319067cec4306141ca556a2bc40973ce34b856e816097bd026f9"
export FM_ZSTD_HASH_TYPE="SHA-256"
