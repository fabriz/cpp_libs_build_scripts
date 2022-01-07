#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(SQLITE3_INCLUDE_DIR NAMES sqlite3.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(SQLITE3_LIBRARY NAMES sqlite3 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(SQLITE3_INCLUDE_DIR SQLITE3_LIBRARY)

if(SQLITE3_INCLUDE_DIR AND EXISTS "${SQLITE3_INCLUDE_DIR}/sqlite3.h")
    file(STRINGS "${SQLITE3_INCLUDE_DIR}/sqlite3.h" VERSION_LINE REGEX "^#define SQLITE_VERSION[ ]+\"[^\"]*\"$")
    string(REGEX REPLACE "^#define SQLITE_VERSION[ ]+\"([0-9.]+).*$" "\\1" SQLITE3_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("SQLITE3_INCLUDE_DIR: ${SQLITE3_INCLUDE_DIR}")
debugMessage("SQLITE3_LIBRARY: ${SQLITE3_LIBRARY}")
debugMessage("SQLITE3_VERSION_STRING: ${SQLITE3_VERSION_STRING}")

find_package_handle_standard_args(SQLite3
    REQUIRED_VARS   SQLITE3_LIBRARY SQLITE3_INCLUDE_DIR
    VERSION_VAR     SQLITE3_VERSION_STRING)

if(SQLITE3_FOUND)
    set(SQLITE3_INCLUDE_DIRS ${SQLITE3_INCLUDE_DIR})
    set(SQLITE3_LIBRARIES ${SQLITE3_LIBRARY})
    
    if(NOT TARGET SQLite3::SQLite3)
        add_library(SQLite3::SQLite3 UNKNOWN IMPORTED)
        
        set_target_properties(SQLite3::SQLite3 PROPERTIES
            IMPORTED_LOCATION             "${SQLITE3_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${SQLITE3_INCLUDE_DIR}")
        
        if(CMAKE_DL_LIBS)
            target_link_libraries(SQLite3::SQLite3 INTERFACE ${CMAKE_DL_LIBS})
        endif()
    endif()
endif()
