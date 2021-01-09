#!/bin/bash
# Configuration script for tinyxml2 8.0.0
# Library release date: 2020/03/02

export FM_TINYXML2_NAME="tinyxml2"
export FM_TINYXML2_VERSION="8.0.0"
export FM_TINYXML2_FULL_NAME="${FM_TINYXML2_NAME}-${FM_TINYXML2_VERSION}"
export FM_TINYXML2_TARBALL_NAME="${FM_TINYXML2_FULL_NAME}.tar.gz"
export FM_TINYXML2_TARBALL_DOWNLOAD_URL="https://github.com/leethomason/tinyxml2/tarball/${FM_TINYXML2_VERSION}"
export FM_TINYXML2_UNTAR_DIR="leethomason-tinyxml2-*"
export FM_TINYXML2_INSTALL_CHECK="include/tinyxml2.h"
export FM_TINYXML2_HASH="e1a5a3c88882597fa1976b3fbbe4fe438540f03b44a9e205bfc5834cdb6725fa"
export FM_TINYXML2_HASH_TYPE="SHA-256"
