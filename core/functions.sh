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
    [ $# = 3 ] || error "decompressArchive(): invalid number of arguments"

    local LOCAL_ARCHIVE_SOURCE=$1
    local LOCAL_ARCHIVE_DESTINATION=$2
    local LOCAL_CUSTOM_FLAGS=$3

    local LOCAL_TAR_COMMAND="tar"
    if [ -n "${FM_CONFIG_TAR_COMMAND-}" ]; then
        LOCAL_TAR_COMMAND="${FM_CONFIG_TAR_COMMAND}"
    fi

    printf "Decompressing ${LOCAL_ARCHIVE_SOURCE} ... "
    "${LOCAL_TAR_COMMAND}" ${LOCAL_CUSTOM_FLAGS} -x -f ${LOCAL_ARCHIVE_SOURCE} -C ${LOCAL_ARCHIVE_DESTINATION}
    if [ $? -ne 0 ]; then
        echo "FAILED"
        error "Cannot decompress file ${LOCAL_ARCHIVE_SOURCE} to ${LOCAL_ARCHIVE_DESTINATION}"
    else
        echo "OK"
    fi
}

checkCurrentLibTarballChecksum()
{
    local LOCAL_LIB_TARBALL_LOCAL_PATH="${FM_ARG_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    local LOCAL_LIB_TARBALL_CHECKSUM=""

    local LOCAL_MD5_CMD=""
    local LOCAL_SHA1_CMD=""
    local LOCAL_SHA256_CMD=""
    local LOCAL_OPENSSL_CMD=$(which openssl)
    if [ -n "${LOCAL_OPENSSL_CMD}" ]; then
        LOCAL_MD5_CMD="${LOCAL_OPENSSL_CMD} dgst -md5 -r"
        LOCAL_SHA1_CMD="${LOCAL_OPENSSL_CMD} dgst -sha1 -r"
        LOCAL_SHA256_CMD="${LOCAL_OPENSSL_CMD} dgst -sha256 -r"
    else
        LOCAL_MD5_CMD=$(which md5sum)
        if [ -z "${LOCAL_MD5_CMD}" ]; then
            LOCAL_MD5_CMD=$(which gmd5sum)
        fi
        LOCAL_SHA1_CMD=$(which sha1sum)
        if [ -z "${LOCAL_SHA1_CMD}" ]; then
            LOCAL_SHA1_CMD=$(which gsha1sum)
        fi
        LOCAL_SHA256_CMD=$(which sha256sum)
        if [ -z "${LOCAL_SHA256_CMD}" ]; then
            LOCAL_SHA256_CMD=$(which gsha256sum)
        fi
    fi

    case ${FM_CURRENT_LIB_TARBALL_HASH_TYPE} in
        "MD5")
            if [ -n "${LOCAL_MD5_CMD}" ]; then
                LOCAL_LIB_TARBALL_CHECKSUM=$(${LOCAL_MD5_CMD} ${LOCAL_LIB_TARBALL_LOCAL_PATH})
                LOCAL_LIB_TARBALL_CHECKSUM=${LOCAL_LIB_TARBALL_CHECKSUM:0:32}
            fi
        ;;
        "SHA-1")
            if [ -n "${LOCAL_SHA1_CMD}" ]; then
                LOCAL_LIB_TARBALL_CHECKSUM=$(${LOCAL_SHA1_CMD} ${LOCAL_LIB_TARBALL_LOCAL_PATH})
                LOCAL_LIB_TARBALL_CHECKSUM=${LOCAL_LIB_TARBALL_CHECKSUM:0:40}
            fi
        ;;
        "SHA-256")
            if [ -n "${LOCAL_SHA256_CMD}" ]; then
                LOCAL_LIB_TARBALL_CHECKSUM=$(${LOCAL_SHA256_CMD} ${LOCAL_LIB_TARBALL_LOCAL_PATH})
                LOCAL_LIB_TARBALL_CHECKSUM=${LOCAL_LIB_TARBALL_CHECKSUM:0:64}
            fi
        ;;
    esac
    
    if [ -n "${LOCAL_LIB_TARBALL_CHECKSUM}" ]; then
        printf "Checking ${FM_CURRENT_LIB_TARBALL_HASH_TYPE} checksum of file ${FM_CURRENT_LIB_TARBALL_NAME} ... "

        LOCAL_LIB_TARBALL_CHECKSUM="$(echo ${LOCAL_LIB_TARBALL_CHECKSUM} | tr '[:upper:]' '[:lower:]')"
        if [ "${LOCAL_LIB_TARBALL_CHECKSUM}" = "${FM_CURRENT_LIB_TARBALL_HASH}" ]; then
            echo "OK"
        else
            echo "FAILED"
            error "Actual checksum is ${LOCAL_LIB_TARBALL_CHECKSUM}"
        fi
    else
        echo "Skipping checksum verification of file ${FM_CURRENT_LIB_TARBALL_NAME}"
    fi
}

downloadFileFromLanCache()
{
    [ $# = 2 ] || error "downloadFileFromLanCache(): invalid number of arguments"

    # No "LOCAL" prefix, because these variable will be used in the eval expression.
    local TARBALL_NAME=$1
    local DESTINATION_PATH_FINAL=$2
    local DESTINATION_PATH="${DESTINATION_PATH_FINAL}.temp"

    echo "LAN cache: Downloading ${TARBALL_NAME} to ${DESTINATION_PATH_FINAL}"

    eval ${FM_CONFIG_LAN_TARBALL_CACHE_GET_CMD}
    if [ $? -ne 0 ]; then
        rm -f "${DESTINATION_PATH}"
        echo "LAN cache: Cannot download ${TARBALL_NAME} to ${DESTINATION_PATH}"
        return 1
    fi

    if ! mv "${DESTINATION_PATH}" "${DESTINATION_PATH_FINAL}"; then
        echo "LAN cache: Cannot rename file ${DESTINATION_PATH} to ${DESTINATION_PATH_FINAL}"
        return 1
    fi

    if [ ! -f "${DESTINATION_PATH_FINAL}" ]; then
        echo "LAN cache: Failed to download ${TARBALL_NAME} to ${DESTINATION_PATH_FINAL}"
        return 1
    fi

    return 0
}

downloadFile()
{
    [ $# = 2 ] || error "downloadFile(): invalid number of arguments"

    local LOCAL_DOWNLOAD_SOURCE=$1
    local LOCAL_DOWNLOAD_DESTINATION=$2
    local LOCAL_DOWNLOAD_DESTINATION_TEMP="${LOCAL_DOWNLOAD_DESTINATION}.temp"

    echo "Downloading ${LOCAL_DOWNLOAD_SOURCE} to ${LOCAL_DOWNLOAD_DESTINATION}"

    local LOCAL_CURL_CMD="curl"
    if [ -n "${FM_CONFIG_CURL_COMMAND-}" ]; then
        LOCAL_CURL_CMD="${FM_CONFIG_CURL_COMMAND}"
    fi

    local LOCAL_CURL_CMD_OPTIONS=""
    if [ ${FM_CONFIG_DISABLE_SSL_CERTIFICATE_VALIDATION:-false} = true ]; then
        LOCAL_CURL_CMD_OPTIONS="--insecure"
        echo "WARNING: Insecure mode, SSL certificate validation disabled!!!"
    fi

    "${LOCAL_CURL_CMD}" ${LOCAL_CURL_CMD_OPTIONS} -L -o "${LOCAL_DOWNLOAD_DESTINATION_TEMP}" "${LOCAL_DOWNLOAD_SOURCE}"
    if [ $? -ne 0 ]; then
        rm -f "${LOCAL_DOWNLOAD_DESTINATION_TEMP}"
        echo "ERROR: Cannot download ${LOCAL_DOWNLOAD_SOURCE} to ${LOCAL_DOWNLOAD_DESTINATION_TEMP}"
        return 1
    fi

    if ! mv "${LOCAL_DOWNLOAD_DESTINATION_TEMP}" "${LOCAL_DOWNLOAD_DESTINATION}"; then
        echo "ERROR: Cannot rename file ${LOCAL_DOWNLOAD_DESTINATION_TEMP} to ${LOCAL_DOWNLOAD_DESTINATION}"
        return 1
    fi

    if [ ! -f "${LOCAL_DOWNLOAD_DESTINATION}" ]; then
        echo "ERROR: Failed to download ${LOCAL_DOWNLOAD_SOURCE} to ${LOCAL_DOWNLOAD_DESTINATION}"
        return 1
    fi

    return 0
}

downloadCurrentLibTarballIfMissing()
{
    local LOCAL_LIB_TARBALL_LOCAL_PATH="${FM_ARG_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    local LOCAL_LIB_TARBALL_LOCK_PATH="${FM_ARG_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}.lock"

    acquireLock "${LOCAL_LIB_TARBALL_LOCK_PATH}"

    if [ ! -f ${LOCAL_LIB_TARBALL_LOCAL_PATH} ]; then
        echo "File ${FM_CURRENT_LIB_TARBALL_NAME} is missing"

        local LOCAL_USE_LAN_TARBALL_CACHE="$(echo ${FM_CONFIG_LAN_TARBALL_CACHE_USE} | tr '[:upper:]' '[:lower:]')"
        local LOCAL_DOWNLOAD_FROM_LAN_CACHE=false
        local LOCAL_DOWNLOAD_FROM_INTERNET=true

        case ${LOCAL_USE_LAN_TARBALL_CACHE:-no} in
            "no")
                LOCAL_DOWNLOAD_FROM_LAN_CACHE=false
                LOCAL_DOWNLOAD_FROM_INTERNET=true
            ;;
            "yes")
                LOCAL_DOWNLOAD_FROM_LAN_CACHE=true
                LOCAL_DOWNLOAD_FROM_INTERNET=true
            ;;
            "only")
                LOCAL_DOWNLOAD_FROM_LAN_CACHE=true
                LOCAL_DOWNLOAD_FROM_INTERNET=false
            ;;
        esac

        if [ ${LOCAL_DOWNLOAD_FROM_LAN_CACHE} = true ]; then
            if ! downloadFileFromLanCache ${FM_CURRENT_LIB_TARBALL_NAME} ${LOCAL_LIB_TARBALL_LOCAL_PATH}; then
                if [ ${LOCAL_DOWNLOAD_FROM_INTERNET} = false ]; then
                    releaseLock "${LOCAL_LIB_TARBALL_LOCK_PATH}"
                    error "Cannot get file ${FM_CURRENT_LIB_TARBALL_NAME} from the LAN cache."
                fi
            fi
        fi

        if [ ${LOCAL_DOWNLOAD_FROM_INTERNET} = true ]; then
            if [ ! -f ${LOCAL_LIB_TARBALL_LOCAL_PATH} ]; then
                downloadFile ${FM_CURRENT_LIB_TARBALL_DOWNLOAD_URL} ${LOCAL_LIB_TARBALL_LOCAL_PATH}
            fi
        fi

        if [ ! -f ${LOCAL_LIB_TARBALL_LOCAL_PATH} ]; then
            releaseLock "${LOCAL_LIB_TARBALL_LOCK_PATH}"
            error "Cannot get file ${FM_CURRENT_LIB_TARBALL_NAME}."
        fi
    else
        echo "File ${FM_CURRENT_LIB_TARBALL_NAME} already cached"
    fi

    releaseLock "${LOCAL_LIB_TARBALL_LOCK_PATH}"
}

initCurrentLibraryVariables()
{
    [ $# = 1 ] || error "initCurrentLibraryVariables(): invalid number of arguments"

    local LOCAL_CURRENT_LIBRARY_NAME=$1

    local LOCAL_VAR_LIB_VARS_PREFIX="FM_${LOCAL_CURRENT_LIBRARY_NAME}"

    local LOCAL_VAR_LIB_NAME="${LOCAL_VAR_LIB_VARS_PREFIX}_NAME"
    local LOCAL_VAR_LIB_VERSION="${LOCAL_VAR_LIB_VARS_PREFIX}_VERSION"
    local LOCAL_VAR_LIB_FULL_NAME="${LOCAL_VAR_LIB_VARS_PREFIX}_FULL_NAME"
    local LOCAL_VAR_LIB_TARBALL_NAME="${LOCAL_VAR_LIB_VARS_PREFIX}_TARBALL_NAME"
    local LOCAL_VAR_LIB_TARBALL_DOWNLOAD_URL="${LOCAL_VAR_LIB_VARS_PREFIX}_TARBALL_DOWNLOAD_URL"
    local LOCAL_VAR_LIB_UNTAR_FLAGS="${LOCAL_VAR_LIB_VARS_PREFIX}_UNTAR_FLAGS"
    local LOCAL_VAR_LIB_UNTAR_DIR="${LOCAL_VAR_LIB_VARS_PREFIX}_UNTAR_DIR"
    local LOCAL_VAR_LIB_INSTALL_CHECK="${LOCAL_VAR_LIB_VARS_PREFIX}_INSTALL_CHECK"
    local LOCAL_VAR_LIB_HASH="${LOCAL_VAR_LIB_VARS_PREFIX}_HASH"
    local LOCAL_VAR_LIB_HASH_TYPE="${LOCAL_VAR_LIB_VARS_PREFIX}_HASH_TYPE"

    # Load a fresh copy of the library configuration variables
    unset -v $(compgen -v "${LOCAL_VAR_LIB_VARS_PREFIX}_")
    source "${FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY}/config.sh"
    if [ $? -ne 0 ]; then
        error "ERROR: Error loading library configuration file: ${FM_PATH_CURRENT_BUILD_SCRIPT_DIRECTORY}/config.sh"
    fi

    FM_CURRENT_LIB_NAME="${!LOCAL_VAR_LIB_NAME}"
    FM_CURRENT_LIB_VERSION="${!LOCAL_VAR_LIB_VERSION}"
    FM_CURRENT_LIB_FULL_NAME="${!LOCAL_VAR_LIB_FULL_NAME}"
    FM_CURRENT_LIB_TARBALL_NAME="${!LOCAL_VAR_LIB_TARBALL_NAME}"
    FM_CURRENT_LIB_TARBALL_DOWNLOAD_URL="${!LOCAL_VAR_LIB_TARBALL_DOWNLOAD_URL}"
    FM_CURRENT_LIB_UNTAR_FLAGS="${!LOCAL_VAR_LIB_UNTAR_FLAGS-}"
    FM_CURRENT_LIB_UNTAR_DIR="${!LOCAL_VAR_LIB_UNTAR_DIR-${FM_CURRENT_LIB_FULL_NAME}}"
    FM_CURRENT_LIB_INSTALL_CHECK="${!LOCAL_VAR_LIB_INSTALL_CHECK}"
    FM_CURRENT_LIB_TARBALL_HASH="${!LOCAL_VAR_LIB_HASH}"
    FM_CURRENT_LIB_TARBALL_HASH_TYPE="${!LOCAL_VAR_LIB_HASH_TYPE}"
}

deletePreviousBuildDirectory()
{
    if [ -d "${FM_CURRENT_LIB_SOURCE_DIR}" ]; then
        echo "Removing previous build directory for library ${FM_CURRENT_LIB_FULL_NAME} ${FM_ARG_BUILD_VARIANT}"
        deleteDirectoryRecursive "${FM_CURRENT_LIB_SOURCE_DIR}"
    fi
}

currentLibraryVariantIsAlreadyStaged()
{
    if [ -f "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/${FM_CURRENT_LIB_INSTALL_CHECK}" ]; then
        return 0
    else
        return 1
    fi
}

currentLibraryVariantIsAlreadyInstalled()
{
    if [ -f "${FM_LIBS_INSTALL_PREFIX}/${FM_CURRENT_LIB_INSTALL_CHECK}" ]; then
        echo "Library variant ${FM_CURRENT_LIB_FULL_NAME} ${FM_TARGET_BUILD_TAG} already installed"
        return 0
    else
        return 1
    fi
}

initCurrentArchitecture()
{
    # Build tag
    FM_TARGET_BUILD_TAG="${FM_TARGET_PLATFORM}_${FM_ARG_ARCHITECTURE}_${FM_ARG_BUILD_VARIANT}"

    # Build folders
    FM_LIBS_BUILD_FOLDER="${FM_ARG_BUILD_ROOT}/${FM_TARGET_BUILD_TAG}"
    FM_LIBS_BUILD_SOURCE="${FM_LIBS_BUILD_FOLDER}/source"
    FM_LIBS_BUILD_LOGS="${FM_LIBS_BUILD_FOLDER}/logs"

    createDirectory ${FM_LIBS_BUILD_FOLDER}
    createDirectory ${FM_LIBS_BUILD_SOURCE}
    createDirectory ${FM_LIBS_BUILD_LOGS}

    # Install folders
    FM_LIBS_INSTALL_PREFIX="${FM_ARG_DEPLOY_ROOT}/${FM_TARGET_BUILD_TAG}"
    FM_LIBS_INSTALL_INCLUDES="${FM_LIBS_INSTALL_PREFIX}/include"
    FM_LIBS_INSTALL_LIBS="${FM_LIBS_INSTALL_PREFIX}/lib"
    FM_LIBS_INSTALL_PKGCONFIG="${FM_LIBS_INSTALL_PREFIX}/pkgconfig"
    FM_LIBS_INSTALL_DLLS="${FM_LIBS_INSTALL_PREFIX}/dll"

    createDirectory ${FM_LIBS_INSTALL_PREFIX}
    createDirectory ${FM_LIBS_INSTALL_INCLUDES}
    createDirectory ${FM_LIBS_INSTALL_LIBS}

    FM_CURRENT_LIB_SOURCE_DIR="${FM_LIBS_BUILD_SOURCE}/${FM_CURRENT_LIB_FULL_NAME}"

    local LOCAL_LOG_FILE_TIMESTAMP=$(date "+%Y_%m_%d__%H_%M_%S")
    local LOCAL_LOG_FILE_PREFIX=${FM_LIBS_BUILD_LOGS}/${LOCAL_LOG_FILE_TIMESTAMP}__${FM_CURRENT_LIB_FULL_NAME}_${FM_ARG_ARCHITECTURE}

    local LOCAL_STAGE_DIR_NAME="tmp_lib_stage"
    
    FM_CURRENT_ARCHITECTURE_SOURCE_DIR="${FM_CURRENT_LIB_SOURCE_DIR}/${FM_ARG_ARCHITECTURE}"
    FM_CURRENT_ARCHITECTURE_STAGE_DIR="${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}/${LOCAL_STAGE_DIR_NAME}"
    
    FM_CURRENT_ARCHITECTURE_LIB_TAG="${FM_CURRENT_LIB_FULL_NAME}-${FM_ARG_ARCHITECTURE}-${FM_ARG_BUILD_VARIANT}"
    
    FM_CURRENT_ARCHITECTURE_LOG_FILE_CONFIGURE=${LOCAL_LOG_FILE_PREFIX}_configure.log
    FM_CURRENT_ARCHITECTURE_LOG_FILE_MAKE=${LOCAL_LOG_FILE_PREFIX}_make.log
    FM_CURRENT_ARCHITECTURE_LOG_FILE_STAGE=${LOCAL_LOG_FILE_PREFIX}_stage.log

    # Corresponding build type for CMake
    FM_CMAKE_TARGET_VARIANT_BUILD_TYPE=""
    if [ ${FM_ARG_BUILD_VARIANT} = "debug" ]; then
        FM_CMAKE_TARGET_VARIANT_BUILD_TYPE="Debug"
    elif [ ${FM_ARG_BUILD_VARIANT} = "release" ]; then
        FM_CMAKE_TARGET_VARIANT_BUILD_TYPE="Release"
    elif [ ${FM_ARG_BUILD_VARIANT} = "profile" ]; then
        FM_CMAKE_TARGET_VARIANT_BUILD_TYPE="RelWithDebInfo"
    else
        error "Unsupported build variant: ${FM_ARG_BUILD_VARIANT}."
    fi
}

isLibraryInstalled()
{
    [ $# = 1 ] || error "isLibraryInstalled(): invalid number of arguments"

    local LOCAL_LIBRARY_NAME_TO_CHECK=$1
    local LOCAL_VAR_LIB_INSTALL_CHECK="FM_${LOCAL_LIBRARY_NAME_TO_CHECK}_INSTALL_CHECK"
    local LOCAL_LIB_INSTALL_CHECK_FILE="${!LOCAL_VAR_LIB_INSTALL_CHECK-}"

    if [ -n "${LOCAL_LIB_INSTALL_CHECK_FILE}" ]; then
        if [ -f "${FM_LIBS_INSTALL_PREFIX}/${LOCAL_LIB_INSTALL_CHECK_FILE}" ]; then
            return 0
        fi
    fi

    return 1
}

decompressTarballForCurrentArchitecture()
{
    local LOCAL_LIB_TARBALL_LOCAL_PATH="${FM_ARG_TARBALL_CACHE}/${FM_CURRENT_LIB_TARBALL_NAME}"
    
    createDirectory "${FM_CURRENT_LIB_SOURCE_DIR}"

    decompressArchive "${LOCAL_LIB_TARBALL_LOCAL_PATH}" "${FM_CURRENT_LIB_SOURCE_DIR}" "${FM_CURRENT_LIB_UNTAR_FLAGS}"

    moveDirectory "${FM_CURRENT_LIB_SOURCE_DIR}/"${FM_CURRENT_LIB_UNTAR_DIR} "${FM_CURRENT_ARCHITECTURE_SOURCE_DIR}"
}

installLibraries()
{
    if ! currentLibraryVariantIsAlreadyStaged; then
        error "Library not staged"
    fi

    if [ ${FM_TARGET_HAS_PKGCONFIG:-false} = true ]; then
        if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig" ]; then
            printf "Installing pkgconfig files ... "
            createDirectory ${FM_LIBS_INSTALL_PKGCONFIG}
            pushd "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig"

            local LOCAL_PKGCONFIG_FILES=(*.pc)
            for LOCAL_PKGCONFIG_FILE in "${LOCAL_PKGCONFIG_FILES[@]}"
            do
                if [ ${FM_HOST_OS_TYPE} = "windows" ]; then
                    FM_CURRENT_ARCHITECTURE_STAGE_DIR_WINDOWS=$(cygpath -w ${FM_CURRENT_ARCHITECTURE_STAGE_DIR})
                    sed -i.orig -e "s|${FM_CURRENT_ARCHITECTURE_STAGE_DIR}|${FM_LIBS_INSTALL_PREFIX}|" \
                        -e "s|${FM_CURRENT_ARCHITECTURE_STAGE_DIR_WINDOWS//\\/\\\\}|${FM_LIBS_INSTALL_PREFIX}|" \
                        -e "s|${FM_CURRENT_ARCHITECTURE_STAGE_DIR_WINDOWS//\\/\/}|${FM_LIBS_INSTALL_PREFIX}|" ./${LOCAL_PKGCONFIG_FILE}
                else
                    sed -i.orig "s|${FM_CURRENT_ARCHITECTURE_STAGE_DIR}|${FM_LIBS_INSTALL_PREFIX}|" ./${LOCAL_PKGCONFIG_FILE}
                fi

                if [ $? -ne 0 ]; then
                    error "FAILED"
                fi

                if cmp -s "./${LOCAL_PKGCONFIG_FILE}" "./${LOCAL_PKGCONFIG_FILE}.orig"; then
                    echo "ERROR"
                    error "Error patching pkg-config file: ${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/pkgconfig/${LOCAL_PKGCONFIG_FILE}."
                fi

                copyFile ./${LOCAL_PKGCONFIG_FILE} ${FM_LIBS_INSTALL_PKGCONFIG}
            done

            popd
            echo "OK"
        fi
    fi

    printf "Installing include files ... "
    cp -R "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/include/." "${FM_LIBS_INSTALL_INCLUDES}/"
    echo "OK"

    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib" ]; then
        printf "Installing library files ... "
        cp -R "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/lib/." "${FM_LIBS_INSTALL_LIBS}/"
        echo "OK"
    fi

    if [ -d "${FM_CURRENT_ARCHITECTURE_STAGE_DIR}/dll" ]; then
        printf "Installing dll files ... "
        createDirectory ${FM_LIBS_INSTALL_DLLS}
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

actionBuild()
{
    downloadCurrentLibTarballIfMissing
    checkCurrentLibTarballChecksum

    for FM_ARG_ARCHITECTURE in ${FM_ARG_ARCHITECTURES}
    do
        for FM_ARG_BUILD_VARIANT in ${FM_ARG_BUILD_VARIANTS}
        do
            initCurrentArchitecture
            initToolchain

            if ! currentLibraryVariantIsAlreadyStaged; then
                deletePreviousBuildDirectory
                decompressTarballForCurrentArchitecture
                buildCurrentArchitecture
            fi
        done
    done
}

actionInstall()
{
    for FM_ARG_ARCHITECTURE in ${FM_ARG_ARCHITECTURES}
    do
        for FM_ARG_BUILD_VARIANT in ${FM_ARG_BUILD_VARIANTS}
        do
            initCurrentArchitecture
            initToolchain

            if ! currentLibraryVariantIsAlreadyInstalled; then
                installLibraries
                echo "Library variant ${FM_CURRENT_LIB_FULL_NAME} ${FM_TARGET_BUILD_TAG} successfully installed"
            fi
        done
    done
}

actionBuildInstall()
{
    downloadCurrentLibTarballIfMissing
    checkCurrentLibTarballChecksum

    local LOCAL_LIBRARY_BUILT=false
    for FM_ARG_ARCHITECTURE in ${FM_ARG_ARCHITECTURES}
    do
        for FM_ARG_BUILD_VARIANT in ${FM_ARG_BUILD_VARIANTS}
        do
            initCurrentArchitecture
            initToolchain

            if ! currentLibraryVariantIsAlreadyInstalled; then
                deletePreviousBuildDirectory
                decompressTarballForCurrentArchitecture
                buildCurrentArchitecture
                installLibraries
                LOCAL_LIBRARY_BUILT=true
                echo "Library variant ${FM_CURRENT_LIB_FULL_NAME} ${FM_TARGET_BUILD_TAG} successfully installed"
            fi
        done
    done

    if [ ${LOCAL_LIBRARY_BUILT} = true ]; then
        echo "Library ${FM_CURRENT_LIB_FULL_NAME} (${FM_TARGET_TOOLCHAIN} ${FM_TARGET_COMPILER_VERSION}) successfully installed"
    fi
}

buildLibrary()
{
    [ $# = 1 ] || error "buildLibrary(): invalid number of arguments"

    local LOCAL_CURRENT_LIBRARY_NAME=$1

    initCurrentLibraryVariables "${LOCAL_CURRENT_LIBRARY_NAME}"

    if ! isFunctionDefined "buildCurrentArchitecture__${FM_TARGET_TOOLCHAIN}"; then
        echo "Library ${FM_CURRENT_LIB_FULL_NAME} (${FM_TARGET_TOOLCHAIN} ${FM_TARGET_COMPILER_VERSION}) skipped"
        return
    fi

    if [ ${FM_ARG_ACTION} = "build" ]; then
        actionBuild
    elif [ ${FM_ARG_ACTION} = "install" ]; then
        actionInstall
    elif [ ${FM_ARG_ACTION} = "buildinstall" ]; then
        actionBuildInstall
    else
        error "Unsupported build action: ${FM_ARG_ACTION}."
    fi
}
