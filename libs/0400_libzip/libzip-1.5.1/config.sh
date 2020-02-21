#!/bin/bash
# Configuration script for libzip 1.5.1

export FM_LIBZIP_NAME="libzip"
export FM_LIBZIP_VERSION="1.5.1"
export FM_LIBZIP_FULL_NAME="${FM_LIBZIP_NAME}-${FM_LIBZIP_VERSION}"
export FM_LIBZIP_TARBALL_NAME="${FM_LIBZIP_FULL_NAME}.tar.gz"
export FM_LIBZIP_TARBALL_DOWNLOAD_URL="https://libzip.org/download/${FM_LIBZIP_TARBALL_NAME}"
export FM_LIBZIP_INSTALL_CHECK="include/zip.h"
export FM_LIBZIP_HASH="edbb7c9a9feaf02195afbdef2f5484a5b84bebf9"
export FM_LIBZIP_HASH_TYPE="SHA-1"
