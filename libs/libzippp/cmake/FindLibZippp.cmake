#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(LibZip QUIET)
if(NOT LIBZIP_FOUND)
    requiredDependencyMissing("LibZip" LibZippp_FIND_REQUIRED)
    find_package_handle_standard_args(LibZippp REQUIRED_VARS LIBZIP_LIBRARY_MISSING)
    return()
endif()

find_path(LIBZIPPP_INCLUDE_DIR NAMES libzippp.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" "${CPPLIBS_VARIANT_ROOT}/include/libzippp" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBZIPPP_LIBRARY NAMES zippp zippp_static libzippp libzippp_static PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBZIPPP_INCLUDE_DIR LIBZIPPP_LIBRARY)

set(LIBZIPPP_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("LIBZIPPP_INCLUDE_DIR: ${LIBZIPPP_INCLUDE_DIR}")
debugMessage("LIBZIPPP_LIBRARY: ${LIBZIPPP_LIBRARY}")
debugMessage("LIBZIPPP_VERSION_STRING: ${LIBZIPPP_VERSION_STRING}")
debugMessage("LIBZIPPP_DEPENDENCIES: LibZip=${LIBZIP_FOUND}")

find_package_handle_standard_args(LibZippp
    REQUIRED_VARS   LIBZIPPP_LIBRARY LIBZIPPP_INCLUDE_DIR
    VERSION_VAR     LIBZIPPP_VERSION_STRING)

if(LIBZIPPP_FOUND)
    set(LIBZIPPP_INCLUDE_DIRS ${LIBZIPPP_INCLUDE_DIR})
    set(LIBZIPPP_LIBRARIES ${LIBZIPPP_LIBRARY})
    set(LIBZIPPP_DEFINITIONS "")
    
    if(NOT TARGET LibZippp::LibZippp)
        add_library(LibZippp::LibZippp UNKNOWN IMPORTED)
        
        set_target_properties(LibZippp::LibZippp PROPERTIES
            IMPORTED_LOCATION             "${LIBZIPPP_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBZIPPP_INCLUDE_DIR}")
        
        target_link_libraries(LibZippp::LibZippp INTERFACE LibZip::LibZip)
        list(APPEND LIBZIPPP_INCLUDE_DIRS ${LIBZIP_INCLUDE_DIRS})
        list(APPEND LIBZIPPP_LIBRARIES ${LIBZIP_LIBRARIES})
        list(APPEND LIBZIPPP_DEFINITIONS ${LIBZIP_DEFINITIONS})
    endif()
endif()
