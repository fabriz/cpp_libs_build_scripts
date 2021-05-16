#!/bin/bash
# Configuration script for thrift 0.14.1
# Library release date: 2021/03/08

export FM_THRIFT_NAME="thrift"
export FM_THRIFT_VERSION="0.14.1"
export FM_THRIFT_FULL_NAME="${FM_THRIFT_NAME}-${FM_THRIFT_VERSION}"
export FM_THRIFT_TARBALL_NAME="${FM_THRIFT_FULL_NAME}.tar.gz"
export FM_THRIFT_TARBALL_DOWNLOAD_URL="https://www.apache.org/dist/thrift/${FM_THRIFT_VERSION}/${FM_THRIFT_TARBALL_NAME}"
export FM_THRIFT_INSTALL_CHECK="include/thrift/config.h"
export FM_THRIFT_HASH="c64434548438df2cb1e53fb27c600e85"
export FM_THRIFT_HASH_TYPE="MD5"
