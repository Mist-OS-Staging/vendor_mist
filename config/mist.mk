PRODUCT_PACKAGES += \
    Updater \
    GameSpace \
    BtHelper

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
endif

# GMS
WITH_GMS ?= false
ifeq ($(WITH_GMS),true)
  ifeq ($(TARGET_USES_MINI_GAPPS),true)
    $(call inherit-product, vendor/gms/gms_mini.mk)
  else
    ifeq ($(TARGET_USES_PICO_GAPPS),true)
      $(call inherit-product, vendor/gms/gms_pico.mk)
  else
      $(call inherit-product, vendor/gms/gms_full.mk)
    endif
  endif
endif

# Google Overlays
PRODUCT_PACKAGES += \
    CustomFontPixelLauncherOverlay

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Face Unlock
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=tangorpro_beta \
    persist.sys.pihooks_DEVICE?=tangorpro \
    persist.sys.pihooks_ID?=BP31.250523.006 \
    persist.sys.pihooks_RELEASE?=16 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-05-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21 \
    persist.sys.pihooks_SDK_INT?=35

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/tangorpro_beta/tangorpro:16/BP31.250523.006/13607978:user/release-keys" \
    PihooksGmsModel="Pixel Tablet"
