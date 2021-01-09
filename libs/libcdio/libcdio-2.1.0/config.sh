#!/bin/bash
# Configuration script for libcdio 2.1.0
# Library release date: 2019/04/17

export FM_LIBCDIO_NAME="libcdio"
export FM_LIBCDIO_VERSION="2.1.0"
export FM_LIBCDIO_FULL_NAME="${FM_LIBCDIO_NAME}-${FM_LIBCDIO_VERSION}"
export FM_LIBCDIO_TARBALL_NAME="${FM_LIBCDIO_FULL_NAME}.tar.bz2"
export FM_LIBCDIO_TARBALL_DOWNLOAD_URL="https://ftp.gnu.org/gnu/libcdio/${FM_LIBCDIO_TARBALL_NAME}"
export FM_LIBCDIO_INSTALL_CHECK="include/cdio/cdio.h"
export FM_LIBCDIO_HASH="8550e9589dbd594bfac93b81ecf129b1dc9d0d51e90f9696f1b2f9b2af32712b"
export FM_LIBCDIO_HASH_TYPE="SHA-256"
