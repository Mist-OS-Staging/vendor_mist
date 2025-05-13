PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

# Increase Mist Version with each major release.
MIST_FLAVOR := VanillaIceCream
MIST_VERSION := 3.5
MIST_CODENAME := QPR2 Test
MIST_BUILD_TYPE ?= Unofficial


# Internal version
LINEAGE_VERSION := MistOS-$(MIST_VERSION)-$(MIST_CODENAME)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(MIST_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := v$(MIST_VERSION)-$(MIST_CODENAME)-$(LINEAGE_BUILD)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.mist.build.version=$(LINEAGE_VERSION) \
    ro.mist.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.mist.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(MIST_VERSION) \
    ro.mist.codename=$(MIST_CODENAME) \
    ro.mist.buildtype=$(MIST_BUILD_TYPE)
