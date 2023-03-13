SHELL := /bin/bash
glibc/VERSION := 2.37
glibc/TARBALL := https://mirrors.aliyun.com/gnu/glibc/glibc-$(glibc/VERSION).tar.gz

glibc/dir = $(BUILD)/glibc/glibc-$(glibc/VERSION)

define glibc/build :=
	+cd $(glibc/dir)
	$(info glibc/dir: $(glibc/dir))
	+mkdir -p build && cd build
	../configure aarch64-none-linux-gnu --target=aarch64-none-linux-gnu CFLAGS="-O2 " --build=x86_64-pc-linux-gnu --prefix=  --enable-add-ons
	+'$(MAKE)' -j 8
endef

define glibc/install :=
	+'$(MAKE)' install -C '$(glibc/dir)/build' install_root='$(HOST)/sysroot'
endef
