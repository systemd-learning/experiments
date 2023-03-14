ARM32_CROSS_VER=gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf
DOWNLOAD := $(DOWNLOAD)/toolchain
STATE := $(STATE)/toolchain

toolchain_arm32/VERSION := 11.2
toolchain_arm32/TARBALL := https://mirrors.tuna.tsinghua.edu.cn/armbian-releases/_toolchain/$(ARM32_CROSS_VER).tar.xz
toolchain_arm32/dir = $(BUILD)/toolchain_arm32/$(ARM32_CROSS_VER)

define toolchain_arm32/build :=
endef

define toolchain_arm32/install :=
	$(info TOOLCHAIN: $(TOOLCHAIN))
	$(info BUILD: $(BUILD))
	rm -f  $(TOOLCHAIN)/
	ln -s  $(toolchain_arm32/dir) $(TOOLCHAIN)
endef
