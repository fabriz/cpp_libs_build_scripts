#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for xz 5.4.5
# Library release date: 2023/11/01

export FM_XZ_NAME="xz"
export FM_XZ_VERSION="5.4.5"
export FM_XZ_FULL_NAME="${FM_XZ_NAME}-${FM_XZ_VERSION}"
export FM_XZ_TARBALL_NAME="${FM_XZ_FULL_NAME}.tar.xz"
export FM_XZ_TARBALL_DOWNLOAD_URL="https://tukaani.org/xz/${FM_XZ_TARBALL_NAME}"
export FM_XZ_INSTALL_CHECK="include/lzma.h"
export FM_XZ_HASH="da9dec6c12cf2ecf269c31ab65b5de18e8e52b96f35d5bcd08c12b43e6878803"
export FM_XZ_HASH_TYPE="SHA-256"
