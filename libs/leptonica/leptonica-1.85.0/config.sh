#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for leptonica 1.85.0
# Library release date: 2024/10/16

export FM_LEPTONICA_NAME="leptonica"
export FM_LEPTONICA_VERSION="1.85.0"
export FM_LEPTONICA_FULL_NAME="${FM_LEPTONICA_NAME}-${FM_LEPTONICA_VERSION}"
export FM_LEPTONICA_TARBALL_NAME="${FM_LEPTONICA_FULL_NAME}.tar.gz"
export FM_LEPTONICA_TARBALL_DOWNLOAD_URL="https://github.com/DanBloomberg/leptonica/releases/download/${FM_LEPTONICA_VERSION}/${FM_LEPTONICA_TARBALL_NAME}"
export FM_LEPTONICA_INSTALL_CHECK="include/leptonica/allheaders.h"
export FM_LEPTONICA_HASH="3745ae3bf271a6801a2292eead83ac926e3a9bc1bf622e9cd4dd0f3786e17205"
export FM_LEPTONICA_HASH_TYPE="SHA-256"
