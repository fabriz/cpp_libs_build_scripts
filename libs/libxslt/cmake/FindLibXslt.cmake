#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(LibXml2 QUIET)
if(NOT LIBXML2_FOUND)
    requiredDependencyMissing("LibXml2" LibXslt_FIND_REQUIRED)
    find_package_handle_standard_args(LibXslt REQUIRED_VARS LIBXML2_LIBRARY_MISSING)
    return()
endif()

find_path(LIBXSLT_INCLUDE_DIR NAMES libxslt/xsltconfig.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBXSLT_LIBRARY NAMES xslt libxslt_a PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBXSLT_INCLUDE_DIR LIBXSLT_LIBRARY)

if(LIBXSLT_INCLUDE_DIR AND EXISTS "${LIBXSLT_INCLUDE_DIR}/libxslt/xsltconfig.h")
    file(STRINGS "${LIBXSLT_INCLUDE_DIR}/libxslt/xsltconfig.h" VERSION_LINE REGEX "^#define LIBXSLT_DOTTED_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*LIBXSLT_DOTTED_VERSION \"([0-9.]+).*$" "\\1" LIBXSLT_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("LIBXSLT_INCLUDE_DIR: ${LIBXSLT_INCLUDE_DIR}")
debugMessage("LIBXSLT_LIBRARY: ${LIBXSLT_LIBRARY}")
debugMessage("LIBXSLT_VERSION_STRING: ${LIBXSLT_VERSION_STRING}")

find_package_handle_standard_args(LibXslt
    REQUIRED_VARS   LIBXSLT_LIBRARY LIBXSLT_INCLUDE_DIR
    VERSION_VAR     LIBXSLT_VERSION_STRING)

if(LIBXSLT_FOUND)
    set(LIBXSLT_INCLUDE_DIRS ${LIBXSLT_INCLUDE_DIR})
    set(LIBXSLT_LIBRARIES ${LIBXSLT_LIBRARY})
    
    if(NOT TARGET LibXslt::LibXslt)
        add_library(LibXslt::LibXslt UNKNOWN IMPORTED)
        
        set_target_properties(LibXslt::LibXslt PROPERTIES
            IMPORTED_LOCATION             "${LIBXSLT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBXSLT_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBXSLT_STATIC")
        
        target_link_libraries(LibXslt::LibXslt INTERFACE LibXml2::LibXml2)
    endif()
endif()
