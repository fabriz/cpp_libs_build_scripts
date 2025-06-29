#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libogg 1.3.6
# Library release date: 2025/06/16

export FM_LIBOGG_NAME="libogg"
export FM_LIBOGG_VERSION="1.3.6"
export FM_LIBOGG_FULL_NAME="${FM_LIBOGG_NAME}-${FM_LIBOGG_VERSION}"
export FM_LIBOGG_TARBALL_NAME="${FM_LIBOGG_FULL_NAME}.tar.xz"
export FM_LIBOGG_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/ogg/${FM_LIBOGG_TARBALL_NAME}"
export FM_LIBOGG_INSTALL_CHECK="include/ogg/ogg.h"
export FM_LIBOGG_HASH="5c8253428e181840cd20d41f3ca16557a9cc04bad4a3d04cce84808677fa1061"
export FM_LIBOGG_HASH_TYPE="SHA-256"
