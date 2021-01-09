#!/bin/bash
# Configuration script for botan 2.8.0
# Library release date: 2018/10/01

export FM_BOTAN_NAME="Botan"
export FM_BOTAN_VERSION="2.8.0"
export FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
export FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tgz"
export FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
export FM_BOTAN_UNTAR_FLAGS="--exclude=*/.travis.yml"
export FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
export FM_BOTAN_HASH="e7159b127e91e0c158245d61c638c50d443ec7b440b6b0161328c47b3aba3960"
export FM_BOTAN_HASH_TYPE="SHA-256"
