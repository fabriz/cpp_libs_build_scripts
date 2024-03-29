#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for odb_sqlite 2.4.0
# Library release date: 2015/02/11

export FM_ODBSQLITE_NAME="libodb-sqlite"
export FM_ODBSQLITE_VERSION="2.4.0"
export FM_ODBSQLITE_FULL_NAME="${FM_ODBSQLITE_NAME}-${FM_ODBSQLITE_VERSION}"
export FM_ODBSQLITE_TARBALL_NAME="${FM_ODBSQLITE_FULL_NAME}.tar.bz2"
export FM_ODBSQLITE_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODBSQLITE_TARBALL_NAME}"
export FM_ODBSQLITE_INSTALL_CHECK="include/odb/sqlite/version.hxx"
export FM_ODBSQLITE_HASH="3be07e7702abf8adcbe7736f372ef9980cec1003"
export FM_ODBSQLITE_HASH_TYPE="SHA-1"
