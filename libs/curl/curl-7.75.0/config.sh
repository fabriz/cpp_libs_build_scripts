#!/bin/bash
# Configuration script for curl 7.75.0
# Library release date: 2021/02/03

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="7.75.0"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="fe0c49d8468249000bda75bcfdf9e30ff7e9a86d35f1a21f428d79c389d55675"
export FM_CURL_HASH_TYPE="SHA-256"
