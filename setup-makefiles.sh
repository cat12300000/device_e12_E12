#!/bin/bash
#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=E12
VENDOR=e12

INITIAL_COPYRIGHT_YEAR=2026

MY_DIR="${BASH_SOURCE[0]%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

LINEAGE_ROOT="${MY_DIR}/../../.."

HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    HELPER="${LINEAGE_ROOT}/tools/extract-utils/extract_utils.sh"
fi

if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize vendor makefiles
write_headers

# Populate vendor makefiles using proprietary-files.txt
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish makefiles
write_footers
