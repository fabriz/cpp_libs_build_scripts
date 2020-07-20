#!/bin/bash
# Configuration script for libzippp 3.1-1.6.1
# Library release date: 2020/04/18

export FM_LIBZIPPP_NAME="libzippp"
export FM_LIBZIPPP_VERSION="3.1-1.6.1"
export FM_LIBZIPPP_FULL_NAME="${FM_LIBZIPPP_NAME}-${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_TARBALL_NAME="${FM_LIBZIPPP_FULL_NAME}.tar.gz"
export FM_LIBZIPPP_TARBALL_DOWNLOAD_URL="https://github.com/ctabin/libzippp/tarball/${FM_LIBZIPPP_NAME}-v${FM_LIBZIPPP_VERSION}"
export FM_LIBZIPPP_INSTALL_CHECK="include/libzippp.h"
export FM_LIBZIPPP_HASH="405d7d2367a51eec4dc0bd266edc8408b14780af79187a9687a851e651907015"
export FM_LIBZIPPP_HASH_TYPE="SHA-256"
