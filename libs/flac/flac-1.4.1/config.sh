#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for flac 1.4.1
# Library release date: 2022/09/22

export FM_FLAC_NAME="flac"
export FM_FLAC_VERSION="1.4.1"
export FM_FLAC_FULL_NAME="${FM_FLAC_NAME}-${FM_FLAC_VERSION}"
export FM_FLAC_TARBALL_NAME="${FM_FLAC_FULL_NAME}.tar.xz"
export FM_FLAC_TARBALL_DOWNLOAD_URL="https://ftp.osuosl.org/pub/xiph/releases/flac/${FM_FLAC_TARBALL_NAME}"
export FM_FLAC_INSTALL_CHECK="include/FLAC/all.h"
export FM_FLAC_HASH="91303c3e5dfde52c3e94e75976c0ab3ee14ced278ab8f60033a3a12db9209ae6"
export FM_FLAC_HASH_TYPE="SHA-256"
