#!/bin/bash
# Build script for wt 4.3.1

export FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FM_PATH_CORE_SCRIPTS_DIRECTORY}/build_common.sh"


beforeBuildCurrentArchitecture()
{
    # Avoid the "d" suffix for debug libraries
    sed -i.orig 's/DEBUG_LIB_POSTFIX "d"/DEBUG_LIB_POSTFIX ""/' ./CMakeLists.txt

    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/Wt/Dbo/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/Wt/Dbo/backend/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/fcgi/CMakeLists.txt
    sed -i.orig -e 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' -e '/Android.C/d' ./src/http/CMakeLists.txt
    sed -i.orig 's/DEBUG_POSTFIX ${DEBUG_LIB_POSTFIX}/DEBUG_POSTFIX "${DEBUG_LIB_POSTFIX}"/' ./src/isapi/CMakeLists.txt
}

afterBuildCurrentArchitecture()
{
    deleteDirectoryRecursive "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/cmake"
}

buildCurrentArchitecture__linux_gcc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DSHARED_LIBS=False -DBoost_USE_STATIC_LIBS=True\
        -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True\
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True\
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__android_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DSHARED_LIBS=False\
        -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True\
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True\
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

buildCurrentArchitecture__macos_clang()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DSHARED_LIBS=False -DBoost_USE_STATIC_LIBS=True\
        -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True\
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True\
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep
}

#buildCurrentArchitecture__ios_clang()
#{
#    :
#}

#buildCurrentArchitecture__windows_mingw()
#{
#    # Disable DirectWrite
#    sed -i.orig2 's/HAVE_DIRECTWRITE true/HAVE_DIRECTWRITE false/' ./src/CMakeLists.txt

#    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    "${FM_CONFIG_CMAKE_COMMAND}" -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DSHARED_LIBS=False\
#        -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True\
#        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True\
#        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
#        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
#    checkBuildStep

#    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    make -j${FM_ARG_NUM_PROCESSES} > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
#    checkBuildStep

#    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
#    make install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
#    checkBuildStep
#}

buildCurrentArchitecture__windows_msvc()
{
    prepareBuildStep "Configuring ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    "${FM_CONFIG_CMAKE_COMMAND}" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=${FM_CMAKE_TARGET_VARIANT_BUILD_TYPE} -DSHARED_LIBS=False\
        -DBOOST_PREFIX=${FM_LIBS_INSTALL_PREFIX}\
        -DCONNECTOR_FCGI=True -DCONNECTOR_HTTP=True -DMULTI_THREADED=True\
        -DBUILD_EXAMPLES=False -DINSTALL_DOCUMENTATION=False -DENABLE_LIBWTTEST=False -DINSTALL_EXAMPLES=False -DINSTALL_RESOURCES=True\
        -DCMAKE_PREFIX_PATH=${FM_LIBS_INSTALL_PREFIX} -DCMAKE_INSTALL_PREFIX=${FM_CURRENT_ARCHITECTURE_STAGE_DIR}\
        -S . -B . > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE} 2>&1
    checkBuildStep

    prepareBuildStep "Building ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE} 2>&1
    checkBuildStep

    prepareBuildStep "Staging ${FM_CURRENT_ARCHITECTURE_LIB_TAG} ... "
    nmake install > ${FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE} 2>&1
    checkBuildStep

    /usr/bin/find ./src -name "*.pdb" -exec cp "{}" ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/ ';'
}


buildLibrary "WT"
