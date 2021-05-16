#!/bin/bash
# Configuration script for curl 7.76.1
# Library release date: 2021/04/14

export FM_CURL_NAME="curl"
export FM_CURL_VERSION="7.76.1"
export FM_CURL_FULL_NAME="${FM_CURL_NAME}-${FM_CURL_VERSION}"
export FM_CURL_TARBALL_NAME="${FM_CURL_FULL_NAME}.tar.xz"
export FM_CURL_TARBALL_DOWNLOAD_URL="https://curl.se/download/${FM_CURL_TARBALL_NAME}"
export FM_CURL_INSTALL_CHECK="include/curl/curl.h"
export FM_CURL_HASH="64bb5288c39f0840c07d077e30d9052e1cbb9fa6c2dc52523824cc859e679145"
export FM_CURL_HASH_TYPE="SHA-256"
