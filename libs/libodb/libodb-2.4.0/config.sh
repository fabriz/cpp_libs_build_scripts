#!/bin/bash
# Configuration script for odb 2.4.0

export FM_ODB_NAME="libodb"
export FM_ODB_VERSION="2.4.0"
export FM_ODB_FULL_NAME="${FM_ODB_NAME}-${FM_ODB_VERSION}"
export FM_ODB_TARBALL_NAME="${FM_ODB_FULL_NAME}.tar.bz2"
export FM_ODB_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODB_TARBALL_NAME}"
export FM_ODB_INSTALL_CHECK="include/odb/version.hxx"
export FM_ODB_HASH="42bd2a8023e338e004711e755eb30bd122b844a6"
export FM_ODB_HASH_TYPE="SHA-1"
