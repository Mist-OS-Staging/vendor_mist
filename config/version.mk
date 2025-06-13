PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

# Increase Mist Version with each major release.
MIST_VERSION_DISPLAY := 3.5-Drizzle
MIST_FLAVOR := VanillaIceCream
MIST_VERSION_BASE := 3.5
MIST_CODENAME := Drizzle
MIST_BUILD_TYPE ?= Unofficial

# Mist Packages
ifeq ($(WITH_GMS),true)
  ifeq ($(TARGET_USES_MINI_GAPPS), true)
    MIST_PACKAGE_TYPE ?= MINI
  else ifeq ($(TARGET_USES_PICO_GAPPS), true)
    MIST_PACKAGE_TYPE ?= PICO
  else
    MIST_PACKAGE_TYPE ?= GAPPS
  endif
else
  MIST_PACKAGE_TYPE ?= VANILLA
endif

# Internal version
LINEAGE_VERSION := MistOS-$(MIST_VERSION_BASE)-$(MIST_CODENAME)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(MIST_PACKAGE_TYPE)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(MIST_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := MistOS-$(MIST_VERSION_BASE)-$(MIST_CODENAME)-$(MIST_PACKAGE_TYPE)-$(LINEAGE_BUILD)-$(MIST_BUILD_TYPE)-$(shell date +%Y%m%d)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.mist.build.version=$(LINEAGE_VERSION) \
    ro.mist.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.mist.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(MIST_VERSION) \
    ro.mist.packagetype=$(MIST_PACKAGE_TYPE) \
    ro.mist.version_display=$(MIST_VERSION_DISPLAY) \
    ro.mist.version.base=$(MIST_VERSION_BASE) \
    ro.mistos.maintainer=$(MISTOS_MAINTAINER) \
    ro.mistos.flavor=$(MIST_FLAVOR) \
    ro.mist.codename=$(MIST_CODENAME) \
    ro.mist.buildtype=$(MIST_BUILD_TYPE)
