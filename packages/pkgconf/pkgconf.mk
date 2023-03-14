SHELL := /bin/bash
pkgconf/VERSION := 1.9.4
pkgconf/TARBALL := https://distfiles.dereferenced.org/pkgconf/pkgconf-$(pkgconf/VERSION).tar.gz

pkgconf/dir = $(BUILD)/pkgconf/pkgconf-$(pkgconf/VERSION)
include $(BASE)/../common/env.mk

define pkgconf/build :=
	$(info PATH=$(PATH))
	+cd $(pkgconf/dir)
	+mkdir -p build && cd build
	if [ $(LOCAL_BUILD) -eq  1 ]; then
		+$(LOCAL_MAKE_ENV) ../configure --prefix='$(HOST)'
	else
		+$(CROSS_MAKE_ENV) ../configure --host=aarch64-linux CC='$(TOOLCHAIN)/bin/$(CROSS_PREFIX)gcc' LDFLAGS='-L$(HOST)/sysroot' --with-sysroot='$(HOST)/sysroot' --prefix='$(HOST)/sysroot'
	fi
	'$(MAKE)' -j 8
endef

define pkgconf/install :=
	+cd $(pkgconf/dir)/build
	+'$(MAKE)' install
endef
