#!/bin/bash
# Configuration script for thrift 0.14.2
# Library release date: 2021/06/17

export FM_THRIFT_NAME="thrift"
export FM_THRIFT_VERSION="0.14.2"
export FM_THRIFT_FULL_NAME="${FM_THRIFT_NAME}-${FM_THRIFT_VERSION}"
export FM_THRIFT_TARBALL_NAME="${FM_THRIFT_FULL_NAME}.tar.gz"
export FM_THRIFT_TARBALL_DOWNLOAD_URL="https://www.apache.org/dist/thrift/${FM_THRIFT_VERSION}/${FM_THRIFT_TARBALL_NAME}"
export FM_THRIFT_INSTALL_CHECK="include/thrift/config.h"
export FM_THRIFT_HASH="284a48df355aa3910687ee9b894d3ae8"
export FM_THRIFT_HASH_TYPE="MD5"
