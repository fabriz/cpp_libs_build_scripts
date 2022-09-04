#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for libmusicbrainz-fabriz 5.1.0.1
# Library release date: 2022/08/18

export FM_MUSICBRAINZ_NAME="libmusicbrainz-fabriz"
export FM_MUSICBRAINZ_VERSION="5.1.0.1"
export FM_MUSICBRAINZ_FULL_NAME="${FM_MUSICBRAINZ_NAME}-${FM_MUSICBRAINZ_VERSION}"
export FM_MUSICBRAINZ_TARBALL_NAME="${FM_MUSICBRAINZ_FULL_NAME}.tar.xz"
export FM_MUSICBRAINZ_TARBALL_DOWNLOAD_URL="https://github.com/fabriz/libmusicbrainz/releases/download/release-${FM_MUSICBRAINZ_VERSION}-fabriz/${FM_MUSICBRAINZ_TARBALL_NAME}"
export FM_MUSICBRAINZ_INSTALL_CHECK="include/musicbrainz5/defines.h"
export FM_MUSICBRAINZ_HASH="16224568952b9291e964814a9a0c7a1d8817509a003af054e4c42ef2936cd75e"
export FM_MUSICBRAINZ_HASH_TYPE="SHA-256"
