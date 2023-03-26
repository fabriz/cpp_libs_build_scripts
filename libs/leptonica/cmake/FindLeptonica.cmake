#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2023 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(PNG QUIET)
find_package(JPEG QUIET)
find_package(OpenJPEG QUIET)
find_package(TIFF QUIET COMPONENTS TIFF CXX)
find_package(GIF QUIET)
find_package(WebP QUIET COMPONENTS Encode Mux Demux)

find_path(LEPTONICA_INCLUDE_DIR NAMES leptonica/allheaders.h PATHS "${CPPLIBS_VARIANT_ROOT}/include" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LEPTONICA_LIBRARY NAMES leptonica PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LEPTONICA_INCLUDE_DIR LEPTONICA_LIBRARY)

if(LEPTONICA_INCLUDE_DIR AND EXISTS "${LEPTONICA_INCLUDE_DIR}/leptonica/allheaders.h")
    file(STRINGS "${LEPTONICA_INCLUDE_DIR}/leptonica/allheaders.h" MAJOR_VERSION_LINE REGEX "^#define LIBLEPT_MAJOR_VERSION.*$")
    file(STRINGS "${LEPTONICA_INCLUDE_DIR}/leptonica/allheaders.h" MINOR_VERSION_LINE REGEX "^#define LIBLEPT_MINOR_VERSION.*$")
    file(STRINGS "${LEPTONICA_INCLUDE_DIR}/leptonica/allheaders.h" PATCH_VERSION_LINE REGEX "^#define LIBLEPT_PATCH_VERSION.*$")
    string(REGEX REPLACE "^.*LIBLEPT_MAJOR_VERSION +([0-9]+).*$" "\\1" MAJOR_VERSION_NUMBER "${MAJOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*LIBLEPT_MINOR_VERSION +([0-9]+).*$" "\\1" MINOR_VERSION_NUMBER "${MINOR_VERSION_LINE}")
    string(REGEX REPLACE "^.*LIBLEPT_PATCH_VERSION +([0-9]+).*$" "\\1" PATCH_VERSION_NUMBER "${PATCH_VERSION_LINE}")
    set(LEPTONICA_VERSION_STRING "${MAJOR_VERSION_NUMBER}.${MINOR_VERSION_NUMBER}.${PATCH_VERSION_NUMBER}")
endif()

debugMessage("LEPTONICA_INCLUDE_DIR: ${LEPTONICA_INCLUDE_DIR}")
debugMessage("LEPTONICA_LIBRARY: ${LEPTONICA_LIBRARY}")
debugMessage("LEPTONICA_VERSION_STRING: ${LEPTONICA_VERSION_STRING}")
debugMessage("LEPTONICA_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, PNG=${PNG_FOUND}, JPEG=${JPEG_FOUND}, OpenJPEG=${OPENJPEG_FOUND}, TIFF=${TIFF_TIFF_FOUND}, GIF=${GIF_FOUND}, WebP=${WEBP_FOUND}")

find_package_handle_standard_args(Leptonica
    REQUIRED_VARS   LEPTONICA_LIBRARY LEPTONICA_INCLUDE_DIR
    VERSION_VAR     LEPTONICA_VERSION_STRING)

if(LEPTONICA_FOUND)
    set(LEPTONICA_INCLUDE_DIRS ${LEPTONICA_INCLUDE_DIR} ${LEPTONICA_INCLUDE_DIR}/leptonica)
    set(LEPTONICA_LIBRARIES ${LEPTONICA_LIBRARY})
    
    if(NOT TARGET Leptonica::Leptonica)
        add_library(Leptonica::Leptonica UNKNOWN IMPORTED)
        
        set_target_properties(Leptonica::Leptonica PROPERTIES
            IMPORTED_LOCATION             "${LEPTONICA_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LEPTONICA_INCLUDE_DIR}")
        
        if(ZLIB_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE ZLIB::ZLIB)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        if(PNG_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE PNG::PNG)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${PNG_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${PNG_LIBRARIES})
        endif()

        if(JPEG_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE JPEG::JPEG)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${JPEG_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${JPEG_LIBRARIES})
        endif()
        
        if(OPENJPEG_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE OpenJPEG::OpenJPEG)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${OPENJPEG_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${OPENJPEG_LIBRARIES})
        endif()

        if(TIFF_TIFF_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE TIFF::TIFF)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${TIFF_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${TIFF_LIBRARIES})
        endif()

        if(TIFF_CXX_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE TIFF::CXX)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${TIFF_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${TIFFXX_LIBRARIES})
        endif()
        
        if(GIF_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE GIF::GIF)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${GIF_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${GIF_LIBRARIES})
        endif()
        
        if(WEBP_ENCODE_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE WebP::Encode)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${WEBP_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${WEBP_ENCODE_LIBRARIES})
        endif()
        
        if(WEBP_MUX_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE WebP::Mux)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${WEBP_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${WEBP_MUX_LIBRARIES})
        endif()
        
        if(WEBP_DEMUX_FOUND)
            target_link_libraries(Leptonica::Leptonica INTERFACE WebP::Demux)
            list(APPEND LEPTONICA_INCLUDE_DIRS ${WEBP_INCLUDE_DIRS})
            list(APPEND LEPTONICA_LIBRARIES ${WEBP_DEMUX_LIBRARIES})
        endif()
    endif()
    
    set(Leptonica_INCLUDE_DIRS ${LEPTONICA_INCLUDE_DIRS})
    set(Leptonica_LIBRARIES ${LEPTONICA_LIBRARIES})
    set(Leptonica_VERSION_STRING ${LEPTONICA_VERSION_STRING})
    
endif()
