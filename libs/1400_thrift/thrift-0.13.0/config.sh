#!/bin/bash
# Configuration script for thrift 0.13.0

export FM_THRIFT_NAME="thrift"
export FM_THRIFT_VERSION="0.13.0"
export FM_THRIFT_FULL_NAME="${FM_THRIFT_NAME}-${FM_THRIFT_VERSION}"
export FM_THRIFT_TARBALL_NAME="${FM_THRIFT_FULL_NAME}.tar.gz"
export FM_THRIFT_TARBALL_DOWNLOAD_URL="https://www.apache.org/dist/thrift/${FM_THRIFT_VERSION}/${FM_THRIFT_TARBALL_NAME}"
export FM_THRIFT_INSTALL_CHECK="include/thrift/config.h"
export FM_THRIFT_HASH="38a27d391a2b03214b444cb13d5664f1"
export FM_THRIFT_HASH_TYPE="MD5"
