#!/bin/bash
# Configuration script for sqlite 3.26.0
# Library release date: 2018/12/01

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3260000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2018/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="9af2df1a6da5db6e2ecf3f463625f16740e036e9"
export FM_SQLITE_HASH_TYPE="SHA-1"
