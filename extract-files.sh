#!/bin/bash
#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=E12
VENDOR=e12

MY_DIR="${BASH_SOURCE[0]%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

LINEAGE_ROOT="${MY_DIR}/../../.."

HELPER="${LINEAGE_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
fi

if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

CLEAN_VENDOR=true
SECTION=

while [ "${1}" != "" ]; do
    case "${1}" in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -s | --section )        shift
                                SECTION="${1}"
                                ;;
        * )                     SRC="${1}"
                                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

setup_vendor "${DEVICE}" "${VENDOR}" "${LINEAGE_ROOT}" false "${CLEAN_VENDOR}"

if [ -z "${SECTION}" ]; then
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}"
else
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"