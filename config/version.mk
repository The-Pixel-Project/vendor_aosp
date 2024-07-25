CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_PLATFORM_VERSION := 1.0

CUSTOM_VERSION := PixelProject_$(CUSTOM_BUILD)-$(CUSTOM_BUILD_TYPE)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)
CUSTOM_VERSION_PROP := fourteen


CUSTOM_BUILD_TYPE ?= Unofficial

# Only include Updater for official  build
ifeq ($(filter-out Official,$(CUSTOM_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater

PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init/init.pixel-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.pixel-updater.rc
endif

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/aosp/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/aosp/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/aosp/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/aosp/signing/keys/otakey.x509.pem
endif
endif
