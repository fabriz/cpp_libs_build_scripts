#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for curl 8.10.1
# Library release date: 2024/09/18

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="8.10.1"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="73a4b0e99596a09fa5924a4fb7e4b995a85fda0d18a2c02ab9cf134bebce04ee"
export FM_CURL_HASH_TYPE="SHA-256"
