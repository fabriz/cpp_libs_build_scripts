#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(BOTAN3_INCLUDE_DIR NAMES botan/build.h PATHS "${CPPLIBS_VARIANT_ROOT}/include/botan-3" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(BOTAN3_LIBRARY NAMES botan-3 botan PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(BOTAN3_INCLUDE_DIR BOTAN3_LIBRARY)

if(BOTAN3_INCLUDE_DIR AND EXISTS "${BOTAN3_INCLUDE_DIR}/botan/build.h")
    file(STRINGS "${BOTAN3_INCLUDE_DIR}/botan/build.h" VERSION_LINE REGEX "Build configuration for Botan [0-9.]+")
    string(REGEX REPLACE "^.*Build configuration for Botan ([0-9.]+).*$" "\\1" BOTAN3_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("BOTAN3_INCLUDE_DIR: ${BOTAN3_INCLUDE_DIR}")
debugMessage("BOTAN3_LIBRARY: ${BOTAN3_LIBRARY}")
debugMessage("BOTAN3_VERSION_STRING: ${BOTAN3_VERSION_STRING}")

find_package_handle_standard_args(Botan3
    REQUIRED_VARS   BOTAN3_LIBRARY BOTAN3_INCLUDE_DIR
    VERSION_VAR     BOTAN3_VERSION_STRING)

if(BOTAN3_FOUND)
    set(BOTAN3_INCLUDE_DIRS ${BOTAN3_INCLUDE_DIR})
    set(BOTAN3_LIBRARIES ${BOTAN3_LIBRARY})
    
    if(NOT TARGET Botan3::Botan3)
        add_library(Botan3::Botan3 UNKNOWN IMPORTED)
        
        set_target_properties(Botan3::Botan3 PROPERTIES
            IMPORTED_LOCATION             "${BOTAN3_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BOTAN3_INCLUDE_DIR}")
    endif()
endif()
