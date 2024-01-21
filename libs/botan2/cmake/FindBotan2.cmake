#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(BOTAN2_INCLUDE_DIR NAMES botan/botan.h PATHS "${CPPLIBS_VARIANT_ROOT}/include/botan-2" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOTAN2_LIBRARY NAMES botan-2 botan PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(BOTAN2_INCLUDE_DIR BOTAN2_LIBRARY)

if(BOTAN2_INCLUDE_DIR AND EXISTS "${BOTAN2_INCLUDE_DIR}/botan/build.h")
    file(STRINGS "${BOTAN2_INCLUDE_DIR}/botan/build.h" VERSION_LINE REGEX "Build configuration for Botan [0-9.]+")
    string(REGEX REPLACE "^.*Build configuration for Botan ([0-9.]+).*$" "\\1" BOTAN2_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("BOTAN2_INCLUDE_DIR: ${BOTAN2_INCLUDE_DIR}")
debugMessage("BOTAN2_LIBRARY: ${BOTAN2_LIBRARY}")
debugMessage("BOTAN2_VERSION_STRING: ${BOTAN2_VERSION_STRING}")

find_package_handle_standard_args(Botan2
    REQUIRED_VARS   BOTAN2_LIBRARY BOTAN2_INCLUDE_DIR
    VERSION_VAR     BOTAN2_VERSION_STRING)

if(BOTAN2_FOUND)
    set(BOTAN2_INCLUDE_DIRS ${BOTAN2_INCLUDE_DIR})
    set(BOTAN2_LIBRARIES ${BOTAN2_LIBRARY})
    
    if(NOT TARGET Botan2::Botan2)
        add_library(Botan2::Botan2 UNKNOWN IMPORTED)
        
        set_target_properties(Botan2::Botan2 PROPERTIES
            IMPORTED_LOCATION             "${BOTAN2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOTAN2_INCLUDE_DIR}")
    endif()
endif()
