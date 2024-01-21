#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

FM_LIBSET_LIBS=(
    zlib/1.2.11
    bzip2/1.0.8
    xz/5.2.5
    zstd/1.5.1
    fftw/3.3.10
    sqlite/3.37.1
    openssl/1.1.1m
    libzip/1.8.0
    libzippp/5.0-1.8.0
    utf8cpp/3.2.1
    icu4c/70.1
    libxml2/2.9.12
    libxslt/1.1.34
    tinyxml2/9.0.0
    jansson/2.14.0
    neon/0.32.1
    curl/7.80.0
    libogg/1.3.5
    flac/1.3.3
    libcdio/2.1.0
    libcdio-paranoia/10.2+2.0.1
    libmusicbrainz/5.1.0
    libpng/1.6.37
    jpeg/9d
    libwebp/1.2.1
    libtiff/4.3.0
    graphicsmagick/1.3.37
    boost/1.78.0
    botan2/2.18.2
    libodb/2.4.0
    libodb-sqlite/2.4.0
    libodb-boost/2.4.0
    thrift/0.15.0
    wt/4.6.1
    libical/3.0.12
)

# zstd/1.5.1 fails to build with windows_msvc
if [ ${FM_TARGET_TOOLCHAIN} = "windows_msvc" ]; then
    FM_LIBSET_LIBS=("${FM_LIBSET_LIBS[@]/zstd\/1.5.1/zstd\/1.5.0}")
fi
