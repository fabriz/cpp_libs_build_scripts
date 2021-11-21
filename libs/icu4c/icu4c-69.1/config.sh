#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for icu4c 69.1
# Library release date: 2021/04/07

export FM_ICU4C_NAME="icu4c"
export FM_ICU4C_VERSION="69.1"
export FM_ICU4C_FULL_NAME="${FM_ICU4C_NAME}-${FM_ICU4C_VERSION//./_}"
export FM_ICU4C_TARBALL_NAME="${FM_ICU4C_FULL_NAME}-src.tgz"
export FM_ICU4C_TARBALL_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-${FM_ICU4C_VERSION//./-}/${FM_ICU4C_TARBALL_NAME}"
export FM_ICU4C_UNTAR_DIR="icu"
export FM_ICU4C_INSTALL_CHECK="include/unicode/icudataver.h"
export FM_ICU4C_HASH="4cba7b7acd1d3c42c44bb0c14be6637098c7faf2b330ce876bc5f3b915d09745"
export FM_ICU4C_HASH_TYPE="SHA-256"

# MD5: 9403db682507369d0f60a25ea67014c4
