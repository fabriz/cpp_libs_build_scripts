#!/bin/bash
# Configuration script for boost 1.66.0
# Library release date: 2017/12/18

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.66.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9"
export FM_BOOST_HASH_TYPE="SHA-256"
