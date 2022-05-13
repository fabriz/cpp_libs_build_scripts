#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for curl 7.82.0
# Library release date: 2022/03/05

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="7.82.0"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="0aaa12d7bd04b0966254f2703ce80dd5c38dbbd76af0297d3d690cdce58a583c"
export FM_CURL_HASH_TYPE="SHA-256"
