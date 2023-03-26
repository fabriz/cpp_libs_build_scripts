#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for flac 1.4.2
# Library release date: 2022/10/21

export FM_FLAC_NAME="flac"
export FM_FLAC_VERSION="1.4.2"
export FM_FLAC_FULL_NAME="${FM_FLAC_NAME}-${FM_FLAC_VERSION}"
export FM_FLAC_TARBALL_NAME="${FM_FLAC_FULL_NAME}.tar.xz"
export FM_FLAC_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/flac/${FM_FLAC_TARBALL_NAME}"
export FM_FLAC_INSTALL_CHECK="include/FLAC/all.h"
export FM_FLAC_HASH="e322d58a1f48d23d9dd38f432672865f6f79e73a6f9cc5a5f57fcaa83eb5a8e4"
export FM_FLAC_HASH_TYPE="SHA-256"
