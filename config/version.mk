PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

# Increase Mist Version with each major release.
MIST_VERSION_DISPLAY := 3.5-Drizzle
MIST_FLAVOR := VanillaIceCream
MIST_VERSION_BASE := 3.5
MIST_CODENAME := Drizzle
MIST_BUILD_TYPE ?= Unofficial

ifeq ($(WITH_GMS),true)
MIST_VERSION := $(MIST_VERSION_BASE)-GApps
else
MIST_VERSION := $(MIST_VERSION_BASE)-Vanilla
endif

# Internal version
LINEAGE_VERSION := MistOS-$(MIST_VERSION)-$(MIST_CODENAME)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(MIST_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := MistOS-$(MIST_VERSION)-$(MIST_CODENAME)-$(LINEAGE_BUILD)-$(MIST_BUILD_TYPE)-$(shell date +%Y%m%d)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.mist.build.version=$(LINEAGE_VERSION) \
    ro.mist.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.mist.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(MIST_VERSION) \
    ro.mist.version_display=$(MIST_VERSION_DISPLAY) \
    ro.mist.version.base=$(MIST_VERSION_BASE) \
    ro.mistos.maintainer=$(MISTOS_MAINTAINER) \
    ro.mistos.flavor=$(MIST_FLAVOR) \
    ro.mist.codename=$(MIST_CODENAME) \
    ro.mist.buildtype=$(MIST_BUILD_TYPE)
