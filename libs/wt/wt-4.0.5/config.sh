#!/bin/bash
# Configuration script for wt 4.0.5
# Library release date: 2018/12/14

export FM_WT_NAME="wt"
export FM_WT_VERSION="4.0.5"
export FM_WT_FULL_NAME="${FM_WT_NAME}-${FM_WT_VERSION}"
export FM_WT_TARBALL_NAME="${FM_WT_FULL_NAME}.tar.gz"
export FM_WT_TARBALL_DOWNLOAD_URL="https://github.com/emweb/wt/archive/${FM_WT_VERSION}.tar.gz"
export FM_WT_INSTALL_CHECK="include/Wt/WGlobal.h"
export FM_WT_HASH="ef93e31950a750758c183032b6db39dcfb2d8af9"
export FM_WT_HASH_TYPE="SHA-1"
