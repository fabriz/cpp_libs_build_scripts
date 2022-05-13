#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for boost 1.79.0
# Library release date: 2022/04/13

export FM_BOOST_NAME="boost"
export FM_BOOST_VERSION="1.79.0"
export FM_BOOST_FULL_NAME="${FM_BOOST_NAME}_${FM_BOOST_VERSION//./_}"
export FM_BOOST_TARBALL_NAME="${FM_BOOST_FULL_NAME}.tar.bz2"
export FM_BOOST_TARBALL_DOWNLOAD_URL="https://boostorg.jfrog.io/artifactory/main/release/${FM_BOOST_VERSION}/source/${FM_BOOST_TARBALL_NAME}"
export FM_BOOST_INSTALL_CHECK="include/boost/config.hpp"
export FM_BOOST_HASH="475d589d51a7f8b3ba2ba4eda022b170e562ca3b760ee922c146b6c65856ef39"
export FM_BOOST_HASH_TYPE="SHA-256"
