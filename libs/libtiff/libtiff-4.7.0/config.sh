#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libtiff 4.7.0
# Library release date: 2024/09/18

export FM_LIBTIFF_NAME="tiff"
export FM_LIBTIFF_VERSION="4.7.0"
export FM_LIBTIFF_FULL_NAME="${FM_LIBTIFF_NAME}-${FM_LIBTIFF_VERSION}"
export FM_LIBTIFF_TARBALL_NAME="${FM_LIBTIFF_FULL_NAME}.tar.xz"
export FM_LIBTIFF_TARBALL_DOWNLOAD_URL="http://download.osgeo.org/libtiff/${FM_LIBTIFF_TARBALL_NAME}"
export FM_LIBTIFF_INSTALL_CHECK="include/tiff.h"
export FM_LIBTIFF_HASH="273a0a73b1f0bed640afee4a5df0337357ced5b53d3d5d1c405b936501f71017"
export FM_LIBTIFF_HASH_TYPE="SHA-256"
