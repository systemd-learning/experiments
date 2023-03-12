SHELL := /bin/bash
busybox/VERSION := 1.33.2
busybox/TARBALL := https://busybox.net/downloads/busybox-$(busybox/VERSION).tar.bz2

busybox/dir = $(BUILD)/busybox/busybox-$(busybox/VERSION)

define busybox/build :=
	+cd $(busybox/dir)
	+'$(MAKE)' ARCH=arm defconfig
	if [ $(STATIC) -eq  1 ]; then
		sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/g' .config
	else
		sed -i 's|CONFIG_SYSROOT=""|CONFIG_SYSROOT="$(STAGE)/rootfs"|g' .config
	fi
	+'$(MAKE)' ARCH=arm CROSS_COMPILE='$(CROSS_PREFIX)' CONFIG_PREFIX='$(STAGE)/rootfs' install -j 8
endef

define busybox/install :=
endef
