#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for jansson 2.14.0
# Library release date: 2021/09/09

export FM_JANSSON_NAME="jansson"
export FM_JANSSON_VERSION="2.14"
export FM_JANSSON_FULL_NAME="${FM_JANSSON_NAME}-${FM_JANSSON_VERSION}"
export FM_JANSSON_TARBALL_NAME="${FM_JANSSON_FULL_NAME}.tar.gz"
export FM_JANSSON_TARBALL_DOWNLOAD_URL="https://github.com/akheron/jansson/archive/v${FM_JANSSON_VERSION}.tar.gz"
export FM_JANSSON_INSTALL_CHECK="include/jansson.h"
export FM_JANSSON_HASH="c739578bf6b764aa0752db9a2fdadcfe921c78f1228c7ec0bb47fa804c55d17b"
export FM_JANSSON_HASH_TYPE="SHA-256"
