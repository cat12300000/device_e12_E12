#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit 64-bit product setup
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit device configuration
$(call inherit-product, device/e12/E12/device.mk)

# Inherit common LineageOS configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifiers
PRODUCT_NAME := lineage_E12
PRODUCT_DEVICE := E12
PRODUCT_BRAND := Koobee
PRODUCT_MODEL := E12
PRODUCT_MANUFACTURER := Koobee
PRODUCT_GMS_CLIENTID_BASE := android-koobee

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=E12 \
    PRODUCT_NAME=E12
