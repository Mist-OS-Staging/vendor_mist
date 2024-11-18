# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
# Copyright (C) 2024 risingOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# MistOS OTA update package

MIST_TARGET_PACKAGE := $(PRODUCT_OUT)/MistOS-$(MIST_BUILD_VERSION)-ota.zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bacon
bacon: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(MIST_TARGET_PACKAGE)
	$(hide) $(SHA256) $(MIST_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(MIST_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/mist/build/tasks/ascii_output.sh
	@echo ""
	@echo "Creating json OTA..." >&2
	$(hide) ./vendor/mist/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) MistOS-$(MIST_BUILD_VERSION)-ota.zip $(MIST_VERSION) $(MIST_CODENAME) $(MIST_PACKAGE_TYPE) $(MIST_RELEASE_TYPE)
	$(hide) cp -f $(PRODUCT_OUT)/$(MIST_PACKAGE_TYPE)_$(TARGET_DEVICE).json vendor/mistOTA/$(MIST_PACKAGE_TYPE)_$(TARGET_DEVICE).json
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo " Size            : $(shell du -hs $(MIST_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Size(in bytes)  : $(shell wc -c $(MIST_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Package Complete: $(MIST_TARGET_PACKAGE)" >&2
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo ""
