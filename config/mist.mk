# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=cheetah_beta \
    persist.sys.pihooks_DEVICE?=cheetah \
    persist.sys.pihooks_ID?=BP22.250325.007 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-04-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/cheetah_beta/cheetah:16/BP22.250325.007/13352765:user/release-keys" \
    PihooksGmsModel="Pixel 7 Pro"

# MistOS packages
PRODUCT_PACKAGES += \
    GameSpace \
    OmniJaws \
    OmniStyle

# BtHelper
PRODUCT_PACKAGES += \
    BtHelper

# GMS
WITH_GMS ?= true
ifeq ($(WITH_GMS),true)
ifeq ($(TARGET_USES_MINI_GAPPS),true)
$(call inherit-product, vendor/gms/gms_mini.mk)
else ifeq ($(TARGET_USES_PICO_GAPPS),true)
$(call inherit-product, vendor/gms/gms_pico.mk)
else
$(call inherit-product, vendor/gms/gms_full.mk)
endif
endif

# Enable blur
TARGET_ENABLE_BLUR ?= true
ifeq ($(TARGET_ENABLE_BLUR),true)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=true
endif

# Face Unlock
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
endif

# ColumbusService
ifneq ($(TARGET_SUPPORTS_QUICK_TAP),false)
PRODUCT_PACKAGES += \
    ColumbusService
endif

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-mist-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-mist-product.xml

# MistOS Props
#PRODUCT_PACKAGES += \
#    Updater

#ifeq ($(WITH_GMS),false)
#PRODUCT_PACKAGES += \
#    UpdaterVanillaOverlay
#endif

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Private keys
ifeq ($(MIST_BUILD_TYPE),OFFICIAL)
include vendor/mist-priv/keys/keys.mk
else
-include vendor/mist-priv/keys/keys.mk
endif

BYPASS_CHARGE_SUPPORTED ?= false
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.battery_bypass_supported=$(BYPASS_CHARGE_SUPPORTED)
