#!/bin/bash
# Configuration script for libwebp 1.1.0
# Library release date: 2019/12/18

export FM_WEBP_NAME="libwebp"
export FM_WEBP_VERSION="1.1.0"
export FM_WEBP_FULL_NAME="${FM_WEBP_NAME}-${FM_WEBP_VERSION}"
export FM_WEBP_TARBALL_NAME="${FM_WEBP_FULL_NAME}.tar.gz"
export FM_WEBP_TARBALL_DOWNLOAD_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${FM_WEBP_TARBALL_NAME}"
export FM_WEBP_INSTALL_CHECK="include/webp/types.h"
export FM_WEBP_HASH="98a052268cc4d5ece27f76572a7f50293f439c17a98e67c4ea0c7ed6f50ef043"
export FM_WEBP_HASH_TYPE="SHA-256"
