#!/bin/bash

FM_ZLIB_NAME="zlib"
FM_ZLIB_VERSION="1.2.11"
FM_ZLIB_FULL_NAME="${FM_ZLIB_NAME}-${FM_ZLIB_VERSION}"
FM_ZLIB_TARBALL_NAME="${FM_ZLIB_FULL_NAME}.tar.gz"
FM_ZLIB_TARBALL_DOWNLOAD_URL="https://zlib.net/${FM_ZLIB_TARBALL_NAME}"
FM_ZLIB_INSTALL_CHECK="include/zlib.h"
FM_ZLIB_HASH="c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1"
FM_ZLIB_HASH_TYPE="SHA-256"

FM_BZIP2_NAME="bzip2"
FM_BZIP2_VERSION="1.0.6"
FM_BZIP2_FULL_NAME="${FM_BZIP2_NAME}-${FM_BZIP2_VERSION}"
FM_BZIP2_TARBALL_NAME="${FM_BZIP2_FULL_NAME}.tar.gz"
FM_BZIP2_TARBALL_DOWNLOAD_URL="http://www.bzip.org/${FM_BZIP2_VERSION}/${FM_BZIP2_TARBALL_NAME}"
FM_BZIP2_INSTALL_CHECK="include/bzlib.h"
FM_BZIP2_HASH="00b516f4704d4a7cb50a1d97e6e8e15b"
FM_BZIP2_HASH_TYPE="MD5"

FM_SQLITE_NAME="sqlite-autoconf"
FM_SQLITE_VERSION="3210000"
FM_SQLITE_FULL_NAME="${FM_SQLITE_NAME}-${FM_SQLITE_VERSION}"
FM_SQLITE_TARBALL_NAME="${FM_SQLITE_FULL_NAME}.tar.gz"
FM_SQLITE_TARBALL_DOWNLOAD_URL="http://sqlite.org/2017/${FM_SQLITE_TARBALL_NAME}"
FM_SQLITE_INSTALL_CHECK="include/sqlite3.h"
FM_SQLITE_HASH="f56fe3407d8297fc0a68a058f4c9e6b77e83575c"
FM_SQLITE_HASH_TYPE="SHA-1"

FM_OPENSSL_NAME="openssl"
FM_OPENSSL_VERSION="1.1.0g"
FM_OPENSSL_FULL_NAME="${FM_OPENSSL_NAME}-${FM_OPENSSL_VERSION}"
FM_OPENSSL_TARBALL_NAME="${FM_OPENSSL_FULL_NAME}.tar.gz"
FM_OPENSSL_TARBALL_DOWNLOAD_URL="https://www.openssl.org/source/${FM_OPENSSL_TARBALL_NAME}"
FM_OPENSSL_INSTALL_CHECK="include/openssl/opensslconf.h"
FM_OPENSSL_HASH="de4d501267da39310905cb6dc8c6121f7a2cad45a7707f76df828fe1b85073af"
FM_OPENSSL_HASH_TYPE="SHA-256"

FM_BOOST_NAME="boost"
FM_BOOST_VERSION="1.66.0"
FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
FM_BOOST_HASH="5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9"
FM_BOOST_HASH_TYPE="SHA-256"

FM_BOTAN_NAME="Botan"
FM_BOTAN_VERSION="2.4.0"
FM_BOTAN_FULL_NAME="${FM_BOTAN_NAME}-${FM_BOTAN_VERSION}"
FM_BOTAN_TARBALL_NAME="${FM_BOTAN_FULL_NAME}.tgz"
FM_BOTAN_TARBALL_DOWNLOAD_URL="https://botan.randombit.net/releases/${FM_BOTAN_TARBALL_NAME}"
FM_BOTAN_INSTALL_CHECK="include/botan/botan.h"
FM_BOTAN_HASH="ed9464e2a5cfee4cd3d9bd7a8f80673b45c8a0718db2181a73f5465a606608a5"
FM_BOTAN_HASH_TYPE="SHA-256"

FM_ODB_NAME="libodb"
FM_ODB_VERSION="2.4.0"
FM_ODB_FULL_NAME="${FM_ODB_NAME}-${FM_ODB_VERSION}"
FM_ODB_TARBALL_NAME="${FM_ODB_FULL_NAME}.tar.bz2"
FM_ODB_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODB_TARBALL_NAME}"
FM_ODB_INSTALL_CHECK="include/odb/version.hxx"
FM_ODB_HASH="42bd2a8023e338e004711e755eb30bd122b844a6"
FM_ODB_HASH_TYPE="SHA-1"

FM_ODBSQLITE_NAME="libodb-sqlite"
FM_ODBSQLITE_VERSION="2.4.0"
FM_ODBSQLITE_FULL_NAME="${FM_ODBSQLITE_NAME}-${FM_ODBSQLITE_VERSION}"
FM_ODBSQLITE_TARBALL_NAME="${FM_ODBSQLITE_FULL_NAME}.tar.bz2"
FM_ODBSQLITE_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODBSQLITE_TARBALL_NAME}"
FM_ODBSQLITE_INSTALL_CHECK="include/odb/sqlite/version.hxx"
FM_ODBSQLITE_HASH="3be07e7702abf8adcbe7736f372ef9980cec1003"
FM_ODBSQLITE_HASH_TYPE="SHA-1"

FM_ODBBOOST_NAME="libodb-boost"
FM_ODBBOOST_VERSION="2.4.0"
FM_ODBBOOST_FULL_NAME="${FM_ODBBOOST_NAME}-${FM_ODBBOOST_VERSION}"
FM_ODBBOOST_TARBALL_NAME="${FM_ODBBOOST_FULL_NAME}.tar.bz2"
FM_ODBBOOST_TARBALL_DOWNLOAD_URL="https://www.codesynthesis.com/download/odb/2.4/${FM_ODBBOOST_TARBALL_NAME}"
FM_ODBBOOST_INSTALL_CHECK="include/odb/boost/version.hxx"
FM_ODBBOOST_HASH="f813702b2856732e199ae34e3393b8cecff878ef"
FM_ODBBOOST_HASH_TYPE="SHA-1"

FM_THRIFT_NAME="thrift"
FM_THRIFT_VERSION="0.11.0"
FM_THRIFT_FULL_NAME="${FM_THRIFT_NAME}-${FM_THRIFT_VERSION}"
FM_THRIFT_TARBALL_NAME="${FM_THRIFT_FULL_NAME}.tar.gz"
FM_THRIFT_TARBALL_DOWNLOAD_URL="https://www.apache.org/dist/thrift/${FM_THRIFT_VERSION}/${FM_THRIFT_TARBALL_NAME}"
FM_THRIFT_INSTALL_CHECK="include/thrift/config.h"
FM_THRIFT_HASH="0be59730ebce071eceaf6bfdb8d3a20e"
FM_THRIFT_HASH_TYPE="MD5"

