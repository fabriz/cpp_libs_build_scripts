#!/bin/bash
# Configuration script for libxml2 2.9.10
# Library release date: 2019/10/30

export FM_LIBXML2_NAME="libxml2"
export FM_LIBXML2_VERSION="2.9.10"
export FM_LIBXML2_FULL_NAME="${FM_LIBXML2_NAME}-${FM_LIBXML2_VERSION}"
export FM_LIBXML2_TARBALL_NAME="${FM_LIBXML2_FULL_NAME}.tar.gz"
export FM_LIBXML2_TARBALL_DOWNLOAD_URL="ftp://xmlsoft.org/libxml2/${FM_LIBXML2_TARBALL_NAME}"
export FM_LIBXML2_INSTALL_CHECK="include/libxml/xmlversion.h"
export FM_LIBXML2_HASH="aafee193ffb8fe0c82d4afef6ef91972cbaf5feea100edc2f262750611b4be1f"
export FM_LIBXML2_HASH_TYPE="SHA-256"
