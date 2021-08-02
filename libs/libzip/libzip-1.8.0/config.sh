#!/bin/bash
# Configuration script for libzip 1.8.0
# Library release date: 2021/06/18

export FM_LIBZIP_NAME="libzip"
export FM_LIBZIP_VERSION="1.8.0"
export FM_LIBZIP_FULL_NAME="${FM_LIBZIP_NAME}-${FM_LIBZIP_VERSION}"
export FM_LIBZIP_TARBALL_NAME="${FM_LIBZIP_FULL_NAME}.tar.gz"
export FM_LIBZIP_TARBALL_DOWNLOAD_URL="https://libzip.org/download/${FM_LIBZIP_TARBALL_NAME}"
export FM_LIBZIP_INSTALL_CHECK="include/zip.h"
export FM_LIBZIP_HASH="30ee55868c0a698d3c600492f2bea4eb62c53849bcf696d21af5eb65f3f3839e"
export FM_LIBZIP_HASH_TYPE="SHA-256"
