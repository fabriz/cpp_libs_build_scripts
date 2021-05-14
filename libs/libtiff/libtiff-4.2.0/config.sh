#!/bin/bash
# Configuration script for libtiff 4.2.0
# Library release date: 2020/12/19

export FM_LIBTIFF_NAME="tiff"
export FM_LIBTIFF_VERSION="4.2.0"
export FM_LIBTIFF_FULL_NAME="${FM_LIBTIFF_NAME}-${FM_LIBTIFF_VERSION}"
export FM_LIBTIFF_TARBALL_NAME="${FM_LIBTIFF_FULL_NAME}.tar.gz"
export FM_LIBTIFF_TARBALL_DOWNLOAD_URL="http://download.osgeo.org/libtiff/${FM_LIBTIFF_TARBALL_NAME}"
export FM_LIBTIFF_INSTALL_CHECK="include/tiff.h"
export FM_LIBTIFF_HASH="eb0484e568ead8fa23b513e9b0041df7e327f4ee2d22db5a533929dfc19633cb"
export FM_LIBTIFF_HASH_TYPE="SHA-256"
