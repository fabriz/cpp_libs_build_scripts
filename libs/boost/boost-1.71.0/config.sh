#!/bin/bash
# Configuration script for boost 1.71.0
# Library release date: 2019/08/19

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.71.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://boostorg.jfrog.io/artifactory/main/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="d73a8da01e8bf8c7eda40b4c84915071a8c8a0df4a6734537ddde4a8580524ee"
export FM_BOOST_HASH_TYPE="SHA-256"
