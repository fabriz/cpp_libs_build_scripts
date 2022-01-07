#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(JANSSON_INCLUDE_DIR NAMES jansson.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(JANSSON_LIBRARY NAMES jansson PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(JANSSON_INCLUDE_DIR JANSSON_LIBRARY)

if(JANSSON_INCLUDE_DIR AND EXISTS "${JANSSON_INCLUDE_DIR}/jansson.h")
    file(STRINGS "${JANSSON_INCLUDE_DIR}/jansson.h" VERSION_LINE REGEX "^#define JANSSON_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*JANSSON_VERSION \"([0-9.]+).*$" "\\1" JANSSON_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("JANSSON_INCLUDE_DIR: ${JANSSON_INCLUDE_DIR}")
debugMessage("JANSSON_LIBRARY: ${JANSSON_LIBRARY}")
debugMessage("JANSSON_VERSION_STRING: ${JANSSON_VERSION_STRING}")

find_package_handle_standard_args(Jansson
    REQUIRED_VARS   JANSSON_LIBRARY JANSSON_INCLUDE_DIR
    VERSION_VAR     JANSSON_VERSION_STRING)

if(JANSSON_FOUND)
    set(JANSSON_INCLUDE_DIRS ${JANSSON_INCLUDE_DIR})
    set(JANSSON_LIBRARIES ${JANSSON_LIBRARY})
    
    if(NOT TARGET Jansson::Jansson)
        add_library(Jansson::Jansson UNKNOWN IMPORTED)
        
        set_target_properties(Jansson::Jansson PROPERTIES
            IMPORTED_LOCATION             "${JANSSON_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${JANSSON_INCLUDE_DIR}")
    endif()
endif()
