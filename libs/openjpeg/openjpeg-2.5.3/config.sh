#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2025 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for openjpeg 2.5.3
# Library release date: 2024/12/09

export FM_OPENJPEG_NAME="openjpeg"
export FM_OPENJPEG_VERSION="2.5.3"
export FM_OPENJPEG_FULL_NAME="${FM_OPENJPEG_NAME}-${FM_OPENJPEG_VERSION}"
export FM_OPENJPEG_TARBALL_NAME="${FM_OPENJPEG_FULL_NAME}.tar.gz"
export FM_OPENJPEG_TARBALL_DOWNLOAD_URL="https://github.com/uclouvain/openjpeg/archive/refs/tags/v${FM_OPENJPEG_VERSION}.tar.gz"
export FM_OPENJPEG_INSTALL_CHECK="include/openjpeg-2.5/openjpeg.h"
export FM_OPENJPEG_HASH="368fe0468228e767433c9ebdea82ad9d801a3ad1e4234421f352c8b06e7aa707"
export FM_OPENJPEG_HASH_TYPE="SHA-256"


