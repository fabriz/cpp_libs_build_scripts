#!/bin/bash
# Configuration script for botan 2.9.0

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.9.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tgz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="305564352334dd63ae63db039077d96ae52dfa57a3248871081719b6a9f2d119"
export FM_BOTAN_HASH_TYPE="SHA-256"
