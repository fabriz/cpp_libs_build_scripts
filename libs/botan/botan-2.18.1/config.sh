#!/bin/bash
# Configuration script for botan 2.18.1
# Library release date: 2021/05/09

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.18.1"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tar.xz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.lgtm.yml --exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="f8c7b46222a857168a754a5cc329bb780504122b270018dda5304c98db28ae29"
export FM_BOTAN_HASH_TYPE="SHA-256"
