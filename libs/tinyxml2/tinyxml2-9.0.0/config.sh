#!/bin/bash
# Configuration script for tinyxml2 9.0.0
# Library release date: 2021/06/07

export FM_TINYXML2_NAME="tinyxml2"
export FM_TINYXML2_VERSION="9.0.0"
export FM_TINYXML2_FULL_NAME="${FM_TINYXML2_NAME}-${FM_TINYXML2_VERSION}"
export FM_TINYXML2_TARBALL_NAME="${FM_TINYXML2_FULL_NAME}.tar.gz"
export FM_TINYXML2_TARBALL_DOWNLOAD_URL="https://github.com/leethomason/tinyxml2/tarball/${FM_TINYXML2_VERSION}"
export FM_TINYXML2_UNTAR_DIR="leethomason-tinyxml2-*"
export FM_TINYXML2_INSTALL_CHECK="include/tinyxml2.h"
export FM_TINYXML2_HASH="e2c8fd385894e7706ca4841dbc8c0b0d1b7ba60d56314078bc2f55ff8006ade1"
export FM_TINYXML2_HASH_TYPE="SHA-256"
