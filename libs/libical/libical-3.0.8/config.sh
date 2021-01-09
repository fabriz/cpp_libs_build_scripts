#!/bin/bash
# Configuration script for ical 3.0.8
# Library release date: 2020/03/07

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.8"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_UNTAR_FLAGS="--exclude=*/ReadMe.md"
export FM_ICAL_UNTAR_DIR="libical-libical-*"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="217fed4eac56be26af8f9ac4f75a64c57edde6ff63fa8a1c82ab948c72da1ea7"
export FM_ICAL_HASH_TYPE="SHA-256"
