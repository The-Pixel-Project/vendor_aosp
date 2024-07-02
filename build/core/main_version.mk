# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# PixelProject Platform Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    org.pixelproject.build.date=$(BUILD_DATE) \
    org.pixelproject.fingerprint=$(ROM_FINGERPRINT) \
    org.pixelproject.version=$(CUSTOM_VERSION) \
    org.pixelproject.device=$(CUSTOM_BUILD) \
    org.pixelproject.buildtype=$(CUSTOM_BUILD_TYPE) \
    org.pixelproject.base.version=$(CUSTOM_PLATFORM_VERSION) \
    ro.modversion=$(CUSTOM_VERSION)
