#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

# Configuration script for ical 3.0.4
# Library release date: 2018/08/14

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.4"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_UNTAR_FLAGS="--exclude=*/ReadMe.md"
export FM_ICAL_UNTAR_DIR="libical-libical-*"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="d253d4e975cdc7564fff62bf1a39d0151a7c1998"
export FM_ICAL_HASH_TYPE="SHA-1"
