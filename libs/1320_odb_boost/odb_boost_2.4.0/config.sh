#!/bin/bash
# Configuration script for odb_boost 2.4.0

export FM_ODBBOOST_NAME="libodb-boost"
export FM_ODBBOOST_VERSION="2.4.0"
export FM_ODBBOOST_FULL_NAME="${FM_ODBBOOST_NAME}-${FM_ODBBOOST_VERSION}"
export FM_ODBBOOST_TARBALL_NAME="${FM_ODBBOOST_FULL_NAME}.tar.bz2"
export FM_ODBBOOST_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODBBOOST_TARBALL_NAME}"
export FM_ODBBOOST_INSTALL_CHECK="include/odb/boost/version.hxx"
export FM_ODBBOOST_HASH="f813702b2856732e199ae34e3393b8cecff878ef"
export FM_ODBBOOST_HASH_TYPE="SHA-1"
