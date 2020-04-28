#!/bin/bash
# Configuration script for sqlite 3.30.1
# Library release date: 2019/10/11

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3300100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2019/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="8383f29d53fa1d4383e4c8eb3e087f2ed940a9e0"
export FM_SQLITE_HASH_TYPE="SHA-1"
