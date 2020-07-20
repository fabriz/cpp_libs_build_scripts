#!/bin/bash
# Configuration script for boost 1.73.0
# Library release date: 2020/04/28

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.73.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="4eb3b8d442b426dc35346235c8733b5ae35ba431690e38c6a8263dce9fcbb402"
export FM_BOOST_HASH_TYPE="SHA-256"
