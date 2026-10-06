#
# Device makefile for E12 (MT6761, Virtual A/B + dynamic partitions)
# Stock vendor is Android 12 (VNDK 31)
#

LOCAL_PATH := device/e12/E12

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Shipping API level (Android 12 stock vendor)
PRODUCT_SHIPPING_API_LEVEL := 31

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Kernel VINTF requirements (bypasses Kernel 4.19 Matrix checks on newer Android)
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# A/B OTA packages
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# First-stage mount & Hardware init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6761:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6761 \
    $(LOCAL_PATH)/rootdir/etc/init.mt6761.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mt6761.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.mt6761.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

# Vendor blobs makefile
$(call inherit-product, vendor/e12/E12/E12-vendor.mk)
