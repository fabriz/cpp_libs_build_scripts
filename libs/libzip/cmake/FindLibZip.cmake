#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(BZip2 QUIET)
find_package(LibLZMA QUIET)
find_package(ZSTD QUIET)
find_package(OpenSSL QUIET)

find_path(LIBZIP_INCLUDE_DIR NAMES zip.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBZIP_LIBRARY NAMES zip PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBZIP_INCLUDE_DIR LIBZIP_LIBRARY)

if(LIBZIP_INCLUDE_DIR AND EXISTS "${LIBZIP_INCLUDE_DIR}/zipconf.h")
    file(STRINGS "${LIBZIP_INCLUDE_DIR}/zipconf.h" VERSION_LINE REGEX "^#define LIBZIP_VERSION[ ]+\"[^\"]*\"$")
    string(REGEX REPLACE "^#define LIBZIP_VERSION[ ]+\"([0-9.]+).*$" "\\1" LIBZIP_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("LIBZIP_INCLUDE_DIR: ${LIBZIP_INCLUDE_DIR}")
debugMessage("LIBZIP_LIBRARY: ${LIBZIP_LIBRARY}")
debugMessage("LIBZIP_VERSION_STRING: ${LIBZIP_VERSION_STRING}")

find_package_handle_standard_args(LibZip
    REQUIRED_VARS   LIBZIP_LIBRARY LIBZIP_INCLUDE_DIR
    VERSION_VAR     LIBZIP_VERSION_STRING)

if(LIBZIP_FOUND)
    set(LIBZIP_INCLUDE_DIRS ${LIBZIP_INCLUDE_DIR})
    set(LIBZIP_LIBRARIES ${LIBZIP_LIBRARY})
    
    if(NOT TARGET LibZip::LibZip)
        add_library(LibZip::LibZip UNKNOWN IMPORTED)
        
        set_target_properties(LibZip::LibZip PROPERTIES
            IMPORTED_LOCATION             "${LIBZIP_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBZIP_INCLUDE_DIR}")

        if(ZLIB_FOUND)
            target_link_libraries(LibZip::LibZip INTERFACE ZLIB::ZLIB)
        endif()
        
        if(BZIP2_FOUND)
            target_link_libraries(LibZip::LibZip INTERFACE BZip2::BZip2)
        endif()
        
        if(LIBLZMA_FOUND)
            target_link_libraries(LibZip::LibZip INTERFACE LibLZMA::LibLZMA)
        endif()
        
        if(ZSTD_FOUND)
            target_link_libraries(LibZip::LibZip INTERFACE ZSTD::ZSTD)
        endif()
        
        if(OPENSSL_FOUND)
            target_link_libraries(LibZip::LibZip INTERFACE OpenSSL::Crypto)
        endif()

        if(MINGW)
            target_link_libraries(LibZip::LibZip INTERFACE bcrypt)
        endif()
        
    endif()
endif()
