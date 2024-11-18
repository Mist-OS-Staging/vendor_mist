PRODUCT_SOONG_NAMESPACES += \
    vendor/mist/packages

# /system_ext packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    androidx.window.sidecar

PRODUCT_PACKAGES += \
    Backgrounds \
    BatteryStatsViewer \
    OmniStyle \
    OmniJaws \
    Updater \
    GameSpace

ifneq ($(WITH_GMS),true)
PRODUCT_PACKAGES += \
    LatinIME
endif
