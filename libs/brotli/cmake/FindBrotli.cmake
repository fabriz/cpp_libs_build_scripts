#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2024 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(BROTLI_INCLUDE_DIR NAMES brotli/port.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BROTLI_COMMON_LIBRARY NAMES brotlicommon libbrotlicommon PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BROTLI_ENCODE_LIBRARY NAMES brotlienc libbrotlienc PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BROTLI_DECODE_LIBRARY NAMES brotlidec libbrotlidec PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(BROTLI_INCLUDE_DIR BROTLI_COMMON_LIBRARY BROTLI_ENCODE_LIBRARY BROTLI_DECODE_LIBRARY)

set(BROTLI_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("BROTLI_INCLUDE_DIR: ${BROTLI_INCLUDE_DIR}")
debugMessage("BROTLI_COMMON_LIBRARY: ${BROTLI_COMMON_LIBRARY}")
debugMessage("BROTLI_ENCODE_LIBRARY: ${BROTLI_ENCODE_LIBRARY}")
debugMessage("BROTLI_DECODE_LIBRARY: ${BROTLI_DECODE_LIBRARY}")
debugMessage("BROTLI_VERSION_STRING: ${BROTLI_VERSION_STRING}")

set(Brotli_COMPONENTS
    Encode
    Decode)

validate_package_components(Brotli_COMPONENTS Brotli_FIND_COMPONENTS)
check_package_component_items(Encode REQUIRED_ITEMS BROTLI_INCLUDE_DIR BROTLI_COMMON_LIBRARY BROTLI_ENCODE_LIBRARY)
check_package_component_items(Decode REQUIRED_ITEMS BROTLI_INCLUDE_DIR BROTLI_COMMON_LIBRARY BROTLI_DECODE_LIBRARY)

find_package_handle_standard_args(Brotli
    REQUIRED_VARS       BROTLI_INCLUDE_DIR
    VERSION_VAR         BROTLI_VERSION_STRING
    HANDLE_COMPONENTS)

if(BROTLI_FOUND)
    set(BROTLI_INCLUDE_DIRS ${BROTLI_INCLUDE_DIR})
    set(BROTLI_ENCODE_LIBRARIES ${BROTLI_ENCODE_LIBRARY})
    set(BROTLI_DECODE_LIBRARIES ${BROTLI_DECODE_LIBRARY})
    
    if(NOT TARGET Brotli::Brotli)
        add_library(Brotli::Brotli INTERFACE IMPORTED)
        target_include_directories(Brotli::Brotli INTERFACE "${BROTLI_INCLUDE_DIR}")
    endif()
    
    if(BROTLI_ENCODE_FOUND AND NOT TARGET Brotli::Encode)
        add_library(Brotli::Encode UNKNOWN IMPORTED)
        
        set_target_properties(Brotli::Encode PROPERTIES
            IMPORTED_LOCATION             "${BROTLI_ENCODE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BROTLI_INCLUDE_DIR}")
        
        if(EXISTS "${BROTLI_COMMON_LIBRARY}")
            target_link_libraries(Brotli::Encode INTERFACE "${BROTLI_COMMON_LIBRARY}")
            list(APPEND BROTLI_ENCODE_LIBRARIES ${BROTLI_COMMON_LIBRARY})
        endif()
    endif()
    
    if(BROTLI_DECODE_FOUND AND NOT TARGET Brotli::Decode)
        add_library(Brotli::Decode UNKNOWN IMPORTED)
        
        set_target_properties(Brotli::Decode PROPERTIES
            IMPORTED_LOCATION             "${BROTLI_DECODE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BROTLI_INCLUDE_DIR}")
        
        if(EXISTS "${BROTLI_COMMON_LIBRARY}")
            target_link_libraries(Brotli::Decode INTERFACE "${BROTLI_COMMON_LIBRARY}")
            list(APPEND BROTLI_DECODE_LIBRARIES ${BROTLI_COMMON_LIBRARY})
        endif()
    endif()
endif()
