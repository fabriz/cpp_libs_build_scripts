#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libdeflate 1.21
# Library release date: 2024/08/04

export FM_LIBDEFLATE_NAME="libdeflate"
export FM_LIBDEFLATE_VERSION="1.21"
export FM_LIBDEFLATE_FULL_NAME="${FM_LIBDEFLATE_NAME}-${FM_LIBDEFLATE_VERSION}"
export FM_LIBDEFLATE_TARBALL_NAME="${FM_LIBDEFLATE_FULL_NAME}.tar.gz"
export FM_LIBDEFLATE_TARBALL_DOWNLOAD_URL="https://github.com/ebiggers/libdeflate/archive/refs/tags/v${FM_LIBDEFLATE_VERSION}.tar.gz"
export FM_LIBDEFLATE_INSTALL_CHECK="include/libdeflate.h"
export FM_LIBDEFLATE_HASH="50827d312c0413fbd41b0628590cd54d9ad7ebf88360cba7c0e70027942dbd01"
export FM_LIBDEFLATE_HASH_TYPE="SHA-256"
