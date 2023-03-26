#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(LibArchive QUIET)
find_package(CURL QUIET)
find_package(Leptonica QUIET)

find_package(Leptonica QUIET)
if(NOT LEPTONICA_FOUND)
    requiredDependencyMissing("Leptonica" Tesseract_FIND_REQUIRED)
    find_package_handle_standard_args(Tesseract REQUIRED_VARS LEPTONICA_LIBRARY_MISSING)
    return()
endif()

find_path(TESSERACT_INCLUDE_DIR NAMES tesseract/version.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(TESSERACT_LIBRARY NAMES tesseract PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(TESSERACT_INCLUDE_DIR TESSERACT_LIBRARY)

if(TESSERACT_INCLUDE_DIR AND EXISTS "${TESSERACT_INCLUDE_DIR}/tesseract/version.h")
    file(STRINGS "${TESSERACT_INCLUDE_DIR}/tesseract/version.h" VERSION_LINE REGEX "^#define TESSERACT_VERSION_STR \"[^\"]*\"$")
    string(REGEX REPLACE "^.*TESSERACT_VERSION_STR \"([0-9.]+).*$" "\\1" TESSERACT_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("TESSERACT_INCLUDE_DIR: ${TESSERACT_INCLUDE_DIR}")
debugMessage("TESSERACT_LIBRARY: ${TESSERACT_LIBRARY}")
debugMessage("TESSERACT_VERSION_STRING: ${TESSERACT_VERSION_STRING}")
debugMessage("TESSERACT_DEPENDENCIES: LibArchive=${LIBARCHIVE_FOUND}, CURL=${CURL_FOUND}, Leptonica=${LEPTONICA_FOUND}")

find_package_handle_standard_args(Tesseract
    REQUIRED_VARS   TESSERACT_LIBRARY TESSERACT_INCLUDE_DIR
    VERSION_VAR     TESSERACT_VERSION_STRING)

if(TESSERACT_FOUND)
    set(TESSERACT_INCLUDE_DIRS ${TESSERACT_INCLUDE_DIR})
    set(TESSERACT_LIBRARIES ${TESSERACT_LIBRARY})
    
    if(NOT TARGET Tesseract::Tesseract)
        add_library(Tesseract::Tesseract UNKNOWN IMPORTED)
        
        set_target_properties(Tesseract::Tesseract PROPERTIES
            IMPORTED_LOCATION             "${TESSERACT_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${TESSERACT_INCLUDE_DIR}")
    endif()
    
    if(LIBARCHIVE_FOUND)
        target_link_libraries(Tesseract::Tesseract INTERFACE LibArchive::LibArchive)
        list(APPEND TESSERACT_INCLUDE_DIRS ${LIBARCHIVE_INCLUDE_DIRS})
        list(APPEND TESSERACT_LIBRARIES ${LIBARCHIVE_LIBRARIES})
    endif()
    
    if(CURL_FOUND)
        target_link_libraries(Tesseract::Tesseract INTERFACE CURL::libcurl)
        list(APPEND TESSERACT_INCLUDE_DIRS ${CURL_INCLUDE_DIRS})
        list(APPEND TESSERACT_LIBRARIES ${CURL_LIBRARIES})
    endif()

    target_link_libraries(Tesseract::Tesseract INTERFACE Leptonica::Leptonica)
    list(APPEND TESSERACT_INCLUDE_DIRS ${LEPTONICA_INCLUDE_DIRS})
    list(APPEND TESSERACT_LIBRARIES ${LEPTONICA_LIBRARIES})
    
    set(Tesseract_INCLUDE_DIRS ${TESSERACT_INCLUDE_DIR})
    set(Tesseract_LIBRARIES ${TESSERACT_LIBRARY})
    set(Tesseract_VERSION_STRING ${TESSERACT_VERSION_STRING})
endif()
