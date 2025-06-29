#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libarchive 3.8.1
# Library release date: 2025/06/01

export FM_LIBARCHIVE_NAME="libarchive"
export FM_LIBARCHIVE_VERSION="3.8.1"
export FM_LIBARCHIVE_FULL_NAME="${FM_LIBARCHIVE_NAME}-${FM_LIBARCHIVE_VERSION}"
export FM_LIBARCHIVE_TARBALL_NAME="${FM_LIBARCHIVE_FULL_NAME}.tar.xz"
export FM_LIBARCHIVE_TARBALL_DOWNLOAD_URL="https://github.com/libarchive/libarchive/releases/download/v${FM_LIBARCHIVE_VERSION}/${FM_LIBARCHIVE_TARBALL_NAME}"
export FM_LIBARCHIVE_INSTALL_CHECK="include/archive.h"
export FM_LIBARCHIVE_HASH="19f917d42d530f98815ac824d90c7eaf648e9d9a50e4f309c812457ffa5496b5"
export FM_LIBARCHIVE_HASH_TYPE="SHA-256"
