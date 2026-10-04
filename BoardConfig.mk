#
# Draft BoardConfig.mk for E12 (MT6761, A/B + dynamic partitions)
# Values come from the TWRP tree; items marked TODO need your own numbers.
# Intentionally NOT carried over from the TWRP tree: TW_* flags, the 2099
# security patch hack, PLATFORM_VERSION, ALLOW_MISSING_DEPENDENCIES,
# BOARD_BUILD_SYSTEM_ROOT_IMAGE.
#

DEVICE_PATH := device/e12/E12

# Architecture (confirm with ro.vendor.product.cpu.abilist)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Platform
TARGET_BOARD_PLATFORM := mt6761
TARGET_BOOTLOADER_BOARD_NAME := k61v1_64_bsp
TARGET_NO_BOOTLOADER := true
TARGET_SCREEN_DENSITY := 320

# A/B (keep only partitions that lpdump / by-name actually lists)
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor

BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true

# Kernel / boot image (prebuilt)
# Confirmed with unpack_bootimg on stock boot_a: header v2, base 0x40078000,
# kernel 0x40080000, ramdisk 0x51b00000, tags/dtb 0x47880000, page size 2048
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x11a88000
BOARD_KERNEL_TAGS_OFFSET := 0x07808000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_IMAGE_NAME := Image

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset 0x00008000
BOARD_MKBOOTIMG_ARGS += --second_offset 0xbff88000
BOARD_MKBOOTIMG_ARGS += --dtb_offset 0x07808000

TARGET_NO_KERNEL := false
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
# DTB is a separate section inside the stock boot image (98725 bytes).
# Use boot_x/dtb from unpack_bootimg as prebuilt/dtb.img.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# Partition sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 131072

# Dynamic partitions
# Super size is from the stock GPT (5 GiB). The TWRP tree's 9126805504 is a
# generator placeholder, ignore it.
# Stock only has system/vendor/product; confirm with lpunpack later.
BOARD_SUPER_PARTITION_SIZE := 5368709120
BOARD_SUPER_PARTITION_GROUPS := e12_dynamic_partitions
BOARD_E12_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor

# Virtual A/B (confirmed: stock ramdisk ships snapuserd, userdata uses
# checkpoint=fs). One copy lives in super, snapshots use the free space,
# so group = super - 4 MiB.
BOARD_E12_DYNAMIC_PARTITIONS_SIZE := 5364514816

# Filesystems (TODO: confirm each against the stock images from lpunpack)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Verified boot (disabled flags until the build is known to boot)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# See device.mk for dynamic partitions, shipping API level, Virtual A/B
# and update_engine.

# Inherit vendor BoardConfig
-include vendor/e12/E12/BoardConfigVendor.mk
