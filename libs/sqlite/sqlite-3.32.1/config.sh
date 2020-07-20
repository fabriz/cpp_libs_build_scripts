#!/bin/bash
# Configuration script for sqlite 3.32.1
# Library release date: 2020/05/25

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3320100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2020/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="3d34d86ef726b66edeb0b93b2a4c0d036ea8dcf3"
export FM_SQLITE_HASH_TYPE="SHA-1"
