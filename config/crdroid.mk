# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=comet_beta \
    persist.sys.pihooks_DEVICE?=comet \
    persist.sys.pihooks_ID?=BP41.250916.010.A1 \
    persist.sys.pihooks_RELEASE?=12 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-10-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21 \
    persist.sys.pihooks_SDK_INT?=32

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildFingerprint=google/comet_beta/comet:16/BP41.250916.010.A1/14281945:user/release-keys \
    PihooksGmsFp="google/comet_beta/comet:16/BP41.250916.010.A1/14281945:user/release-keys" \
    PihooksGmsModel="Pixel 9 Pro Fold"

# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.google.ime.theme_id=5 \
    ro.opa.eligible_device=true \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.setupwizard.mode=OPTIONAL \
    setupwizard.feature.predeferred_enabled=false \
    drm.service.enabled=true \
    persist.sys.dun.override=0 \
    persist.sys.disable_rescue=true

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Disable default frame rate limit for games
PRODUCT_PRODUCT_PROPERTIES += \
    debug.graphics.game_default_frame_rate.disabled=true

# Blurs
ifeq ($(TARGET_ENABLE_BLUR), true)
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

PRODUCT_PRODUCT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-crdroid-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-crdroid-product.xml

# ColumbusService
ifneq ($(TARGET_SUPPORTS_QUICK_TAP),false)
PRODUCT_PACKAGES += \
    ColumbusService
endif

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Enable dex2oat64 to do dexopt
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=true

# Extra packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    LMOFreeform \
    LMOFreeformSidebar \
    OmniJaws \
    OmniStyle

ifneq ($(TARGET_DISABLE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED),false)
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

# Updater
ifeq ($(MIST_BUILD_TYPE),OFFICIAL)
PRODUCT_PACKAGES += \
    Updater
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
