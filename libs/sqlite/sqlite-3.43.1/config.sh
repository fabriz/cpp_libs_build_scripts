#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for sqlite 3.43.1
# Library release date: 2023/09/11

export FM_SQLITE_NAME="sqlite-autoconf"
export FM_SQLITE_VERSION="3430100"
export FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
export FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
export FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2023/${FM_SQLITE_TARBALL_NAME}"
export FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
export FM_SQLITE_HASH="39116c94e76630f22d54cd82c3cea308565f1715f716d1b2527f1c9c969ba4d9"
export FM_SQLITE_HASH_TYPE="SHA-256"

# SHA3-256: fd32866c281539eae95cd90b5c2c34337d8808822a988211b9b009c1e788e42d
