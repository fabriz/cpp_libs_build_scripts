#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(SQLite3 QUIET)
find_package(Boost QUIET)

find_path(ODB_INCLUDE_DIR NAMES odb/version.hxx PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ODB_ODB_LIBRARY NAMES odb PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ODB_SQLITE_LIBRARY NAMES odb-sqlite PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(ODB_BOOST_LIBRARY NAMES odb-boost PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(ODB_INCLUDE_DIR ODB_ODB_LIBRARY ODB_SQLITE_LIBRARY ODB_BOOST_LIBRARY)

if(ODB_INCLUDE_DIR AND EXISTS "${ODB_INCLUDE_DIR}/odb/version.hxx")
    file(STRINGS "${ODB_INCLUDE_DIR}/odb/version.hxx" VERSION_LINE REGEX "^#define LIBODB_VERSION_STR +\"[^\"]*\"$")
    string(REGEX REPLACE "^.*LIBODB_VERSION_STR +\"([0-9.]+).*$" "\\1" ODB_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("ODB_INCLUDE_DIR: ${ODB_INCLUDE_DIR}")
debugMessage("ODB_ODB_LIBRARY: ${ODB_ODB_LIBRARY}")
debugMessage("ODB_SQLITE_LIBRARY: ${ODB_SQLITE_LIBRARY}")
debugMessage("ODB_BOOST_LIBRARY: ${ODB_BOOST_LIBRARY}")
debugMessage("ODB_VERSION_STRING: ${ODB_VERSION_STRING}")
debugMessage("ODB_DEPENDENCIES: SQLite3=${SQLITE3_FOUND}, Boost=${BOOST_FOUND}")

set(ODB_COMPONENTS
    ODB
    SQLite
    Boost)

validate_package_components(ODB_COMPONENTS ODB_FIND_COMPONENTS)
check_package_component_items(ODB REQUIRED_ITEMS ODB_INCLUDE_DIR ODB_ODB_LIBRARY)
check_package_component_items(SQLite REQUIRED_ITEMS ODB_INCLUDE_DIR ODB_SQLITE_LIBRARY)
check_package_component_items(Boost REQUIRED_ITEMS ODB_INCLUDE_DIR ODB_BOOST_LIBRARY)

find_package_handle_standard_args(ODB
    REQUIRED_VARS       ODB_INCLUDE_DIR
    VERSION_VAR         ODB_VERSION_STRING
    HANDLE_COMPONENTS)

if(ODB_FOUND)
    set(ODB_INCLUDE_DIRS ${ODB_INCLUDE_DIR})
    set(ODB_ODB_LIBRARIES ${ODB_ODB_LIBRARY})
    set(ODB_SQLITE_LIBRARIES ${ODB_SQLITE_LIBRARY})
    set(ODB_BOOST_LIBRARIES ${ODB_BOOST_LIBRARY})

    if(ODB_ODB_FOUND AND NOT TARGET ODB::ODB)
        add_library(ODB::ODB UNKNOWN IMPORTED)
        
        set_target_properties(ODB::ODB PROPERTIES
            IMPORTED_LOCATION             "${ODB_ODB_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ODB_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBODB_STATIC_LIB")
    endif()

    if(ODB_SQLITE_FOUND AND NOT TARGET ODB::SQLite)
        add_library(ODB::SQLite UNKNOWN IMPORTED)
        
        set_target_properties(ODB::SQLite PROPERTIES
            IMPORTED_LOCATION             "${ODB_SQLITE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ODB_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBODB_SQLITE_STATIC_LIB")
        
        if(SQLITE3_FOUND)
            target_link_libraries(ODB::SQLite INTERFACE SQLite3::SQLite3)
        endif()
        
        target_link_libraries(ODB::SQLite INTERFACE ODB::ODB)
    endif()
    
    if(ODB_BOOST_FOUND AND NOT TARGET ODB::Boost)
        add_library(ODB::Boost UNKNOWN IMPORTED)
        
        set_target_properties(ODB::Boost PROPERTIES
            IMPORTED_LOCATION             "${ODB_BOOST_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${ODB_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBODB_BOOST_STATIC_LIB")
        
        if(BOOST_FOUND)
            target_link_libraries(ODB::Boost INTERFACE Boost::boost)
        endif()
        
        target_link_libraries(ODB::Boost INTERFACE ODB::ODB)
    endif()
endif()
