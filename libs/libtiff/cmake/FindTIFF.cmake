#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(Deflate QUIET)
find_package(LibLZMA QUIET)
find_package(ZSTD QUIET)
find_package(JPEG QUIET)
find_package(WebP QUIET COMPONENTS Encode Decode)

find_path(TIFF_INCLUDE_DIR NAMES tiff.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(TIFF_LIBRARY NAMES tiff PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(TIFFXX_LIBRARY NAMES tiffxx PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(TIFF_INCLUDE_DIR TIFF_LIBRARY TIFFXX_LIBRARY)

if(TIFF_INCLUDE_DIR AND EXISTS "${TIFF_INCLUDE_DIR}/tiffvers.h")
    file(STRINGS "${TIFF_INCLUDE_DIR}/tiffvers.h" VERSION_LINE REGEX "^#define TIFFLIB_VERSION_STR .*$")
    string(REGEX REPLACE "^.*LIBTIFF, Version ([0-9.]+).*$" "\\1" TIFF_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("TIFF_INCLUDE_DIR: ${TIFF_INCLUDE_DIR}")
debugMessage("TIFF_LIBRARY: ${TIFF_LIBRARY}")
debugMessage("TIFFXX_LIBRARY: ${TIFFXX_LIBRARY}")
debugMessage("TIFF_VERSION_STRING: ${TIFF_VERSION_STRING}")
debugMessage("TIFF_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, Deflate=${DEFLATE_FOUND}, LibLZMA=${LIBLZMA_FOUND}, ZSTD=${ZSTD_FOUND}, JPEG=${JPEG_FOUND}, WebP=${WEBP_FOUND}")

set(TIFF_COMPONENTS
    TIFF
    CXX)

validate_package_components(TIFF_COMPONENTS TIFF_FIND_COMPONENTS)
check_package_component_items(TIFF REQUIRED_ITEMS TIFF_INCLUDE_DIR TIFF_LIBRARY)
check_package_component_items(CXX REQUIRED_ITEMS TIFF_INCLUDE_DIR TIFFXX_LIBRARY)

find_package_handle_standard_args(TIFF
    REQUIRED_VARS   TIFF_INCLUDE_DIR TIFF_LIBRARY
    VERSION_VAR     TIFF_VERSION_STRING
    HANDLE_COMPONENTS)

if(TIFF_FOUND)
    set(TIFF_INCLUDE_DIRS ${TIFF_INCLUDE_DIR})
    set(TIFF_LIBRARIES ${TIFF_LIBRARY})
    set(TIFF_DEFINITIONS "")
    set(TIFFXX_LIBRARIES ${TIFFXX_LIBRARY})
    
    if(TIFF_TIFF_FOUND AND NOT TARGET TIFF::TIFF)
        add_library(TIFF::TIFF UNKNOWN IMPORTED)
        
        set_target_properties(TIFF::TIFF PROPERTIES
            IMPORTED_LOCATION             "${TIFF_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TIFF_INCLUDE_DIR}")
        
        if(ZLIB_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE ZLIB::ZLIB)
            list(APPEND TIFF_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        if(DEFLATE_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE Deflate::Deflate)
            list(APPEND TIFF_INCLUDE_DIRS ${DEFLATE_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${DEFLATE_LIBRARIES})
        endif()
        
        if(LIBLZMA_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE LibLZMA::LibLZMA)
            list(APPEND TIFF_INCLUDE_DIRS ${LIBLZMA_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${LIBLZMA_LIBRARIES})
            list(APPEND TIFF_DEFINITIONS ${LIBLZMA_DEFINITIONS})
        endif()
        
        if(ZSTD_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE ZSTD::ZSTD)
            list(APPEND TIFF_INCLUDE_DIRS ${ZSTD_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${ZSTD_LIBRARIES})
        endif()
        
        if(JPEG_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE JPEG::JPEG)
            list(APPEND TIFF_INCLUDE_DIRS ${JPEG_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${JPEG_LIBRARIES})
        endif()
        
        if(WEBP_ENCODE_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE WebP::Encode)
            list(APPEND TIFF_INCLUDE_DIRS ${WEBP_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${WEBP_ENCODE_LIBRARIES})
        endif()
        
        if(WEBP_DECODE_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE WebP::Decode)
            list(APPEND TIFF_INCLUDE_DIRS ${WEBP_INCLUDE_DIRS})
            list(APPEND TIFF_LIBRARIES ${WEBP_DECODE_LIBRARIES})
        endif()
    endif()
    
    if(TIFF_CXX_FOUND AND NOT TARGET TIFF::CXX)
        add_library(TIFF::CXX UNKNOWN IMPORTED)
        
        set_target_properties(TIFF::CXX PROPERTIES
            IMPORTED_LOCATION             "${TIFFXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TIFF_INCLUDE_DIR}")
        
        target_link_libraries(TIFF::CXX INTERFACE TIFF::TIFF)
    endif()
endif()
