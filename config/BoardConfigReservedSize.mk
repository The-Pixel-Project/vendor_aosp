# SPDX-FileCopyrightText: 2023-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

ifeq ($(PRODUCT_VIRTUAL_AB_OTA),true)
    BOARD_PRODUCTIMAGE_MINIMAL_PARTITION_RESERVED_SIZE ?= true
endif

ifeq ($(AB_OTA_UPDATER),false)
    BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE ?= 52428800
endif
