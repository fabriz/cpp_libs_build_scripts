#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

# The suffix of the include directory is the library version
file(GLOB OPENJPEG_INCLUDE_SEARCH_PATH "${CPPLIBS_VARIANT_ROOT}/include/openjpeg-*")

find_path(OPENJPEG_INCLUDE_DIR NAMES openjpeg.h PATHS "${OPENJPEG_INCLUDE_SEARCH_PATH}" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(OPENJPEG_LIBRARY NAMES openjp2 PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(OPENJPEG_INCLUDE_DIR OPENJPEG_LIBRARY)

if(OPENJPEG_INCLUDE_DIR AND EXISTS "${OPENJPEG_INCLUDE_DIR}/opj_config.h")
    file(STRINGS "${OPENJPEG_INCLUDE_DIR}/opj_config.h" MAJOR_VERSION_LINE REGEX "^#define OPJ_VERSION_MAJOR.*$")
    file(STRINGS "${OPENJPEG_INCLUDE_DIR}/opj_config.h" MINOR_VERSION_LINE REGEX "^#define OPJ_VERSION_MINOR.*$")
    file(STRINGS "${OPENJPEG_INCLUDE_DIR}/opj_config.h" PATCH_VERSION_LINE REGEX "^#define OPJ_VERSION_BUILD.*$")
    string(REGEX REPLACE "^.*OPJ_VERSION_MAJOR +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*OPJ_VERSION_MINOR +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*OPJ_VERSION_BUILD +([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(OPENJPEG_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("OPENJPEG_INCLUDE_DIR: ${OPENJPEG_INCLUDE_DIR}")
debugMessage("OPENJPEG_LIBRARY: ${OPENJPEG_LIBRARY}")
debugMessage("OPENJPEG_VERSION_STRING: ${OPENJPEG_VERSION_STRING}")

find_package_handle_standard_args(OpenJPEG
    REQUIRED_VARS   OPENJPEG_LIBRARY OPENJPEG_INCLUDE_DIR
    VERSION_VAR     OPENJPEG_VERSION_STRING)

if(OPENJPEG_FOUND)
    set(OPENJPEG_INCLUDE_DIRS ${OPENJPEG_INCLUDE_DIR})
    set(OPENJPEG_LIBRARIES ${OPENJPEG_LIBRARY})
    set(OPENJPEG_DEFINITIONS "-DOPJ_STATIC")
    
    if(NOT TARGET OpenJPEG::OpenJPEG)
        add_library(OpenJPEG::OpenJPEG UNKNOWN IMPORTED)
        
        set_target_properties(OpenJPEG::OpenJPEG PROPERTIES
            IMPORTED_LOCATION             "${OPENJPEG_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${OPENJPEG_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "OPJ_STATIC")
    endif()
endif()
