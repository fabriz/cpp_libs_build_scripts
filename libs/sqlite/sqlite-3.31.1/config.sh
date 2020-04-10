#!/bin/bash
# Configuration script for sqlite 3.31.1
# Library release date: 2020/01/27

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3310100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2020/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="0c30f5b22152a8166aa3bebb0f4bc1f3e9cc508b"
export FM_SQLITE_HASH_TYPE="SHA-1"
