#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_path(GIF_INCLUDE_DIR NAMES gif_lib.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(GIF_LIBRARY NAMES gif libgif PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(GIF_INCLUDE_DIR GIF_LIBRARY)

if(GIF_INCLUDE_DIR AND EXISTS "${GIF_INCLUDE_DIR}/gif_lib.h")
    file(STRINGS "${GIF_INCLUDE_DIR}/gif_lib.h" MAJOR_VERSION_LINE REGEX "^#define GIFLIB_MAJOR.*$")
    file(STRINGS "${GIF_INCLUDE_DIR}/gif_lib.h" MINOR_VERSION_LINE REGEX "^#define GIFLIB_MINOR.*$")
    file(STRINGS "${GIF_INCLUDE_DIR}/gif_lib.h" PATCH_VERSION_LINE REGEX "^#define GIFLIB_RELEASE.*$")
    string(REGEX REPLACE "^.*GIFLIB_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*GIFLIB_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*GIFLIB_RELEASE +([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(GIF_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("GIF_INCLUDE_DIR: ${GIF_INCLUDE_DIR}")
debugMessage("GIF_LIBRARY: ${GIF_LIBRARY}")
debugMessage("GIF_VERSION_STRING: ${GIF_VERSION_STRING}")

find_package_handle_standard_args(GIF
    REQUIRED_VARS   GIF_LIBRARY GIF_INCLUDE_DIR
    VERSION_VAR     GIF_VERSION_STRING)

if(GIF_FOUND)
    set(GIF_INCLUDE_DIRS ${GIF_INCLUDE_DIR})
    set(GIF_LIBRARIES ${GIF_LIBRARY})
    set(GIF_VERSION ${GIF_VERSION_STRING})
    
    if(NOT TARGET GIF::GIF)
        add_library(GIF::GIF UNKNOWN IMPORTED)
        
        set_target_properties(GIF::GIF PROPERTIES
            IMPORTED_LOCATION             "${GIF_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${GIF_INCLUDE_DIR}")
    endif()
endif()
