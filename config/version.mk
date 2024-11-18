# (C) 2023-2024 MistOS

# MistOS versioning

PRODUCT_SOONG_NAMESPACES += \
    vendor/mist/version

MIST_FLAVOR := VanillaIceCream
MIST_VERSION := 3.0
MIST_CODENAME := Nebula
MIST_RELEASE_TYPE := BETA
MIST_CODE := $(MIST_VERSION)

MIST_BUILD_DATE := $(shell date -u +%Y%m%d)

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
MAINTAINER_LIST := $(shell cat mist-maintainers/mist.maintainers)
DEVICE_LIST := $(shell cat mist-maintainers/mist.devices)

ifeq ($(filter $(CURRENT_DEVICE),$(DEVICE_LIST)), $(CURRENT_DEVICE))
    ifdef MIST_MAINTAINER
        ifneq ($(filter $(MIST_MAINTAINER),$(MAINTAINER_LIST)),)
            MIST_BUILDTYPE := OFFICIAL
        else
        # Builder not an official maintainer, warn and set unofficial
        $(warning **********************************************************************)
        $(warning *   There is already an official maintainer for $(MIST_BUILD)    *)
        $(warning *              Setting build type to UNOFFICIAL                      *)
        $(warning **********************************************************************)
            MIST_BUILDTYPE := UNOFFICIAL
        endif
    else
        MIST_BUILDTYPE := UNOFFICIAL
    endif
else
    # Shouldn't reach here, error for unexpected situation
    $(error **********************************************************)
    $(error *     A violation has been detected, aborting build      *)
    $(error *              Switching to Community build              *)
    $(error **********************************************************)
    MIST_BUILDTYPE := COMMUNITY
endif

ifeq ($(WITH_GMS), true)
	ifeq ($(TARGET_CORE_GMS), true)
    	MIST_PACKAGE_TYPE ?= CORE
	else
    	MIST_PACKAGE_TYPE ?= GAPPS
	endif
else
    MIST_PACKAGE_TYPE ?= VANILLA
endif

# Build version
MIST_BUILD_VERSION := $(MIST_VERSION)-$(MIST_RELEASE_TYPE)-$(MIST_BUILD_DATE)-$(MIST_PACKAGE_TYPE)-$(MIST_BUILDTYPE)-$(CURRENT_DEVICE)

# Display version
MIST_DISPLAY_VERSION := $(MIST_VERSION)-$(MIST_RELEASE_TYPE)-$(MIST_PACKAGE_TYPE)-$(MIST_BUILDTYPE)-$(CURRENT_DEVICE)

# MistOS properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.mist.code=$(MIST_CODENAME) \
    ro.mist.packagetype=$(MIST_PACKAGE_TYPE) \
    ro.mist.releasetype=$(MIST_BUILDTYPE) \
    ro.mist.version?=$(MIST_VERSION) \
    ro.mist.build.version=$(MIST_BUILD_VERSION) \
    ro.mist.display.version?=$(MIST_DISPLAY_VERSION) \
    ro.mist.platform_release_codename=$(MIST_FLAVOR) \
    ro.mist.device=$(CURRENT_DEVICE) \
    ro.mist.storage?=$(MIST_STORAGE) \
    ro.mist.ram?=$(MIST_RAM) \
    ro.mist.battery?=$(MIST_BATTERY) \
    ro.mist.display_resolution?=$(MIST_DISPLAY)
