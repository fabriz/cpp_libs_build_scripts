#!/bin/bash
# Configuration script for wt 4.2.0

export FM_WT_NAME="wt"
export FM_WT_VERSION="4.2.0"
export FM_WT_FULL_NAME="${FM_WT_NAME}-${FM_WT_VERSION}"
export FM_WT_TARBALL_NAME="${FM_WT_FULL_NAME}.tar.gz"
export FM_WT_TARBALL_DOWNLOAD_URL="https://github.com/emweb/wt/archive/${FM_WT_VERSION}.tar.gz"
export FM_WT_INSTALL_CHECK="include/Wt/WGlobal.h"
export FM_WT_HASH="2854c19803e0b5709c2e77e59b1a2da70c89625b4c5127fd3b0ad184a95f8d7d"
export FM_WT_HASH_TYPE="SHA-256"
