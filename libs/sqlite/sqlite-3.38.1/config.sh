#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.38.1
# Library release date: 2022/03/12

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3380100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2022/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="8e3a8ceb9794d968399590d2ddf9d5c044a97dd83d38b9613364a245ec8a2fc4"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: aee9f7a2dde4354eb57445f15c88ca870bed242fe5e6ad231f6a95cd0edc1489
