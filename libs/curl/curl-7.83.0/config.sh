#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for curl 7.83.0
# Library release date: 2022/04/27

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="7.83.0"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="bbff0e6b5047e773f3c3b084d80546cc1be4e354c09e419c2d0ef6116253511a"
export FM_CURL_HASH_TYPE="SHA-256"
