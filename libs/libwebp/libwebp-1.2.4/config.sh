#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libwebp 1.2.4
# Library release date: 2022/08/04

export FM_WEBP_NAME="libwebp"
export FM_WEBP_VERSION="1.2.4"
export FM_WEBP_FULL_NAME="${FM_WEBP_NAME}-${FM_WEBP_VERSION}"
export FM_WEBP_TARBALL_NAME="${FM_WEBP_FULL_NAME}.tar.gz"
export FM_WEBP_TARBALL_DOWNLOAD_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${FM_WEBP_TARBALL_NAME}"
export FM_WEBP_INSTALL_CHECK="include/webp/types.h"
export FM_WEBP_HASH="7bf5a8a28cc69bcfa8cb214f2c3095703c6b73ac5fba4d5480c205331d9494df"
export FM_WEBP_HASH_TYPE="SHA-256"
