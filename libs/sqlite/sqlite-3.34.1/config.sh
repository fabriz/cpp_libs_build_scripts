#!/bin/bash
# Configuration script for sqlite 3.34.1
# Library release date: 2021/01/20

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3340100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2021/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="2a3bca581117b3b88e5361d0ef3803ba6d8da604b1c1a47d902ef785c1b53e89"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: c1c6cc050139debf8d44d9f1bc3b0d95953e444712252975ac43bc526930af52
