#!/bin/bash
# Configuration script for botan 2.15.0
# Library release date: 2020/07/07

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.15.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="d88af1307f1fefac79aa4f2f524699478d69ce15a857cf2d0a90ac6bf2a50009"
export FM_BOTAN_HASH_TYPE="SHA-256"
