#!/bin/bash
# Configuration script for botan 2.6.0

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.6.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tgz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="c1f261555bba702c73608dde7bd743ef2d6377a41a1c295915b25c5babaf5cc5"
export FM_BOTAN_HASH_TYPE="SHA-256"
