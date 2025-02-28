# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Bootlin

define KernelPackage/rtlsdio-8723ds
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=Realtek RTL8723DS support
  FILES:= $(LINUX_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723ds.ko \
		$(LINUX_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_sdio.ko \
		$(LINUX_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723d.ko \
		$(LINUX_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
  KCONFIG:=CONFIG_RTW88_8723DS CONFIG_RTW88=y
  DEPENDS:=@TARGET_thead
  AUTOLOAD:=$(call AutoProbe,rtw88_8723ds)
endef

$(eval $(call KernelPackage,rtlsdio-8723ds))

