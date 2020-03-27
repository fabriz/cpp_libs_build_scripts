#!/bin/bash
# Configuration script for bzip2 1.0.8
# Library release date: 2019/07/13

export FM_BZIP2_NAME="bzip2"
export FM_BZIP2_VERSION="1.0.8"
export FM_BZIP2_FULL_NAME="${FM_BZIP2_NAME}-${FM_BZIP2_VERSION}"
export FM_BZIP2_TARBALL_NAME="${FM_BZIP2_FULL_NAME}.tar.gz"
export FM_BZIP2_TARBALL_DOWNLOAD_URL="https://sourceware.org/pub/bzip2/${FM_BZIP2_TARBALL_NAME}"
export FM_BZIP2_INSTALL_CHECK="include/bzlib.h"
export FM_BZIP2_HASH="bf7badf7e248e0ecf465d33c2f5aeec774209227"
export FM_BZIP2_HASH_TYPE="SHA-1"
