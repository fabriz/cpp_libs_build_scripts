#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2022 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(ARGON2_INCLUDE_DIR NAMES argon2.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ARGON2_LIBRARY NAMES argon2 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ARGON2_INCLUDE_DIR ARGON2_LIBRARY)

set(ARGON2_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("ARGON2_INCLUDE_DIR: ${ARGON2_INCLUDE_DIR}")
debugMessage("ARGON2_LIBRARY: ${ARGON2_LIBRARY}")
debugMessage("ARGON2_VERSION_STRING: ${ARGON2_VERSION_STRING}")

find_package_handle_standard_args(Argon2
    REQUIRED_VARS   ARGON2_LIBRARY ARGON2_INCLUDE_DIR
    VERSION_VAR     ARGON2_VERSION_STRING)

if(ARGON2_FOUND)
    set(ARGON2_INCLUDE_DIRS ${ARGON2_INCLUDE_DIR})
    set(ARGON2_LIBRARIES ${ARGON2_LIBRARY})
    
    if(NOT TARGET Argon2::Argon2)
        add_library(Argon2::Argon2 UNKNOWN IMPORTED)
        
        set_target_properties(Argon2::Argon2 PROPERTIES
            IMPORTED_LOCATION             "${ARGON2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ARGON2_INCLUDE_DIR}")
    endif()
endif()
