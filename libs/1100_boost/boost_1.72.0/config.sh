#!/bin/bash
# Configuration script for boost 1.72.0

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.72.0"
export FM_BOOST_SHORT_VERSION="1.72"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://dl.bintray.com/boostorg/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="59c9b274bc451cf91a9ba1dd2c7fdcaf5d60b1b3aa83f2c9fa143417cc660722"
export FM_BOOST_HASH_TYPE="SHA-256"
