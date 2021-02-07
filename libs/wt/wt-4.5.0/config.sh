#!/bin/bash
# Configuration script for wt 4.5.0
# Library release date: 2020/12/15

export FM_WT_NAME="wt"
export FM_WT_VERSION="4.5.0"
export FM_WT_FULL_NAME="${FM_WT_NAME}-${FM_WT_VERSION}"
export FM_WT_TARBALL_NAME="${FM_WT_FULL_NAME}.tar.gz"
export FM_WT_TARBALL_DOWNLOAD_URL="https://github.com/emweb/wt/archive/${FM_WT_VERSION}.tar.gz"
export FM_WT_INSTALL_CHECK="include/Wt/WGlobal.h"
export FM_WT_HASH="119b1eae83285a153b9c901d3f4f25775c7a460d30b1e48242d7d2d649d61deb"
export FM_WT_HASH_TYPE="SHA-256"
