#!/bin/bash
# Configuration script for icu4c 63.1
# Library release date: 2018/10/15

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="63.1"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="http://download.icu-project.org/files/icu4c/${FM_ICU4C_VERSION}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="9e40f6055294284df958200e308bce50"
export FM_ICU4C_HASH_TYPE="MD5"
