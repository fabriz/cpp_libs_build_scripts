#!/bin/bash
# Configuration script for libzippp 4.0-1.7.3
# Library release date: 2020/09/19

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="4.0-1.7.3"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_UNTAR_DIR="ctabin-libzippp-*"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="e316656148e05482b94a33adc0ba4d6d84f79ad6fc21d31ee39c9a603ce3d9a7"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"
