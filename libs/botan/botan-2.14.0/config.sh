#!/bin/bash
# Configuration script for botan 2.14.0
# Library release date: 2020/04/06

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.14.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="0c10f12b424a40ee19bde00292098e201d7498535c062d8d5b586d07861a54b5"
export FM_BOTAN_HASH_TYPE="SHA-256"
