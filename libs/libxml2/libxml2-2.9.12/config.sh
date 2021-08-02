#!/bin/bash
# Configuration script for libxml2 2.9.12
# Library release date: 2021/05/13

export FM_LIBXML2_NAME="libxml2"
export FM_LIBXML2_VERSION="2.9.12"
export FM_LIBXML2_FULL_NAME="${FM_LIBXML2_NAME}-${FM_LIBXML2_VERSION}"
export FM_LIBXML2_TARBALL_NAME="${FM_LIBXML2_FULL_NAME}.tar.gz"
export FM_LIBXML2_TARBALL_DOWNLOAD_URL="ftp://xmlsoft.org/libxml2/${FM_LIBXML2_TARBALL_NAME}"
export FM_LIBXML2_INSTALL_CHECK="include/libxml/xmlversion.h"
export FM_LIBXML2_HASH="c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92"
export FM_LIBXML2_HASH_TYPE="SHA-256"
