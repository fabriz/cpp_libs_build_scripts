#!/bin/bash


prepareBuildStep()
{
    printf "$@"
}

checkBuildStep()
{
    if [ $? -ne 0 ]; then
        error "FAILED"
    else
        echo "OK"
    fi
}

decompressArchive()
{
    [ $# = 2 ] || error "decompressArchive(): invalid number of arguments"

    local ARCHIVE_SOURCE=$1
    local ARCHIVE_DESTINATION=$2

    printf "Decompressing ${ARCHIVE_SOURCE} ... "

    if [ ${ARCHIVE_SOURCE: -7} = ".tar.gz" ] || [ ${ARCHIVE_SOURCE: -4} = ".tgz" ]; then
        tar -xz -f ${ARCHIVE_SOURCE} -C ${ARCHIVE_DESTINATION} || error "Cannot decompress file ${ARCHIVE_SOURCE} to ${ARCHIVE_DESTINATION}"
    elif [ ${ARCHIVE_SOURCE: -8} = ".tar.bz2" ]; then
        tar -xj -f ${ARCHIVE_SOURCE} -C ${ARCHIVE_DESTINATION} || error "Cannot decompress file ${ARCHIVE_SOURCE} to ${ARCHIVE_DESTINATION}"
    else
        error "Unsupported archive type"
    fi

    if [ $? -ne 0 ]; then
        error "FAILED"
    else
        echo "OK"
    fi
}

checkCurrentLibTarballChecksum()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    local LIB_TARBALL_CHECKSUM=""

    local MD5_CMD=""
    local SHA1_CMD=""
    local SHA256_CMD=""
    local OPENSSL_CMD=`which openssl`
    if [ -n "${OPENSSL_CMD}" ]; then
        MD5_CMD="${OPENSSL_CMD} dgst -md5 -r"
        SHA1_CMD="${OPENSSL_CMD} dgst -sha1 -r"
        SHA256_CMD="${OPENSSL_CMD} dgst -sha256 -r"
    else
        MD5_CMD=`which md5sum`
        if [ -z "${MD5_CMD}" ]; then
            MD5_CMD=`which gmd5sum`
        fi
        SHA1_CMD=`which sha1sum`
        if [ -z "${SHA1_CMD}" ]; then
            SHA1_CMD=`which gsha1sum`
        fi
        SHA256_CMD=`which sha256sum`
        if [ -z "${SHA256_CMD}" ]; then
            SHA256_CMD=`which gsha256sum`
        fi
    fi

    case ${FM_CURRENT_LIB_TARBALL_HASH_TYPE} in
        "MD5")
            if [ -n "${MD5_CMD}" ]; then
                LIB_TARBALL_CHECKSUM=`${MD5_CMD} ${LIB_TARBALL_LOCAL_PATH}`
                LIB_TARBALL_CHECKSUM=${LIB_TARBALL_CHECKSUM:0:32}
            fi
        ;;
        "SHA-1")
            if [ -n "${SHA1_CMD}" ]; then
                LIB_TARBALL_CHECKSUM=`${SHA1_CMD} ${LIB_TARBALL_LOCAL_PATH}`
                LIB_TARBALL_CHECKSUM=${LIB_TARBALL_CHECKSUM:0:40}
            fi
        ;;
        "SHA-256")
            if [ -n "${SHA256_CMD}" ]; then
                LIB_TARBALL_CHECKSUM=`${SHA256_CMD} ${LIB_TARBALL_LOCAL_PATH}`
                LIB_TARBALL_CHECKSUM=${LIB_TARBALL_CHECKSUM:0:64}
            fi
        ;;
    esac
    
    if [ -n "${LIB_TARBALL_CHECKSUM}" ]; then
        printf "Checking ${FM_CURRENT_LIB_TARBALL_HASH_TYPE} checksum of file ${FM_CURRENT_LIB_TARBALL_NAME} ... "

        LIB_TARBALL_CHECKSUM="$(echo ${LIB_TARBALL_CHECKSUM} | tr '[:upper:]' '[:lower:]')"
        if [ "${LIB_TARBALL_CHECKSUM}" = "${FM_CURRENT_LIB_TARBALL_HASH}" ]; then
            echo "OK"
        else
            error "FAILED"
        fi
    else
        echo "Skipping checksum verification of file ${FM_CURRENT_LIB_TARBALL_NAME}"
    fi
}

downloadCurrentLibTarballIfMissing()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"

    if [ ! -f ${LIB_TARBALL_LOCAL_PATH} ]; then
        echo "File ${FM_CURRENT_LIB_TARBALL_NAME} is missing"
        downloadFile ${FM_CURRENT_LIB_TARBALL_DOWNLOAD_URL} ${LIB_TARBALL_LOCAL_PATH}
    else
        echo "File ${FM_CURRENT_LIB_TARBALL_NAME} already cached"
    fi
    
    checkCurrentLibTarballChecksum
}

initCurrentLibraryVariables()
{
    [ $# = 1 ] || error "initCurrentLibraryVariables(): invalid number of arguments"

    local CURRENT_LIBRARY_NAME=$1

    local VAR_LIB_NAME="FM_${CURRENT_LIBRARY_NAME}_NAME"
    local VAR_LIB_VERSION="FM_${CURRENT_LIBRARY_NAME}_VERSION"
    local VAR_LIB_FULL_NAME="FM_${CURRENT_LIBRARY_NAME}_FULL_NAME"
    local VAR_LIB_TARBALL_NAME="FM_${CURRENT_LIBRARY_NAME}_TARBALL_NAME"
    local VAR_LIB_TARBALL_DOWNLOAD_URL="FM_${CURRENT_LIBRARY_NAME}_TARBALL_DOWNLOAD_URL"
    local VAR_LIB_INSTALL_CHECK="FM_${CURRENT_LIBRARY_NAME}_INSTALL_CHECK"
    local VAR_LIB_HASH="FM_${CURRENT_LIBRARY_NAME}_HASH"
    local VAR_LIB_HASH_TYPE="FM_${CURRENT_LIBRARY_NAME}_HASH_TYPE"

    FM_CURRENT_LIB_NAME="${!VAR_LIB_NAME}"
    FM_CURRENT_LIB_VERSION="${!VAR_LIB_VERSION}"
    FM_CURRENT_LIB_FULL_NAME="${!VAR_LIB_FULL_NAME}"
    FM_CURRENT_LIB_TARBALL_NAME="${!VAR_LIB_TARBALL_NAME}"
    FM_CURRENT_LIB_TARBALL_DOWNLOAD_URL="${!VAR_LIB_TARBALL_DOWNLOAD_URL}"
    FM_CURRENT_LIB_INSTALL_CHECK="${!VAR_LIB_INSTALL_CHECK}"
    FM_CURRENT_LIB_TARBALL_HASH="${!VAR_LIB_HASH}"
    FM_CURRENT_LIB_TARBALL_HASH_TYPE="${!VAR_LIB_HASH_TYPE}"
    
    FM_CURRENT_LIB_SOURCE_DIR="${FM_LIBS_BUILD_SOURCE}/${FM_CURRENT_LIB_FULL_NAME}"
}

checkCurrentLibraryInstallStatus()
{
    if [ -f "${FM_LIBS_INSTALL_PREFIX}/${FM_CURRENT_LIB_INSTALL_CHECK}" ]; then
        echo "Library ${FM_CURRENT_LIB_FULL_NAME} already installed"
        exit 0
    fi
    
    if [ -d "${FM_CURRENT_LIB_SOURCE_DIR}" ]; then
        echo "Removing previous build directory for library ${FM_CURRENT_LIB_FULL_NAME}"
        rm -r "${FM_CURRENT_LIB_SOURCE_DIR}"
    fi
}

initCurrentArchitectureVariables()
{
    [ $# = 1 ] || error "initCurrentLibTargetArchitectureVariables(): invalid number of arguments"

    FM_CURRENT_ARCHITECTURE_NAME=$1

    local LOG_FILE_TIMESTAMP=$(date "+%Y_%m_%d__%H_%M_%S")
    local LOG_FILE_PREFIX=${FM_LIBS_BUILD_LOGS}/${LOG_FILE_TIMESTAMP}__${FM_CURRENT_LIB_FULL_NAME}_${FM_CURRENT_ARCHITECTURE_NAME}

    FM_STAGE_DIR_NAME="tmp_lib_stage"
    
    FM_CURRENT_ARCHITECTURE_SOURCE_DIR="${FM_CURRENT_LIB_SOURCE_DIR}/${FM_CURRENT_ARCHITECTURE_NAME}"
    FM_CURRENT_ARCHITECTURE_STAGE_DIR="${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/${FM_STAGE_DIR_NAME}"
    
    FM_CURRENT_ARCHITECTURE_LIB_TAG="${FM_CURRENT_LIB_FULL_NAME}-${FM_CURRENT_ARCHITECTURE_NAME}-${FM_TARGET_BUILD_VARIANT}"
    
    FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE=${LOG_FILE_PREFIX}_configure.log
    FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE=${LOG_FILE_PREFIX}_make.log
    FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE=${LOG_FILE_PREFIX}_stage.log
}

isLibraryInstalled()
{
    [ $# = 1 ] || error "isLibraryInstalled(): invalid number of arguments"
    
    local LIBRARY_NAME_TO_CHECK=$1
    local VAR_LIB_INSTALL_CHECK="FM_${LIBRARY_NAME_TO_CHECK}_INSTALL_CHECK"
    
    if [ -f "${FM_LIBS_INSTALL_PREFIX}/${!VAR_LIB_INSTALL_CHECK}" ]; then
        FM_IS_LIBRARY_INSTALLED="true"
    else
        FM_IS_LIBRARY_INSTALLED="false"
    fi
}

decompressTarballForCurrentArchitecture()
{
    local LIB_TARBALL_LOCAL_PATH="${FM_GLOBAL_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    
    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    decompressArchive "${LIB_TARBALL_LOCAL_PATH}" "${FM_CURRENT_LIB_SOURCE_DIR}"

    mv "${FM_CURRENT_LIB_SOURCE_DIR}/${FM_CURRENT_LIB_FULL_NAME}" "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

installFatLibraries()
{
    [ $# = 2 ] || error "installFatLibraries(): invalid number of arguments"

    local LIB_FULL_NAME=$1
    local ARCHITECTURES_LIST=$2

    pushd "${FM_CURRENT_LIB_SOURCE_DIR}/${ARCHITECTURES_LIST[0]}/${FM_STAGE_DIR_NAME}/lib"
    local THIN_LIBS=(*.a)
    popd

    # check that at least one found

    local THIN_LIB
    for THIN_LIB in "${THIN_LIBS[@]}"
    do
        printf "Installing fat library ${THIN_LIB} ... "
        ${FM_TARGET_TOOLCHAIN_LIPO} -create ${FM_CURRENT_LIB_SOURCE_DIR}/*/${FM_STAGE_DIR_NAME}/lib/${THIN_LIB} -o "${FM_LIBS_INSTALL_LIBS}/${THIN_LIB}"
        if [ $? -ne 0 ]; then
            error "FAILED"
        else
            echo "OK"
        fi
    done

    printf "Installing include files ... "
    cp -R "${FM_CURRENT_LIB_SOURCE_DIR}/${ARCHITECTURES_LIST[0]}/${FM_STAGE_DIR_NAME}/include/." "${FM_LIBS_INSTALL_INCLUDES}/"
    echo "OK"
}

installLibraries()
{
    # check that at least one found
    
    printf "Installing library files ... "
    cp -R "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/." "${FM_LIBS_INSTALL_LIBS}/"
    echo "OK"

    printf "Installing include files ... "
    cp -R "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/." "${FM_LIBS_INSTALL_INCLUDES}/"
    echo "OK"
    
    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll" ]; then
        printf "Installing dll files ... "
        cp -R "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll/." "${FM_LIBS_INSTALL_DLLS}/"
        echo "OK"
    fi
}

beforeBuildCurrentArchitecture()
{
    # Empty default implementation
    :
}

afterBuildCurrentArchitecture()
{
    # Empty default implementation
    :
}

buildCurrentArchitecture()
{
    pushd "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"

    beforeBuildCurrentArchitecture
    buildCurrentArchitecture__${FM_TARGET_TOOLCHAIN}
    afterBuildCurrentArchitecture
    
    popd
}

buildLibrary()
{
    [ $# = 1 ] || error "buildLibrary(): invalid number of arguments"

    local CURRENT_LIBRARY_NAME=$1

    initCurrentLibraryVariables "${CURRENT_LIBRARY_NAME}"
    checkCurrentLibraryInstallStatus
    downloadCurrentLibTarballIfMissing

    initToolchainConfiguration
    initCurrentArchitectureVariables "${FM_TARGET_ARCHITECTURE}"
    decompressTarballForCurrentArchitecture
    buildCurrentArchitecture
    installLibraries

    echo "Library ${FM_CURRENT_LIB_FULL_NAME} successfully installed"
}


