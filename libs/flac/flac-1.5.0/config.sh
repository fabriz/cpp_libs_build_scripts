#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for flac 1.5.0
# Library release date: 2025/02/10

export FM_FLAC_NAME="flac"
export FM_FLAC_VERSION="1.5.0"
export FM_FLAC_FULL_NAME="${FM_FLAC_NAME}-${FM_FLAC_VERSION}"
export FM_FLAC_TARBALL_NAME="${FM_FLAC_FULL_NAME}.tar.xz"
export FM_FLAC_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/flac/${FM_FLAC_TARBALL_NAME}"
export FM_FLAC_INSTALL_CHECK="include/FLAC/all.h"
export FM_FLAC_HASH="f2c1c76592a82ffff8413ba3c4a1299b6c7ab06c734dee03fd88630485c2b920"
export FM_FLAC_HASH_TYPE="SHA-256"
