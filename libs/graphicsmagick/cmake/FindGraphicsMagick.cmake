#-----------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2021 Fabrizio Maj
#
# This file is part of the cpp_libs_build_scripts project, which is distributed under the MIT license.
# Refer to the licenses of the managed libraries for conditions on their use and distribution.
# For details, see https://github.com/fabriz/cpp_libs_build_scripts
#-----------------------------------------------------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/CppLibsCommon.cmake)

find_package(X11 QUIET)
find_package(ZLIB QUIET)
find_package(BZip2 QUIET)
find_package(LibXml2 QUIET)
find_package(PNG QUIET)
find_package(JPEG QUIET)
find_package(WebP QUIET COMPONENTS Encode Mux)
find_package(TIFF QUIET COMPONENTS TIFF)

find_path(GRAPHICSMAGICK_INCLUDE_DIR NAMES magick/magick.h PATHS "${CPPLIBS_VARIANT_ROOT}/include/GraphicsMagick" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(GRAPHICSMAGICK_MAGICK_LIBRARY NAMES GraphicsMagick PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(GRAPHICSMAGICK_MAGICKWAND_LIBRARY NAMES GraphicsMagickWand PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
find_library(GRAPHICSMAGICK_MAGICKXX_LIBRARY NAMES GraphicsMagick++ PATHS "${CPPLIBS_VARIANT_ROOT}/lib" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(GRAPHICSMAGICK_INCLUDE_DIR GRAPHICSMAGICK_MAGICK_LIBRARY GRAPHICSMAGICK_MAGICKWAND_LIBRARY GRAPHICSMAGICK_MAGICKXX_LIBRARY)

if(GRAPHICSMAGICK_INCLUDE_DIR AND EXISTS "${GRAPHICSMAGICK_INCLUDE_DIR}/magick/version.h")
    file(STRINGS "${GRAPHICSMAGICK_INCLUDE_DIR}/magick/version.h" VERSION_LINE REGEX "^#define MagickLibVersionText +\"[^\"]*\"$")
    string(REGEX REPLACE "^.*MagickLibVersionText +\"([0-9.]+).*$" "\\1" GRAPHICSMAGICK_VERSION_STRING "${VERSION_LINE}")
endif()

debugMessage("GRAPHICSMAGICK_INCLUDE_DIR: ${GRAPHICSMAGICK_INCLUDE_DIR}")
debugMessage("GRAPHICSMAGICK_MAGICK_LIBRARY: ${GRAPHICSMAGICK_MAGICK_LIBRARY}")
debugMessage("GRAPHICSMAGICK_MAGICKWAND_LIBRARY: ${GRAPHICSMAGICK_MAGICKWAND_LIBRARY}")
debugMessage("GRAPHICSMAGICK_MAGICKXX_LIBRARY: ${GRAPHICSMAGICK_MAGICKXX_LIBRARY}")
debugMessage("GRAPHICSMAGICK_VERSION_STRING: ${GRAPHICSMAGICK_VERSION_STRING}")

set(GraphicsMagick_COMPONENTS
    Magick
    MagickWand
    MagickXX)

validate_package_components(GraphicsMagick_COMPONENTS GraphicsMagick_FIND_COMPONENTS)
check_package_component_items(Magick REQUIRED_ITEMS GRAPHICSMAGICK_INCLUDE_DIR GRAPHICSMAGICK_MAGICK_LIBRARY)
check_package_component_items(MagickWand REQUIRED_ITEMS GRAPHICSMAGICK_INCLUDE_DIR GRAPHICSMAGICK_MAGICKWAND_LIBRARY)
check_package_component_items(MagickXX REQUIRED_ITEMS GRAPHICSMAGICK_INCLUDE_DIR GRAPHICSMAGICK_MAGICKXX_LIBRARY)

find_package_handle_standard_args(GraphicsMagick
    REQUIRED_VARS       GRAPHICSMAGICK_INCLUDE_DIR
    VERSION_VAR         GRAPHICSMAGICK_VERSION_STRING
    HANDLE_COMPONENTS)

if(GRAPHICSMAGICK_FOUND)
    set(GRAPHICSMAGICK_INCLUDE_DIRS ${GRAPHICSMAGICK_INCLUDE_DIR})
    set(GRAPHICSMAGICK_MAGICK_LIBRARIES ${GRAPHICSMAGICK_MAGICK_LIBRARY})
    set(GRAPHICSMAGICK_MAGICKWAND_LIBRARIES ${GRAPHICSMAGICK_MAGICKWAND_LIBRARY})
    set(GRAPHICSMAGICK_MAGICKXX_LIBRARIES ${GRAPHICSMAGICK_MAGICKXX_LIBRARY})

    if(GRAPHICSMAGICK_MAGICK_FOUND AND NOT TARGET GraphicsMagick::Magick)
        add_library(GraphicsMagick::Magick UNKNOWN IMPORTED)
        
        set_target_properties(GraphicsMagick::Magick PROPERTIES
            IMPORTED_LOCATION             "${GRAPHICSMAGICK_MAGICK_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${GRAPHICSMAGICK_INCLUDE_DIR}"
            INTERFACE_COMPILE_DEFINITIONS "_LIB")

        if(X11_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE X11::X11 X11::Xext)
        endif()
        
        if(ZLIB_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE ZLIB::ZLIB)
        endif()
        
        if(BZIP2_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE BZip2::BZip2)
        endif()
        
        if(LIBXML2_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE LibXml2::LibXml2)
        endif()
        
        if(PNG_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE PNG::PNG)
        endif()
        
        if(JPEG_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE JPEG::JPEG)
        endif()
        
        if(WEBP_ENCODE_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE WebP::Encode)
        endif()
        
        if(WEBP_MUX_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE WebP::Mux)
        endif()
        
        if(TIFF_TIFF_FOUND)
            target_link_libraries(GraphicsMagick::Magick INTERFACE TIFF::TIFF)
        endif()
        
        if(LINUX OR MINGW)
            target_link_libraries(GraphicsMagick::Magick INTERFACE -fopenmp)
        elseif(ANDROID)
            target_link_libraries(GraphicsMagick::Magick INTERFACE -static-openmp -fopenmp)
        endif()
    endif()

    if(GRAPHICSMAGICK_MAGICKWAND_FOUND AND NOT TARGET GraphicsMagick::MagickWand)
        add_library(GraphicsMagick::MagickWand UNKNOWN IMPORTED)
        
        set_target_properties(GraphicsMagick::MagickWand PROPERTIES
            IMPORTED_LOCATION             "${GRAPHICSMAGICK_MAGICKWAND_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${GRAPHICSMAGICK_INCLUDE_DIR}")
        
        target_link_libraries(GraphicsMagick::MagickWand INTERFACE GraphicsMagick::Magick)
    endif()
    
    if(GRAPHICSMAGICK_MAGICKXX_FOUND AND NOT TARGET GraphicsMagick::MagickXX)
        add_library(GraphicsMagick::MagickXX UNKNOWN IMPORTED)
        
        set_target_properties(GraphicsMagick::MagickXX PROPERTIES
            IMPORTED_LOCATION             "${GRAPHICSMAGICK_MAGICKXX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${GRAPHICSMAGICK_INCLUDE_DIR}")
        
        target_link_libraries(GraphicsMagick::MagickXX INTERFACE GraphicsMagick::Magick)
    endif()
endif()
