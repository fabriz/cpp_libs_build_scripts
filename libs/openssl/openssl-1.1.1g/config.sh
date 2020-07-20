#!/bin/bash
# Configuration script for openssl 1.1.1g
# Library release date: 2020/04/21

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="1.1.1g"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="ddb04774f1e32f0c49751e21b67216ac87852ceb056b75209af2443400636d46"
export FM_OPENSSL_HASH_TYPE="SHA-256"
