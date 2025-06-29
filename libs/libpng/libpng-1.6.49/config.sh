#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libpng 1.6.49
# Library release date: 2025/06/12

export FM_LIBPNG_NAME="libpng"
export FM_LIBPNG_VERSION="1.6.49"
export FM_LIBPNG_FULL_NAME="${FM_LIBPNG_NAME}-${FM_LIBPNG_VERSION}"
export FM_LIBPNG_TARBALL_NAME="${FM_LIBPNG_FULL_NAME}.tar.xz"
export FM_LIBPNG_TARBALL_DOWNLOAD_URL="https://download.sourceforge.net/libpng/${FM_LIBPNG_TARBALL_NAME}"
export FM_LIBPNG_INSTALL_CHECK="include/png.h"
export FM_LIBPNG_HASH="43182aa48e39d64b1ab4ec6b71ab3e910b67eed3a0fff3777cf8cf40d6ef7024"
export FM_LIBPNG_HASH_TYPE="SHA-256"
