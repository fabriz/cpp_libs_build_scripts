#!/bin/bash
# Configuration script for libzippp 4.1-1.8.0
# Library release date: 2021/06/20

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="4.1-1.8.0"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_UNTAR_DIR="ctabin-libzippp-*"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="29b9b1ba693a507f18ec20bbe126b1018477f750dc7f8fbb9907ae0f75d0f683"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"