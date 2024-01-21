#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libmusicbrainz-fabriz 5.1.0.2
# Library release date: 2024/01/10

export FM_MUSICBRAINZ_NAME="libmusicbrainz-fabriz"
export FM_MUSICBRAINZ_VERSION="5.1.0.2"
export FM_MUSICBRAINZ_FULL_NAME="${FM_MUSICBRAINZ_NAME}-${FM_MUSICBRAINZ_VERSION}"
export FM_MUSICBRAINZ_TARBALL_NAME="${FM_MUSICBRAINZ_FULL_NAME}.tar.xz"
export FM_MUSICBRAINZ_TARBALL_DOWNLOAD_URL="https://github.com/fabriz/libmusicbrainz/releases/download/release-${FM_MUSICBRAINZ_VERSION}-fabriz/${FM_MUSICBRAINZ_TARBALL_NAME}"
export FM_MUSICBRAINZ_INSTALL_CHECK="include/musicbrainz5/defines.h"
export FM_MUSICBRAINZ_HASH="18d3fc2c2ec763ccc2f7c0c3b9962ce52270b9401ac2e35ba5863cd4038adf53"
export FM_MUSICBRAINZ_HASH_TYPE="SHA-256"
