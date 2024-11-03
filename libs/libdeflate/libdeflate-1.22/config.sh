#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libdeflate 1.22
# Library release date: 2024/10/05

export FM_LIBDEFLATE_NAME="libdeflate"
export FM_LIBDEFLATE_VERSION="1.22"
export FM_LIBDEFLATE_FULL_NAME="${FM_LIBDEFLATE_NAME}-${FM_LIBDEFLATE_VERSION}"
export FM_LIBDEFLATE_TARBALL_NAME="${FM_LIBDEFLATE_FULL_NAME}.tar.gz"
export FM_LIBDEFLATE_TARBALL_DOWNLOAD_URL="https://github.com/ebiggers/libdeflate/archive/refs/tags/v${FM_LIBDEFLATE_VERSION}.tar.gz"
export FM_LIBDEFLATE_INSTALL_CHECK="include/libdeflate.h"
export FM_LIBDEFLATE_HASH="7f343c7bf2ba46e774d8a632bf073235e1fd27723ef0a12a90f8947b7fe851d6"
export FM_LIBDEFLATE_HASH_TYPE="SHA-256"
