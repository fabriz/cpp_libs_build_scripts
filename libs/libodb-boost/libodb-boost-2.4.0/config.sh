#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for odb_boost 2.4.0
# Library release date: 2015/02/11

export FM_ODBBOOST_NAME="libodb-boost"
export FM_ODBBOOST_VERSION="2.4.0"
export FM_ODBBOOST_FULL_NAME="${FM_ODBBOOST_NAME}-${FM_ODBBOOST_VERSION}"
export FM_ODBBOOST_TARBALL_NAME="${FM_ODBBOOST_FULL_NAME}.tar.bz2"
export FM_ODBBOOST_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODBBOOST_TARBALL_NAME}"
export FM_ODBBOOST_INSTALL_CHECK="include/odb/boost/version.hxx"
export FM_ODBBOOST_HASH="f813702b2856732e199ae34e3393b8cecff878ef"
export FM_ODBBOOST_HASH_TYPE="SHA-1"
