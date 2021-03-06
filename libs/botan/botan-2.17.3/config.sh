#!/bin/bash
# Configuration script for botan 2.17.3
# Library release date: 2020/12/21

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.17.3"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="79123b654445a4abba486e09a431788545c708237382a3e765664c9f55b03b88"
export FM_BOTAN_HASH_TYPE="SHA-256"
