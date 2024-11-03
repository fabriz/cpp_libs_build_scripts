#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for xz 5.6.3
# Library release date: 2024/10/01

export FM_XZ_NAME="xz"
export FM_XZ_VERSION="5.6.3"
export FM_XZ_FULL_NAME="${FM_XZ_NAME}-${FM_XZ_VERSION}"
export FM_XZ_TARBALL_NAME="${FM_XZ_FULL_NAME}.tar.xz"
export FM_XZ_TARBALL_DOWNLOAD_URL="https://tukaani.org/xz/${FM_XZ_TARBALL_NAME}"
export FM_XZ_INSTALL_CHECK="include/lzma.h"
export FM_XZ_HASH="db0590629b6f0fa36e74aea5f9731dc6f8df068ce7b7bafa45301832a5eebc3a"
export FM_XZ_HASH_TYPE="SHA-256"
