#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libtiff 4.6.0
# Library release date: 2023/09/08

export FM_LIBTIFF_NAME="tiff"
export FM_LIBTIFF_VERSION="4.6.0"
export FM_LIBTIFF_FULL_NAME="${FM_LIBTIFF_NAME}-${FM_LIBTIFF_VERSION}"
export FM_LIBTIFF_TARBALL_NAME="${FM_LIBTIFF_FULL_NAME}.tar.xz"
export FM_LIBTIFF_TARBALL_DOWNLOAD_URL="http://download.osgeo.org/libtiff/${FM_LIBTIFF_TARBALL_NAME}"
export FM_LIBTIFF_INSTALL_CHECK="include/tiff.h"
export FM_LIBTIFF_HASH="e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2"
export FM_LIBTIFF_HASH_TYPE="SHA-256"
