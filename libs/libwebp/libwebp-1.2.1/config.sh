#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libwebp 1.2.1
# Library release date: 2021/08/13

export FM_WEBP_NAME="libwebp"
export FM_WEBP_VERSION="1.2.1"
export FM_WEBP_FULL_NAME="${FM_WEBP_NAME}-${FM_WEBP_VERSION}"
export FM_WEBP_TARBALL_NAME="${FM_WEBP_FULL_NAME}.tar.gz"
export FM_WEBP_TARBALL_DOWNLOAD_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${FM_WEBP_TARBALL_NAME}"
export FM_WEBP_INSTALL_CHECK="include/webp/types.h"
export FM_WEBP_HASH="808b98d2f5b84e9b27fdef6c5372dac769c3bda4502febbfa5031bd3c4d7d018"
export FM_WEBP_HASH_TYPE="SHA-256"
