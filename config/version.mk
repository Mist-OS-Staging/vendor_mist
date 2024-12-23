# (C) 2023-2024 MistOS

# MistOS versioning

PRODUCT_SOONG_NAMESPACES += \
    vendor/mist/version

MIST_FLAVOR := VanillaIceCream
MIST_VERSION := 3.0.1
MIST_CODENAME := Haze
MIST_RELEASE_TYPE := BETA
MIST_CODE := $(MIST_VERSION)

MIST_BUILD_TYPE ?= UNOFFICIAL

MIST_BUILD_DATE := $(shell date -u +%Y%m%d)

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
OFFICIAL_MAINTAINERS := $(shell cat mist-maintainers/mist.maintainers)
OFFICIAL_DEVICES := $(shell cat mist-maintainers/mist.devices)

ifeq ($(findstring $(LINEAGE_BUILD), $(OFFICIAL_DEVICES)),)
  # Device not listed as official
  MIST_BUILD_TYPE := UNOFFICIAL
else
  # Check if builder is an official maintainer
  ifeq ($(findstring $(MISTOS_MAINTAINER), $(OFFICIAL_MAINTAINERS)),)
    # Builder not an official maintainer, warn and set unofficial
    $(warning **********************************************************************)
    $(warning *   There is already an official maintainer for $(LINEAGE_BUILD)    *)
    $(warning *              Setting build type to UNOFFICIAL                      *)
    $(warning **********************************************************************)
    MIST_BUILD_TYPE := UNOFFICIAL
  else
    # Official maintainer building official device
    MIST_BUILD_TYPE := OFFICIAL
  endif
endif

# Enforce official build for official maintainers on official devices
ifeq ($(MIST_BUILD_TYPE), OFFICIAL)
  ifeq ($(findstring $(LINEAGE_BUILD), $(OFFICIAL_DEVICES)),)
    # Shouldn't reach here, error for unexpected situation
    $(error **********************************************************)
    $(error *     A violation has been detected, aborting build      *)
    $(error **********************************************************)
  endif
endif

ifeq ($(WITH_GMS), true)
    	MIST_PACKAGE_TYPE ?= GAPPS
else
    MIST_PACKAGE_TYPE ?= VANILLA
endif

# Build version
MIST_BUILD_VERSION := $(MIST_VERSION)-$(MIST_RELEASE_TYPE)-$(MIST_BUILD_TYPE)-$(MIST_BUILD_DATE)-$(MIST_PACKAGE_TYPE)-$(CURRENT_DEVICE)

# Display version
MIST_DISPLAY_VERSION := $(MIST_VERSION)-$(MIST_RELEASE_TYPE)-$(MIST_PACKAGE_TYPE)-$(MIST_BUILD_TYPE)-$(CURRENT_DEVICE)

# MistOS properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.mist.code=$(MIST_CODENAME) \
    ro.mist.packagetype=$(MIST_PACKAGE_TYPE) \
    ro.mist.releasetype=$(MIST_BUILDTYPE) \
    ro.mist.buildtype=$(MIST_BUILD_TYPE) \
    ro.mistos.maintainer=$(MISTOS_MAINTAINER) \
    ro.mist.version?=$(MIST_VERSION) \
    ro.mist.build.version=$(MIST_BUILD_VERSION) \
    ro.mist.display.version?=$(MIST_DISPLAY_VERSION) \
    ro.mist.platform_release_codename=$(MIST_FLAVOR) \
    ro.mist.device=$(CURRENT_DEVICE) \
    ro.mist.storage?=$(MIST_STORAGE) \
    ro.mist.ram?=$(MIST_RAM) \
    ro.mist.battery?=$(MIST_BATTERY) \
    ro.mist.display_resolution?=$(MIST_DISPLAY)
