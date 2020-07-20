#!/bin/bash
# Configuration script for wt 4.3.1
# Library release date: 2020/04/20

export FM_WT_NAME="wt"
export FM_WT_VERSION="4.3.1"
export FM_WT_FULL_NAME="${FM_WT_NAME}-${FM_WT_VERSION}"
export FM_WT_TARBALL_NAME="${FM_WT_FULL_NAME}.tar.gz"
export FM_WT_TARBALL_DOWNLOAD_URL="https://github.com/emweb/wt/archive/${FM_WT_VERSION}.tar.gz"
export FM_WT_INSTALL_CHECK="include/Wt/WGlobal.h"
export FM_WT_HASH="6c0130f36c829ed67119679770c2f62d7768a62eaa281bb10070c4cf1b145139"
export FM_WT_HASH_TYPE="SHA-256"
