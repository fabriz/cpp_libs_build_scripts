#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(UTF8CPP_INCLUDE_DIR NAMES utf8cpp/utf8.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(UTF8CPP_INCLUDE_DIR)

set(UTF8CPP_VERSION_STRING ${CPPLIBS_LIBRARY_KNOWN_VERSION})

debugMessage("UTF8CPP_INCLUDE_DIR: ${UTF8CPP_INCLUDE_DIR}")
debugMessage("UTF8CPP_VERSION_STRING: ${UTF8CPP_VERSION_STRING}")

find_package_handle_standard_args(Utf8Cpp
    REQUIRED_VARS   UTF8CPP_INCLUDE_DIR
    VERSION_VAR     UTF8CPP_VERSION_STRING)

if(UTF8CPP_FOUND)
    set(UTF8CPP_INCLUDE_DIRS ${UTF8CPP_INCLUDE_DIR})
    
    if(NOT TARGET Utf8Cpp::Utf8Cpp)
        add_library(Utf8Cpp::Utf8Cpp INTERFACE IMPORTED)
        target_include_directories(Utf8Cpp::Utf8Cpp INTERFACE "${UTF8CPP_INCLUDE_DIR}")
    endif()
endif()
