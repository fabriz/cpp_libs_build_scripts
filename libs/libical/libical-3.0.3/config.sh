#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for ical 3.0.3
# Library release date: 2018/02/27

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.3"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_UNTAR_FLAGS="--exclude=*/ReadMe.md"
export FM_ICAL_UNTAR_DIR="libical-libical-*"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="3162092c49d30c6b900b41ef5e958d9407d592d7"
export FM_ICAL_HASH_TYPE="SHA-1"
