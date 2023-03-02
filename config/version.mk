CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

CUSTOM_PLATFORM_VERSION := 15.0

CUSTOM_DISPLAY_VERSION := 2.0

CUSTOM_BUILD_TYPE ?= UNOFFICIAL

CUSTOM_VERSION := PixelProject_$(CUSTOM_BUILD)-$(CUSTOM_DISPLAY_VERSION)-$(CUSTOM_BUILD_TYPE)-$(CUSTOM_BUILD_DATE)

# Pixel Project Platform Version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.build.date=$(BUILD_DATE) \
    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.fingerprint=$(ROM_FINGERPRINT) \
    ro.custom.version=$(CUSTOM_VERSION) \
    ro.custom.display.version=$(CUSTOM_DISPLAY_VERSION) \
    ro.custom.releasetype=$(CUSTOM_BUILD_TYPE)

# Only include Updater for official  build
ifeq ($(filter-out OFFICIAL,$(CUSTOM_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater

PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init/init.custom-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.custom-updater.rc
endif

# Signing
ifeq (user,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard .android-certs/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := .android-certs/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard .android-certs/verity.pk8))
PRODUCT_VERITY_SIGNING_KEY := .android-certs/verity
endif
ifneq (,$(wildcard .android-certs/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := .android-certs/otakey.x509.pem
endif
endif
