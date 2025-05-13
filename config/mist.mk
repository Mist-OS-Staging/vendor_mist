
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

# MistOS Props

ifeq ($(MIST_BUILD_TYPE),OFFICIAL)
PRODUCT_PACKAGES += \
    Updater
endif

# Private keys
ifeq ($(MIST_BUILD_TYPE),OFFICIAL)
include vendor/mist-priv/keys/keys.mk
else
-include vendor/mist-priv/keys/keys.mk
endif
