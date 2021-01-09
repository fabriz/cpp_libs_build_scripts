#!/bin/bash
# Configuration script for xz 5.2.5
# Library release date: 2020/03/17

export FM_XZ_NAME="xz"
export FM_XZ_VERSION="5.2.5"
export FM_XZ_FULL_NAME="${FM_XZ_NAME}-${FM_XZ_VERSION}"
export FM_XZ_TARBALL_NAME="${FM_XZ_FULL_NAME}.tar.xz"
export FM_XZ_TARBALL_DOWNLOAD_URL="https://tukaani.org/xz/${FM_XZ_TARBALL_NAME}"
export FM_XZ_INSTALL_CHECK="include/lzma.h"
export FM_XZ_HASH="3e1e518ffc912f86608a8cb35e4bd41ad1aec210df2a47aaa1f95e7f5576ef56"
export FM_XZ_HASH_TYPE="SHA-256"
