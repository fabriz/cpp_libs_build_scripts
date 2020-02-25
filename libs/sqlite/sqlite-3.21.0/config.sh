#!/bin/bash
# Configuration script for sqlite 3.21.0

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3210000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2017/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="f56fe3407d8297fc0a68a058f4c9e6b77e83575c"
export FM_SQLITE_HASH_TYPE="SHA-1"
