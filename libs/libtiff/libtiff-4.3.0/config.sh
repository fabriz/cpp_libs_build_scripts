#!/bin/bash
# Configuration script for libtiff 4.3.0
# Library release date: 2021/04/20

export FM_LIBTIFF_NAME="tiff"
export FM_LIBTIFF_VERSION="4.3.0"
export FM_LIBTIFF_FULL_NAME="${FM_LIBTIFF_NAME}-${FM_LIBTIFF_VERSION}"
export FM_LIBTIFF_TARBALL_NAME="${FM_LIBTIFF_FULL_NAME}.tar.gz"
export FM_LIBTIFF_TARBALL_DOWNLOAD_URL="http://download.osgeo.org/libtiff/${FM_LIBTIFF_TARBALL_NAME}"
export FM_LIBTIFF_INSTALL_CHECK="include/tiff.h"
export FM_LIBTIFF_HASH="0e46e5acb087ce7d1ac53cf4f56a09b221537fc86dfc5daaad1c2e89e1b37ac8"
export FM_LIBTIFF_HASH_TYPE="SHA-256"
