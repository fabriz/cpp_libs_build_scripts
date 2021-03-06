#!/bin/bash
# Configuration script for ical 3.0.9
# Library release date: 2021/01/16

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.9"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_UNTAR_FLAGS="--exclude=*/ReadMe.md"
export FM_ICAL_UNTAR_DIR="libical-libical-*"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="3cf3c9fbcaad05e0886ee687013cb62d24006802c285605676d3bec87e4e71e7"
export FM_ICAL_HASH_TYPE="SHA-256"
