#!/bin/bash
# Configuration script for ical 3.0.7

export FM_ICAL_NAME="libical"
export FM_ICAL_VERSION="3.0.7"
export FM_ICAL_FULL_NAME="${FM_ICAL_NAME}-${FM_ICAL_VERSION}"
export FM_ICAL_TARBALL_NAME="${FM_ICAL_FULL_NAME}.tar.gz"
export FM_ICAL_TARBALL_DOWNLOAD_URL="https://github.com/libical/libical/tarball/v${FM_ICAL_VERSION}"
export FM_ICAL_INSTALL_CHECK="include/libical/ical.h"
export FM_ICAL_HASH="ac5eae2310560024c18b92e7cc29388f0388ca87fac92836a80eb08372f39e24"
export FM_ICAL_HASH_TYPE="SHA-256"
