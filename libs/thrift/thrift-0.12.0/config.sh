#!/bin/bash
# Configuration script for thrift 0.12.0
# Library release date: 2019/01/04

export FM_THRIFT_NAME="thrift"
export FM_THRIFT_VERSION="0.12.0"
export FM_THRIFT_FULL_NAME="${FM_THRIFT_NAME}-${FM_THRIFT_VERSION}"
export FM_THRIFT_TARBALL_NAME="${FM_THRIFT_FULL_NAME}.tar.gz"
export FM_THRIFT_TARBALL_DOWNLOAD_URL="https://www.apache.org/dist/thrift/${FM_THRIFT_VERSION}/${FM_THRIFT_TARBALL_NAME}"
export FM_THRIFT_INSTALL_CHECK="include/thrift/config.h"
export FM_THRIFT_HASH="3deebbb4d1ca77dd9c9e009a1ea02183"
export FM_THRIFT_HASH_TYPE="MD5"
