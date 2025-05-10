PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0

# Increase MistOS Version with each major release.
MIST_FLAVOR := VanillaIceCream
MIST_RELEASE_TYPE := Stable
MIST_VERSION := 3.5
MIST_CODENAME := Testing
MIST_BUILD_INFO := $(LINEAGE_VERSION)
MIST_BUILD_TYPE ?= UNOFFICIAL

ifeq ($(WITH_GMS), true)
  MIST_BUILD_VARIANT := Gapps
else
  MIST_BUILD_VARIANT := Vanilla
endif

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
-include vendor/lineage-priv/keys/keys.mk
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

# Internal version
LINEAGE_VERSION := MistOS-$(MIST_VERSION)-$(MIST_RELEASE_TYPE).$(PRODUCT_VERSION_MAJOR)-$(LINEAGE_BUILD)-$(MIST_BUILD_VARIANT)-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := MistOS-v$(MIST_VERSION)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)

# Mist properties
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.mist.battery?=$(MIST_BATTERY) \
    ro.mist.code=$(MIST_CODENAME) \
    ro.mist.platform_release_codename=$(MIST_FLAVOR) \
    ro.mist.build.variant=$(MIST_BUILD_VARIANT) \
    ro.mist.build.version=$(LINEAGE_VERSION) \
    ro.mist.chipset?=$(MIST_CHIPSET) \
    ro.mist.display_resolution?=$(MIST_DISPLAY) \
    ro.mist.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.mist.maintainer=$(MIST_MAINTAINER) \
    ro.mist.release.type=$(MIST_BUILD_TYPE) \
    ro.mist.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(MIST_VERSION)
