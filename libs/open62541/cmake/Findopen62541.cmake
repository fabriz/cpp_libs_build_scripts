#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(OPEN62541_INCLUDE_DIR NAMES open62541/config.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OPEN62541_LIBRARY NAMES open62541 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(OPEN62541_INCLUDE_DIR OPEN62541_LIBRARY)

if(OPEN62541_INCLUDE_DIR AND EXISTS "${OPEN62541_INCLUDE_DIR}/open62541/config.h")
    file(STRINGS "${OPEN62541_INCLUDE_DIR}/open62541/config.h" MAJOR_VERSION_LINE REGEX "^#define UA_OPEN62541_VER_MAJOR.*$")
    file(STRINGS "${OPEN62541_INCLUDE_DIR}/open62541/config.h" MINOR_VERSION_LINE REGEX "^#define UA_OPEN62541_VER_MINOR.*$")
    file(STRINGS "${OPEN62541_INCLUDE_DIR}/open62541/config.h" RELEASE_VERSION_LINE REGEX "^#define UA_OPEN62541_VER_PATCH.*$")
    string(REGEX REPLACE "^.*UA_OPEN62541_VER_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*UA_OPEN62541_VER_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*UA_OPEN62541_VER_PATCH +([0-9]+).*$" "\\1" RELEASE_VERSION_NUMBER "${RELEASE_VERSION_LINE}")
    set(OPEN62541_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${RELEASE_VERSION_NUMBER}")
endif()

debugMessage("OPEN62541_INCLUDE_DIR: ${OPEN62541_INCLUDE_DIR}")
debugMessage("OPEN62541_LIBRARY: ${OPEN62541_LIBRARY}")
debugMessage("OPEN62541_VERSION_STRING: ${OPEN62541_VERSION_STRING}")

find_package_handle_standard_args(open62541
    REQUIRED_VARS   OPEN62541_LIBRARY OPEN62541_INCLUDE_DIR
    VERSION_VAR     OPEN62541_VERSION_STRING)

if(OPEN62541_FOUND)
    set(OPEN62541_INCLUDE_DIRS ${OPEN62541_INCLUDE_DIR})
    set(OPEN62541_LIBRARIES ${OPEN62541_LIBRARY})
    
    if(NOT TARGET open62541::open62541)
        add_library(open62541::open62541 UNKNOWN IMPORTED)
        
        set_target_properties(open62541::open62541 PROPERTIES
            IMPORTED_LOCATION             "${OPEN62541_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OPEN62541_INCLUDE_DIR}")
    endif()
endif()
