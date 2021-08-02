#!/bin/bash
# Configuration script for sqlite 3.36.0
# Library release date: 2021/06/18

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3360000"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2021/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="bd90c3eb96bee996206b83be7065c9ce19aef38c3f4fb53073ada0d0b69bbce3"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: fdc699685a20284cb72efe3e3ddfac58e94d8ffd5b229a8235d49265aa776678
