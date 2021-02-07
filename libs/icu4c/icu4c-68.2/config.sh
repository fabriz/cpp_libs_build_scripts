#!/bin/bash
# Configuration script for icu4c 68.2
# Library release date: 2020/12/17

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="68.2"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-${FM_ICU4C_VERSION//./-}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_UNTAR_DIR="icu"
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="c79193dee3907a2199b8296a93b52c5cb74332c26f3d167269487680d479d625"
export FM_ICU4C_HASH_TYPE="SHA-256"
