#!/bin/bash
# Configuration script for ical 3.0.10
# Library release date: 2021/04/17

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.10"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_UNTAR_FLAGS="--exclude=*/ReadMe.md"
export FM_ICAL_UNTAR_DIR="libical-libical-*"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="24816b99af0927cf99a7d3fd8d41df4225b76129e87e5b1eafc7416049fee1e2"
export FM_ICAL_HASH_TYPE="SHA-256"
