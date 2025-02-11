-include vendor/pixel-framework/config.mk
-include vendor/addons/config.mk
WITH_GMS ?= false
ifeq ($(WITH_GMS),true)
-include vendor/gms/products/gms.mk
endif
include vendor/mist/config/properties.mk
include vendor/mist/config/packages.mk
include vendor/mist/config/version.mk
include vendor/mist/audio/audio.mk
include vendor/mist/overlays/build.mk
include vendor/mist/prebuilts/prebuilts.mk
ifeq ($(WITH_PIXEL_OVERLAYS),true)
-include vendor/pixeloverlays/config.mk
endif
-include vendor/google/mainline_modules/config.mk


PRODUCT_SOONG_NAMESPACES += \
    vendor/mist/common

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

# Dexopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    NexusLauncherRelease \
    Settings

# Product Copy
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

ifeq ($(LINEAGE_BUILD),)
# Extracted APN's from Cheetah
PRODUCT_COPY_FILES += \
    vendor/mist/prebuilts/apn/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml
endif

TARGET_SHIP_LEGACY_BOOT_ANIMAITON ?= false
ifeq ($(TARGET_SHIP_LEGACY_BOOT_ANIMAITON),true)
PRODUCT_COPY_FILES += vendor/mist/prebuilts/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

# TFLite service.
PRODUCT_PACKAGES += libtensorflowlite_jni

# Disable default frame rate limit for games
PRODUCT_PRODUCT_PROPERTIES += \
    debug.graphics.game_default_frame_rate.disabled=true

# Allow TFLite service modules to be installed to the system partition
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/lib/libtensorflowlite_jni.so \
 	system/lib64/libtensorflowlite_jni.so

$(call inherit-product, vendor/mist/config/vars.mk)
