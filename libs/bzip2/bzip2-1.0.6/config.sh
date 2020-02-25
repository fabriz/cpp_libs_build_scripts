#!/bin/bash
# Configuration script for bzip2 1.0.6

export FM_BZIP2_NAME="bzip2"
export FM_BZIP2_VERSION="1.0.6"
export FM_BZIP2_FULL_NAME="${FM_BZIP2_NAME}-${FM_BZIP2_VERSION}"
export FM_BZIP2_TARBALL_NAME="${FM_BZIP2_FULL_NAME}.tar.gz"
export FM_BZIP2_TARBALL_DOWNLOAD_URL="http://www.bzip.org/${FM_BZIP2_VERSION}/${FM_BZIP2_TARBALL_NAME}"
export FM_BZIP2_INSTALL_CHECK="include/bzlib.h"
export FM_BZIP2_HASH="00b516f4704d4a7cb50a1d97e6e8e15b"
export FM_BZIP2_HASH_TYPE="MD5"
