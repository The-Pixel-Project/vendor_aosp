#
# Aosp Audio Files
#

ALARM_PATH := vendor/aosp/prebuilt/common/media/audio/alarms
NOTIFICATION_PATH := vendor/aosp/prebuilt/common/media/audio/notifications
RINGTONE_PATH := vendor/aosp/prebuilt/common/media/audio/ringtones
UI_PATH := vendor/aosp/prebuilt/common/media/audio/ui

# UI
PRODUCT_COPY_FILES += \
	$(UI_PATH)/screenshot.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/screenshot.ogg

