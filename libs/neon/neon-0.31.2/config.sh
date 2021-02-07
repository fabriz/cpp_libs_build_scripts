#!/bin/bash
# Configuration script for neon 0.31.2
# Library release date: 2020/06/20

export FM_NEON_NAME="neon"
export FM_NEON_VERSION="0.31.2"
export FM_NEON_FULL_NAME="${FM_NEON_NAME}-${FM_NEON_VERSION}"
export FM_NEON_TARBALL_NAME="${FM_NEON_FULL_NAME}.tar.gz"
export FM_NEON_TARBALL_DOWNLOAD_URL="https://notroj.github.io/neon/${FM_NEON_TARBALL_NAME}"
export FM_NEON_INSTALL_CHECK="include/neon/ne_defs.h"
export FM_NEON_HASH="cf1ee3ac27a215814a9c80803fcee4f0ede8466ebead40267a9bd115e16a8678"
export FM_NEON_HASH_TYPE="SHA-256"
