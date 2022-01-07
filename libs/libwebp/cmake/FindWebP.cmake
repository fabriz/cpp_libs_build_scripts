#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(WEBP_INCLUDE_DIR NAMES webp/encode.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WEBP_ENCODE_LIBRARY NAMES webp PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WEBP_DECODE_LIBRARY NAMES webpdecoder PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WEBP_MUX_LIBRARY NAMES webpmux PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WEBP_DEMUX_LIBRARY NAMES webpdemux PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(WEBP_INCLUDE_DIR WEBP_ENCODE_LIBRARY WEBP_DECODE_LIBRARY WEBP_MUX_LIBRARY WEBP_DEMUX_LIBRARY)

set(WEBP_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("WEBP_INCLUDE_DIR: ${WEBP_INCLUDE_DIR}")
debugMessage("WEBP_ENCODE_LIBRARY: ${WEBP_ENCODE_LIBRARY}")
debugMessage("WEBP_DECODE_LIBRARY: ${WEBP_DECODE_LIBRARY}")
debugMessage("WEBP_MUX_LIBRARY: ${WEBP_MUX_LIBRARY}")
debugMessage("WEBP_DEMUX_LIBRARY: ${WEBP_DEMUX_LIBRARY}")
debugMessage("WEBP_VERSION_STRING: ${WEBP_VERSION_STRING}")

set(WebP_COMPONENTS
    Encode
    Decode
    Mux
    Demux)

validate_package_components(WebP_COMPONENTS WebP_FIND_COMPONENTS)
check_package_component_items(Encode REQUIRED_ITEMS WEBP_INCLUDE_DIR WEBP_ENCODE_LIBRARY)
check_package_component_items(Decode REQUIRED_ITEMS WEBP_INCLUDE_DIR WEBP_DECODE_LIBRARY)
check_package_component_items(Mux REQUIRED_ITEMS WEBP_INCLUDE_DIR WEBP_MUX_LIBRARY)
check_package_component_items(Demux REQUIRED_ITEMS WEBP_INCLUDE_DIR WEBP_DEMUX_LIBRARY)

find_package_handle_standard_args(WebP
    REQUIRED_VARS       WEBP_INCLUDE_DIR
    VERSION_VAR         WEBP_VERSION_STRING
    HANDLE_COMPONENTS)

if(WEBP_FOUND)
    set(WEBP_INCLUDE_DIRS ${WEBP_INCLUDE_DIR})
    set(WEBP_ENCODE_LIBRARIES ${WEBP_ENCODE_LIBRARY})
    set(WEBP_DECODE_LIBRARIES ${WEBP_DECODE_LIBRARY})
    set(WEBP_MUX_LIBRARIES ${WEBP_MUX_LIBRARY})
    set(WEBP_DEMUX_LIBRARIES ${WEBP_DEMUX_LIBRARY})
    
    if(WEBP_ENCODE_FOUND AND NOT TARGET WebP::Encode)
        add_library(WebP::Encode UNKNOWN IMPORTED)
        
        set_target_properties(WebP::Encode PROPERTIES
            IMPORTED_LOCATION             "${WEBP_ENCODE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WEBP_INCLUDE_DIR}")
    endif()
    
    if(WEBP_DECODE_FOUND AND NOT TARGET WebP::Decode)
        add_library(WebP::Decode UNKNOWN IMPORTED)
        
        set_target_properties(WebP::Decode PROPERTIES
            IMPORTED_LOCATION             "${WEBP_DECODE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WEBP_INCLUDE_DIR}")
    endif()
    
    if(WEBP_MUX_FOUND AND NOT TARGET WebP::Mux)
        add_library(WebP::Mux UNKNOWN IMPORTED)
        
        set_target_properties(WebP::Mux PROPERTIES
            IMPORTED_LOCATION             "${WEBP_MUX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WEBP_INCLUDE_DIR}")
    endif()
    
    if(WEBP_DEMUX_FOUND AND NOT TARGET WebP::Demux)
        add_library(WebP::Demux UNKNOWN IMPORTED)
        
        set_target_properties(WebP::Demux PROPERTIES
            IMPORTED_LOCATION             "${WEBP_DEMUX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WEBP_INCLUDE_DIR}")
    endif()
endif()
