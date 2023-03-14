SHELL := /bin/bash
libcap/VERSION := 2.65
libcap/TARBALL := https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-$(libcap/VERSION).tar.xz

libcap/dir = $(BUILD)/libcap/libcap-$(libcap/VERSION)
include $(BASE)/../common/env.mk

define libcap/build :=
	+cd $(libcap/dir)
	if [ $(LOCAL_BUILD) -eq 1 ]; then
		+$(LOCAL_MAKE_ENV) make prefix='$(HOST)' install
	else
		+$(CROSS_MAKE_ENV) make CROSS_COMPILE='$(CROSS_PREFIX)' BUILD_CC=/usr/bin/gcc  LDFLAGS='-L$(HOST)/sysroot ' prefix='$(HOST)/sysroot' install
	fi
endef

define libcap/install :=
endef
