linux/VERSION := 5.10.65-rt53-rebase
linux/TARBALL := https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/snapshot/linux-stable-rt-$(linux/VERSION).tar.gz

linux/dir = $(BUILD)/linux/linux-$(linux/VERSION)

define linux/build :=
	+cd $(linux/dir)
	+$(MAKE) ARCH=$(ARCH) $(KCFG)
	if [ $(INITRD) -eq  1 ]; then
		sed -i 's/# CONFIG_BLK_DEV_RAM is not set/CONFIG_BLK_DEV_RAM=y/' .config
		sed -i '/CONFIG_BLK_DEV_RAM=y/a\CONFIG_BLK_DEV_RAM_COUNT=16'  .config
		sed -i '/CONFIG_BLK_DEV_RAM=y/a\CONFIG_BLK_DEV_RAM_SIZE=4096' .config
	fi

	+$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_PREFIX) $(IMG) modules dtbs -j 8
endef

define linux/install :=
	+cd $(linux/dir)
	+cp arch/$(ARCH)/boot/$(IMG) $(STAGE)
	+cp arch/$(ARCH)/boot/dts/$(DTB) $(STAGE)
	+make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_PREFIX) INSTALL_MOD_PATH=$(STAGE)/rootfs INSTALL_MOD_STRIP=1 modules_install
	+make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_PREFIX) INSTALL_HDR_PATH=$(STAGE)/rootfs headers_install
endef

