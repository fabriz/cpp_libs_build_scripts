#!/bin/bash
# Configuration script for jpeg 9d
# Library release date: 2020/01/12

export FM_JPEG_NAME="jpegsrc"
export FM_JPEG_VERSION="9d"
export FM_JPEG_FULL_NAME="${FM_JPEG_NAME}.v${FM_JPEG_VERSION}"
export FM_JPEG_TARBALL_NAME="${FM_JPEG_FULL_NAME}.tar.gz"
export FM_JPEG_TARBALL_DOWNLOAD_URL="http://www.ijg.org/files/${FM_JPEG_TARBALL_NAME}"
export FM_JPEG_UNTAR_DIR="jpeg-${FM_JPEG_VERSION}"
export FM_JPEG_INSTALL_CHECK="include/jpeglib.h"
export FM_JPEG_HASH="99cb50e48a4556bc571dadd27931955ff458aae32f68c4d9c39d624693f69c32"
export FM_JPEG_HASH_TYPE="SHA-256"
