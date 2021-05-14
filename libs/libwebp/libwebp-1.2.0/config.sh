#!/bin/bash
# Configuration script for libwebp 1.2.0
# Library release date: 2021/01/30

export FM_WEBP_NAME="libwebp"
export FM_WEBP_VERSION="1.2.0"
export FM_WEBP_FULL_NAME="${FM_WEBP_NAME}-${FM_WEBP_VERSION}"
export FM_WEBP_TARBALL_NAME="${FM_WEBP_FULL_NAME}.tar.gz"
export FM_WEBP_TARBALL_DOWNLOAD_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${FM_WEBP_TARBALL_NAME}"
export FM_WEBP_INSTALL_CHECK="include/webp/types.h"
export FM_WEBP_HASH="2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c"
export FM_WEBP_HASH_TYPE="SHA-256"
