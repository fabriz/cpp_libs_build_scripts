#!/bin/bash
# Configuration script for icu4c 65.1
# Library release date: 2019/10/03

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="65.1"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-${FM_ICU4C_VERSION//./-}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_UNTAR_DIR="icu"
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="53e37466b3d6d6d01ead029e3567d873a43a5d1c668ed2278e253b683136d948"
export FM_ICU4C_HASH_TYPE="SHA-256"
