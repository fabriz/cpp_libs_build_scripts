#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(open62541 QUIET)
if(NOT OPEN62541_FOUND)
    requiredDependencyMissing("open62541" open62541pp_FIND_REQUIRED)
    find_package_handle_standard_args(open62541pp REQUIRED_VARS OPEN62541_LIBRARY_MISSING)
    return()
endif()

find_path(OPEN62541PP_INCLUDE_DIR NAMES open62541pp/open62541pp.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OPEN62541PP_LIBRARY NAMES open62541pp PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(OPEN62541PP_INCLUDE_DIR OPEN62541PP_LIBRARY)

set(OPEN62541PP_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("OPEN62541PP_INCLUDE_DIR: ${OPEN62541PP_INCLUDE_DIR}")
debugMessage("OPEN62541PP_LIBRARY: ${OPEN62541PP_LIBRARY}")
debugMessage("OPEN62541PP_VERSION_STRING: ${OPEN62541PP_VERSION_STRING}")
debugMessage("OPEN62541PP_DEPENDENCIES: open62541=${OPEN62541_FOUND}")

find_package_handle_standard_args(open62541pp
    REQUIRED_VARS   OPEN62541PP_LIBRARY OPEN62541PP_INCLUDE_DIR
    VERSION_VAR     OPEN62541PP_VERSION_STRING)

if(OPEN62541PP_FOUND)
    set(OPEN62541PP_INCLUDE_DIRS ${OPEN62541PP_INCLUDE_DIR})
    set(OPEN62541PP_LIBRARIES ${OPEN62541PP_LIBRARY})
    
    if(NOT TARGET open62541pp::open62541pp)
        add_library(open62541pp::open62541pp UNKNOWN IMPORTED)
        
        set_target_properties(open62541pp::open62541pp PROPERTIES
            IMPORTED_LOCATION             "${OPEN62541PP_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OPEN62541PP_INCLUDE_DIR}")
        
        target_link_libraries(open62541pp::open62541pp INTERFACE open62541::open62541)
        list(APPEND OPEN62541PP_INCLUDE_DIRS ${OPEN62541_INCLUDE_DIRS})
        list(APPEND OPEN62541PP_LIBRARIES ${OPEN62541_LIBRARIES})
    endif()
endif()
