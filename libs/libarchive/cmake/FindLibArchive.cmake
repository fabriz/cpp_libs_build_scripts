#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
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
find_package(LibXml2 QUIET)

find_path(LIBARCHIVE_INCLUDE_DIR NAMES archive.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBARCHIVE_LIBRARY NAMES archive archive_static PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBARCHIVE_INCLUDE_DIR LIBARCHIVE_LIBRARY)

if(LIBARCHIVE_INCLUDE_DIR AND EXISTS "${LIBARCHIVE_INCLUDE_DIR}/archive.h")
    file(STRINGS "${LIBARCHIVE_INCLUDE_DIR}/archive.h" VERSION_LINE REGEX "^#define[ \t]+ARCHIVE_VERSION_ONLY_STRING \"[^\"]*\"$")
    string(REGEX REPLACE "^.*ARCHIVE_VERSION_ONLY_STRING \"([0-9.]+).*$" "\\1" LIBARCHIVE_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("LIBARCHIVE_INCLUDE_DIR: ${LIBARCHIVE_INCLUDE_DIR}")
debugMessage("LIBARCHIVE_LIBRARY: ${LIBARCHIVE_LIBRARY}")
debugMessage("LIBARCHIVE_VERSION_STRING: ${LIBARCHIVE_VERSION_STRING}")
debugMessage("LIBARCHIVE_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, BZip2=${BZIP2_FOUND}, LZMA=${LIBLZMA_FOUND}, ZSTD=${ZSTD_FOUND}, OpenSSL=${OPENSSL_FOUND}, LibXml2=${LIBXML2_FOUND}")

find_package_handle_standard_args(LibArchive
    REQUIRED_VARS   LIBARCHIVE_LIBRARY LIBARCHIVE_INCLUDE_DIR
    VERSION_VAR     LIBARCHIVE_VERSION_STRING)

if(LIBARCHIVE_FOUND)
    set(LIBARCHIVE_INCLUDE_DIRS ${LIBARCHIVE_INCLUDE_DIR})
    set(LIBARCHIVE_LIBRARIES ${LIBARCHIVE_LIBRARY})
    set(LIBARCHIVE_VERSION ${LIBARCHIVE_VERSION_STRING})
    set(LIBARCHIVE_DEFINITIONS "-DLIBARCHIVE_STATIC")
    
    if(NOT TARGET LibArchive::LibArchive)
        add_library(LibArchive::LibArchive UNKNOWN IMPORTED)
        
        set_target_properties(LibArchive::LibArchive PROPERTIES
            IMPORTED_LOCATION             "${LIBARCHIVE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBARCHIVE_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBARCHIVE_STATIC")
            
        if(ZLIB_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE ZLIB::ZLIB)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        if(BZIP2_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE BZip2::BZip2)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${BZIP2_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${BZIP2_LIBRARIES})
        endif()
        
        if(LIBLZMA_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE LibLZMA::LibLZMA)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${LIBLZMA_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${LIBLZMA_LIBRARIES})
            list(APPEND LIBARCHIVE_DEFINITIONS ${LIBLZMA_DEFINITIONS})
        endif()
        
        if(ZSTD_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE ZSTD::ZSTD)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${ZSTD_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${ZSTD_LIBRARIES})
        endif()
        
        if(OPENSSL_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE OpenSSL::Crypto)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${OPENSSL_CRYPTO_LIBRARIES})
        endif()
        
        if(LIBXML2_FOUND)
            target_link_libraries(LibArchive::LibArchive INTERFACE LibXml2::LibXml2)
            list(APPEND LIBARCHIVE_INCLUDE_DIRS ${LIBXML2_INCLUDE_DIRS})
            list(APPEND LIBARCHIVE_LIBRARIES ${LIBXML2_LIBRARIES})
            list(APPEND LIBARCHIVE_DEFINITIONS ${LIBXML2_DEFINITIONS})
        endif()
        
        if(MINGW)
            target_link_libraries(LibArchive::LibArchive INTERFACE bcrypt)
            list(APPEND LIBARCHIVE_LIBRARIES bcrypt)
        endif()

    endif()
    
    set(LibArchive_INCLUDE_DIRS ${LIBARCHIVE_INCLUDE_DIRS})
    set(LibArchive_LIBRARIES ${LIBARCHIVE_LIBRARIES})
    set(LibArchive_VERSION ${LIBARCHIVE_VERSION})
    set(LibArchive_DEFINITIONS ${LIBARCHIVE_DEFINITIONS})
endif()
