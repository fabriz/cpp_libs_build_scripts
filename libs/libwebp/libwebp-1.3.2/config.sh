#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libwebp 1.3.2
# Library release date: 2023/09/14

export FM_WEBP_NAME="libwebp"
export FM_WEBP_VERSION="1.3.2"
export FM_WEBP_FULL_NAME="${FM_WEBP_NAME}-${FM_WEBP_VERSION}"
export FM_WEBP_TARBALL_NAME="${FM_WEBP_FULL_NAME}.tar.gz"
export FM_WEBP_TARBALL_DOWNLOAD_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${FM_WEBP_TARBALL_NAME}"
export FM_WEBP_INSTALL_CHECK="include/webp/types.h"
export FM_WEBP_HASH="2a499607df669e40258e53d0ade8035ba4ec0175244869d1025d460562aa09b4"
export FM_WEBP_HASH_TYPE="SHA-256"
