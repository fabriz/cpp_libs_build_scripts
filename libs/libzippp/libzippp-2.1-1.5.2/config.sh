#!/bin/bash
# Configuration script for libzippp 2.1-1.5.2
# Library release date: 2019/05/05

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="2.1-1.5.2"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="ecb252b78ee4827cb425fea360aed9dc6cb87b91a0739b64b959997f9b6ce459"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"
