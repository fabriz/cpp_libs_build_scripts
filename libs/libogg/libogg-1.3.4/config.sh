#!/bin/bash
# Configuration script for libogg 1.3.4
# Library release date: 2019/08/31

export FM_LIBOGG_NAME="libogg"
export FM_LIBOGG_VERSION="1.3.4"
export FM_LIBOGG_FULL_NAME="${FM_LIBOGG_NAME}-${FM_LIBOGG_VERSION}"
export FM_LIBOGG_TARBALL_NAME="${FM_LIBOGG_FULL_NAME}.tar.xz"
export FM_LIBOGG_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/ogg/${FM_LIBOGG_TARBALL_NAME}"
export FM_LIBOGG_INSTALL_CHECK="include/ogg/ogg.h"
export FM_LIBOGG_HASH="c163bc12bc300c401b6aa35907ac682671ea376f13ae0969a220f7ddf71893fe"
export FM_LIBOGG_HASH_TYPE="SHA-256"
