#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(ZLIB QUIET)
find_package(LibLZMA QUIET)

find_library(MATH_LIBRARY NAMES m)

find_path(LIBXML2_INCLUDE_DIR NAMES libxml/xmlversion.h PATHS "${CPPLIBS_VARIANT_ROOT}/include/libxml2" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(LIBXML2_LIBRARY NAMES xml2 libxml2_a PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(LIBXML2_INCLUDE_DIR LIBXML2_LIBRARY)

if(LIBXML2_INCLUDE_DIR AND EXISTS "${LIBXML2_INCLUDE_DIR}/libxml/xmlversion.h")
    file(STRINGS "${LIBXML2_INCLUDE_DIR}/libxml/xmlversion.h" VERSION_LINE REGEX "^#define LIBXML_DOTTED_VERSION \"[^\"]*\"$")
    string(REGEX REPLACE "^.*LIBXML_DOTTED_VERSION \"([0-9.]+).*$" "\\1" LIBXML2_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("LIBXML2_INCLUDE_DIR: ${LIBXML2_INCLUDE_DIR}")
debugMessage("LIBXML2_LIBRARY: ${LIBXML2_LIBRARY}")
debugMessage("LIBXML2_VERSION_STRING: ${LIBXML2_VERSION_STRING}")
debugMessage("LIBXML2_DEPENDENCIES: ZLIB=${ZLIB_FOUND}, LZMA=${LIBLZMA_FOUND}")

find_package_handle_standard_args(LibXml2
    REQUIRED_VARS   LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR
    VERSION_VAR     LIBXML2_VERSION_STRING)

if(LIBXML2_FOUND)
    set(LIBXML2_INCLUDE_DIRS ${LIBXML2_INCLUDE_DIR})
    set(LIBXML2_LIBRARIES ${LIBXML2_LIBRARY})
    set(LIBXML2_DEFINITIONS "-DLIBXML_STATIC")
    
    if(NOT TARGET LibXml2::LibXml2)
        add_library(LibXml2::LibXml2 UNKNOWN IMPORTED)
        
        set_target_properties(LibXml2::LibXml2 PROPERTIES
            IMPORTED_LOCATION             "${LIBXML2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBXML2_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "LIBXML_STATIC")
        
        if(ZLIB_FOUND)
            target_link_libraries(LibXml2::LibXml2 INTERFACE ZLIB::ZLIB)
            list(APPEND LIBXML2_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
            list(APPEND LIBXML2_LIBRARIES ${ZLIB_LIBRARIES})
        endif()
        
        if(LIBLZMA_FOUND)
            target_link_libraries(LibXml2::LibXml2 INTERFACE LibLZMA::LibLZMA)
            list(APPEND LIBXML2_INCLUDE_DIRS ${LIBLZMA_INCLUDE_DIRS})
            list(APPEND LIBXML2_LIBRARIES ${LIBLZMA_LIBRARIES})
            list(APPEND LIBXML2_DEFINITIONS ${LIBLZMA_DEFINITIONS})
        endif()

        if(MACOS)
            target_link_libraries(LibXml2::LibXml2 INTERFACE iconv)
            list(APPEND LIBXML2_LIBRARIES iconv)
        elseif(IOS)
            target_link_libraries(LibXml2::LibXml2 INTERFACE iconv)
            list(APPEND LIBXML2_LIBRARIES iconv)
        elseif(MINGW)
            target_link_libraries(LibXml2::LibXml2 INTERFACE iconv wsock32 ws2_32)
            list(APPEND LIBXML2_LIBRARIES iconv wsock32 ws2_32)
        endif()

        if(MATH_LIBRARY)
            target_link_libraries(LibXml2::LibXml2 INTERFACE ${MATH_LIBRARY})
            list(APPEND LIBXML2_LIBRARIES ${MATH_LIBRARY})
        endif()
        
    endif()
endif()
