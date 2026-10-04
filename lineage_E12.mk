#
# Draft LineageOS product makefile for E12 (MT6761)
#

# Multilib: arm64 primary, arm 32-bit secondary
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Common Lineage configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device
$(call inherit-product, device/e12/E12/device.mk)

PRODUCT_NAME := lineage_E12
PRODUCT_DEVICE := E12
# TODO: take these from the stock vendor build.prop
# (ro.product.brand, ro.product.model, ro.product.manufacturer)
PRODUCT_BRAND := E12
PRODUCT_MODEL := E12
PRODUCT_MANUFACTURER := Koobee
