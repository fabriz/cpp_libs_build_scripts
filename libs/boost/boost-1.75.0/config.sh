#!/bin/bash
# Configuration script for boost 1.75.0
# Library release date: 2020/12/11

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.75.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="953db31e016db7bb207f11432bef7df100516eeb746843fa0486a222e3fd49cb"
export FM_BOOST_HASH_TYPE="SHA-256"
