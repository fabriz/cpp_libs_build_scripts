#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for flac 1.3.4
# Library release date: 2022/02/21

export FM_FLAC_NAME="flac"
export FM_FLAC_VERSION="1.3.4"
export FM_FLAC_FULL_NAME="${FM_FLAC_NAME}-${FM_FLAC_VERSION}"
export FM_FLAC_TARBALL_NAME="${FM_FLAC_FULL_NAME}.tar.xz"
export FM_FLAC_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/flac/${FM_FLAC_TARBALL_NAME}"
export FM_FLAC_INSTALL_CHECK="include/FLAC/all.h"
export FM_FLAC_HASH="8ff0607e75a322dd7cd6ec48f4f225471404ae2730d0ea945127b1355155e737"
export FM_FLAC_HASH_TYPE="SHA-256"
