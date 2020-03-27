#!/bin/bash
# Configuration script for openssl 1.1.0h
# Library release date: 2018/03/27

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="1.1.0h"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="5835626cde9e99656585fc7aaa2302a73a7e1340bf8c14fd635a62c66802a517"
export FM_OPENSSL_HASH_TYPE="SHA-256"
