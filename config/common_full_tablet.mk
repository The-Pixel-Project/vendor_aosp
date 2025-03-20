# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/aosp/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/aosp/config/tablet.mk)

$(call inherit-product, vendor/aosp/config/telephony.mk)
