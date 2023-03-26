#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(SQLite3 QUIET)
find_package(OpenSSL QUIET)
find_package(Boost QUIET COMPONENTS filesystem thread program_options)

if(NOT BOOST_FILESYSTEM_FOUND)
    requiredDependencyMissing("Boost::filesystem" Wt_FIND_REQUIRED)
    find_package_handle_standard_args(Wt REQUIRED_VARS BOOST_FILESYSTEM_LIBRARY_MISSING)
    return()
endif()

if(NOT BOOST_THREAD_FOUND)
    requiredDependencyMissing("Boost::thread" Wt_FIND_REQUIRED)
    find_package_handle_standard_args(Wt REQUIRED_VARS BOOST_THREAD_LIBRARY_MISSING)
    return()
endif()

if(NOT BOOST_PROGRAM_OPTIONS_FOUND)
    requiredDependencyMissing("Boost::program_options" Wt_FIND_REQUIRED)
    find_package_handle_standard_args(Wt REQUIRED_VARS BOOST_PROGRAM_OPTIONS_LIBRARY_MISSING)
    return()
endif()

find_path(WT_INCLUDE_DIR NAMES Wt/WConfig.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WT_WT_LIBRARY NAMES wt PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WT_HTTP_LIBRARY NAMES wthttp PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WT_DBO_LIBRARY NAMES wtdbo PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(WT_SQLITE_LIBRARY NAMES wtdbosqlite3 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(WT_INCLUDE_DIR WT_WT_LIBRARY WT_HTTP_LIBRARY WT_DBO_LIBRARY WT_SQLITE_LIBRARY)

if(WT_INCLUDE_DIR AND EXISTS "${WT_INCLUDE_DIR}/Wt/WConfig.h")
    file(STRINGS "${WT_INCLUDE_DIR}/Wt/WConfig.h" VERSION_LINE REGEX "^#define WT_VERSION_STR +\"[^\"]*\"$")
    string(REGEX REPLACE "^.*WT_VERSION_STR +\"([0-9.]+).*$" "\\1" WT_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("WT_INCLUDE_DIR: ${WT_INCLUDE_DIR}")
debugMessage("WT_WT_LIBRARY: ${WT_WT_LIBRARY}")
debugMessage("WT_HTTP_LIBRARY: ${WT_HTTP_LIBRARY}")
debugMessage("WT_DBO_LIBRARY: ${WT_DBO_LIBRARY}")
debugMessage("WT_SQLITE_LIBRARY: ${WT_SQLITE_LIBRARY}")
debugMessage("WT_VERSION_STRING: ${WT_VERSION_STRING}")
debugMessage("WT_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, SQLite3=${SQLITE3_FOUND}, OpenSSL=${OPENSSL_FOUND}, Boost=${BOOST_FOUND}")

set(Wt_COMPONENTS
    Wt
    Http
    Dbo
    SQLite)

validate_package_components(Wt_COMPONENTS Wt_FIND_COMPONENTS)
check_package_component_items(Wt REQUIRED_ITEMS WT_INCLUDE_DIR WT_WT_LIBRARY)
check_package_component_items(Http REQUIRED_ITEMS WT_INCLUDE_DIR WT_HTTP_LIBRARY)
check_package_component_items(Dbo REQUIRED_ITEMS WT_INCLUDE_DIR WT_DBO_LIBRARY)
check_package_component_items(SQLite REQUIRED_ITEMS WT_INCLUDE_DIR WT_SQLITE_LIBRARY)

find_package_handle_standard_args(Wt
    REQUIRED_VARS       WT_INCLUDE_DIR
    VERSION_VAR         WT_VERSION_STRING
    HANDLE_COMPONENTS)

if(WT_FOUND)
    set(WT_INCLUDE_DIRS ${WT_INCLUDE_DIR})
    set(WT_WT_LIBRARIES ${WT_WT_LIBRARY})
    set(WT_HTTP_LIBRARIES ${WT_HTTP_LIBRARY})
    set(WT_DBO_LIBRARIES ${WT_DBO_LIBRARY})
    set(WT_SQLITE_LIBRARIES ${WT_SQLITE_LIBRARY})

    if(WT_WT_FOUND AND NOT TARGET Wt::Wt)
        add_library(Wt::Wt UNKNOWN IMPORTED)
        
        set_target_properties(Wt::Wt PROPERTIES
            IMPORTED_LOCATION             "${WT_WT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WT_INCLUDE_DIR}")

        if(OPENSSL_SSL_FOUND)
            target_link_libraries(Wt::Wt INTERFACE OpenSSL::SSL)
        endif()
        
        if(BOOST_FOUND)
            target_link_libraries(Wt::Wt INTERFACE Boost::boost)
        endif()
        
        if (BOOST_FILESYSTEM_FOUND)
            target_link_libraries(Wt::Wt INTERFACE Boost::filesystem)
        endif()
            
        if(BOOST_THREAD_FOUND)
            target_link_libraries(Wt::Wt INTERFACE Boost::thread)
        endif()
    endif()
    
    if(WT_HTTP_FOUND AND NOT TARGET Wt::Http)
        add_library(Wt::Http UNKNOWN IMPORTED)
        
        set_target_properties(Wt::Http PROPERTIES
            IMPORTED_LOCATION             "${WT_HTTP_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WT_INCLUDE_DIR}")
    
        if(ZLIB_FOUND)
            target_link_libraries(Wt::Http INTERFACE ZLIB::ZLIB)
        endif()
        
        if (BOOST_PROGRAM_OPTIONS_FOUND)
            target_link_libraries(Wt::Http INTERFACE Boost::program_options)
        endif()
        
        target_link_libraries(Wt::Http INTERFACE Wt::Wt)
    endif()

    if(WT_DBO_FOUND AND NOT TARGET Wt::Dbo)
        add_library(Wt::Dbo UNKNOWN IMPORTED)
        
        set_target_properties(Wt::Dbo PROPERTIES
            IMPORTED_LOCATION             "${WT_DBO_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WT_INCLUDE_DIR}")
        
        if(BOOST_FOUND)
            target_link_libraries(Wt::Wt INTERFACE Boost::boost)
        endif()
    endif()

    if(WT_SQLITE_FOUND AND NOT TARGET Wt::SQLite)
        add_library(Wt::SQLite UNKNOWN IMPORTED)
        
        set_target_properties(Wt::SQLite PROPERTIES
            IMPORTED_LOCATION             "${WT_SQLITE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${WT_INCLUDE_DIR}")
        
        if(SQLITE3_FOUND)
            target_link_libraries(Wt::SQLite INTERFACE SQLite3::SQLite3)
        endif()
        
        target_link_libraries(Wt::SQLite INTERFACE Wt::Dbo)
    endif()
endif()
