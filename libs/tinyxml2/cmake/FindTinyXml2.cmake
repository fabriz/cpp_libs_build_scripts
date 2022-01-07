#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(TINYXML2_INCLUDE_DIR NAMES tinyxml2.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(TINYXML2_LIBRARY NAMES tinyxml2 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(TINYXML2_INCLUDE_DIR TINYXML2_LIBRARY)

if(TINYXML2_INCLUDE_DIR AND EXISTS "${TINYXML2_INCLUDE_DIR}/tinyxml2.h")
    file(STRINGS "${TINYXML2_INCLUDE_DIR}/tinyxml2.h" MAJOR_VERSION_LINE REGEX "^#define TINYXML2_MAJOR_VERSION.*$")
    file(STRINGS "${TINYXML2_INCLUDE_DIR}/tinyxml2.h" MINOR_VERSION_LINE REGEX "^#define TINYXML2_MINOR_VERSION.*$")
    file(STRINGS "${TINYXML2_INCLUDE_DIR}/tinyxml2.h" PATCH_VERSION_LINE REGEX "^#define TINYXML2_PATCH_VERSION.*$")
    string(REGEX REPLACE "^.*TINYXML2_MAJOR_VERSION +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*TINYXML2_MINOR_VERSION +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*TINYXML2_PATCH_VERSION +([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(TINYXML2_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("TINYXML2_INCLUDE_DIR: ${TINYXML2_INCLUDE_DIR}")
debugMessage("TINYXML2_LIBRARY: ${TINYXML2_LIBRARY}")
debugMessage("TINYXML2_VERSION_STRING: ${TINYXML2_VERSION_STRING}")

find_package_handle_standard_args(TinyXml2
    REQUIRED_VARS   TINYXML2_LIBRARY TINYXML2_INCLUDE_DIR
    VERSION_VAR     TINYXML2_VERSION_STRING)

if(TINYXML2_FOUND)
    set(TINYXML2_INCLUDE_DIRS ${TINYXML2_INCLUDE_DIR})
    set(TINYXML2_LIBRARIES ${TINYXML2_LIBRARY})
    
    if(NOT TARGET TinyXml2::TinyXml2)
        add_library(TinyXml2::TinyXml2 UNKNOWN IMPORTED)
        
        set_target_properties(TinyXml2::TinyXml2 PROPERTIES
            IMPORTED_LOCATION             "${TINYXML2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TINYXML2_INCLUDE_DIR}")
    endif()
endif()
