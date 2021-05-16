#!/bin/bash
# Configuration script for botan 2.18.0
# Library release date: 2021/04/15

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.18.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="cc64852e1e0c5bb30ecd052e4a12d5136125a8ce5c3be2efb6fb061c8677e327"
export FM_BOTAN_HASH_TYPE="SHA-256"
