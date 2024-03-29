#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for jansson 2.13.1
# Library release date: 2020/05/07

export FM_JANSSON_NAME="jansson"
export FM_JANSSON_VERSION="2.13.1"
export FM_JANSSON_FULL_NAME="${FM_JANSSON_NAME}-${FM_JANSSON_VERSION}"
export FM_JANSSON_TARBALL_NAME="${FM_JANSSON_FULL_NAME}.tar.gz"
export FM_JANSSON_TARBALL_DOWNLOAD_URL="https://github.com/akheron/jansson/archive/v${FM_JANSSON_VERSION}.tar.gz"
export FM_JANSSON_INSTALL_CHECK="include/jansson.h"
export FM_JANSSON_HASH="f22901582138e3203959c9257cf83eba9929ac41d7be4a42557213a22ebcc7a0"
export FM_JANSSON_HASH_TYPE="SHA-256"
