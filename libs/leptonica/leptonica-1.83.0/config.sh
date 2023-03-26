#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for leptonica 1.83.0
# Library release date: 2022/12/20

export FM_LEPTONICA_NAME="leptonica"
export FM_LEPTONICA_VERSION="1.83.0"
export FM_LEPTONICA_FULL_NAME="${FM_LEPTONICA_NAME}-${FM_LEPTONICA_VERSION}"
export FM_LEPTONICA_TARBALL_NAME="${FM_LEPTONICA_FULL_NAME}.tar.gz"
export FM_LEPTONICA_TARBALL_DOWNLOAD_URL="https://github.com/DanBloomberg/leptonica/releases/download/${FM_LEPTONICA_VERSION}/${FM_LEPTONICA_TARBALL_NAME}"
export FM_LEPTONICA_INSTALL_CHECK="include/leptonica/allheaders.h"
export FM_LEPTONICA_HASH="206591dd58cf84ef380836dad133b58c9d1af92491f5a9825c346a162044bcfe"
export FM_LEPTONICA_HASH_TYPE="SHA-256"
