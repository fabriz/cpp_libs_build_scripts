#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
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

set(TIFF_COMPONENTS
    TIFF
    TIFFXX)

validate_package_components(TIFF_COMPONENTS TIFF_FIND_COMPONENTS)
check_package_component_items(TIFF REQUIRED_ITEMS TIFF_INCLUDE_DIR TIFF_LIBRARY)
check_package_component_items(TIFFXX REQUIRED_ITEMS TIFF_INCLUDE_DIR TIFFXX_LIBRARY)

find_package_handle_standard_args(TIFF
    REQUIRED_VARS   TIFF_INCLUDE_DIR TIFF_LIBRARY
    VERSION_VAR     TIFF_VERSION_STRING
    HANDLE_COMPONENTS)

if(TIFF_FOUND)
    set(TIFF_INCLUDE_DIRS ${TIFF_INCLUDE_DIR})
    set(TIFF_LIBRARIES ${TIFF_LIBRARY})
    set(TIFFXX_LIBRARIES ${TIFFXX_LIBRARY})
    
    if(TIFF_TIFF_FOUND AND NOT TARGET TIFF::TIFF)
        add_library(TIFF::TIFF UNKNOWN IMPORTED)
        
        set_target_properties(TIFF::TIFF PROPERTIES
            IMPORTED_LOCATION             "${TIFF_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TIFF_INCLUDE_DIR}")
        
        if(ZLIB_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE ZLIB::ZLIB)
        endif()
        
        if(LIBLZMA_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE LibLZMA::LibLZMA)
        endif()
        
        if(ZSTD_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE ZSTD::ZSTD)
        endif()
        
        if(JPEG_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE JPEG::JPEG)
        endif()
        
        if(WEBP_ENCODE_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE WebP::Encode)
        endif()
        
        if(WEBP_DECODE_FOUND)
            target_link_libraries(TIFF::TIFF INTERFACE WebP::Decode)
        endif()
    endif()
    
    if(TIFF_TIFFXX_FOUND AND NOT TARGET TIFF::TIFFXX)
        add_library(TIFF::TIFFXX UNKNOWN IMPORTED)
        
        set_target_properties(TIFF::TIFFXX PROPERTIES
            IMPORTED_LOCATION             "${TIFFXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TIFF_INCLUDE_DIR}")
        
        target_link_libraries(TIFF::TIFFXX INTERFACE TIFF::TIFF)
    endif()
endif()
