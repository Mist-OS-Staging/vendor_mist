
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
