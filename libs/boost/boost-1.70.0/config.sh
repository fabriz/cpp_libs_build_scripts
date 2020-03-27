#!/bin/bash
# Configuration script for boost 1.70.0
# Library release date: 2019/04/12

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.70.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="430ae8354789de4fd19ee52f3b1f739e1fba576f0aded0897c3c2bc00fb38778"
export FM_BOOST_HASH_TYPE="SHA-256"
