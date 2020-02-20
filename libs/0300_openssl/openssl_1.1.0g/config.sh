#!/bin/bash
# Configuration script for openssl 1.1.0g

export FM_OPENSSL_NAME="openssl"
export FM_OPENSSL_VERSION="1.1.0g"
export FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
export FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
export FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
export FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
export FM_OPENSSL_HASH="de4d501267da39310905cb6dc8c6121f7a2cad45a7707f76df828fe1b85073af"
export FM_OPENSSL_HASH_TYPE="SHA-256"
