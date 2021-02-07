#!/bin/bash
# Configuration script for curl 7.74.0
# Library release date: 2020/12/09

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="7.74.0"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="999d5f2c403cf6e25d58319fdd596611e455dd195208746bc6e6d197a77e878b"
export FM_CURL_HASH_TYPE="SHA-256"
