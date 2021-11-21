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
    zstd/1.5.0
    fftw/3.3.9
    sqlite/3.36.0
    openssl/1.1.1k
    libzip/1.8.0
    libzippp/4.1-1.8.0
    utf8cpp/3.2.1
    icu4c/69.1
    libxml2/2.9.12
    libxslt/1.1.34
    tinyxml2/9.0.0
    jansson/2.13.1
    neon/0.31.2
    curl/7.76.1
    libogg/1.3.5
    flac/1.3.3
    libcdio/2.1.0
    libcdio-paranoia/10.2+2.0.1
    libmusicbrainz/5.1.0
    libpng/1.6.37
    jpeg/9d
    libwebp/1.2.0
    libtiff/4.3.0
    graphicsmagick/1.3.36
    boost/1.76.0
    botan/2.18.1
    libodb/2.4.0
    libodb-sqlite/2.4.0
    libodb-boost/2.4.0
    thrift/0.14.2
    wt/4.5.0
    libical/3.0.10
)

# libtiff/4.3.0 fails to build with android_clang and yocto_gcc
if [ ${FM_TARGET_TOOLCHAIN} = "android_clang" ] || [ ${FM_TARGET_PLATFORM} = "yocto_gcc" ]; then
    FM_LIBSET_LIBS=("${FM_LIBSET_LIBS[@]/libtiff\/4.3.0/libtiff\/4.2.0}")
fi

# wt/4.5.0 fails to build with windows_mingw
if [ ${FM_TARGET_TOOLCHAIN} = "windows_mingw" ]; then
    FM_LIBSET_LIBS=("${FM_LIBSET_LIBS[@]/wt\/4.5.0/wt\/4.2.0}")
fi
