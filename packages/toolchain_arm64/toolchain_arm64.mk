ARM64_CROSS_VER=gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu

toolchain_arm64/VERSION := 11.2
toolchain_arm64/TARBALL := https://mirrors.tuna.tsinghua.edu.cn/armbian-releases/_toolchain/$(ARM64_CROSS_VER).tar.xz
toolchain_arm64/dir = $(BUILD)/toolchain_arm64/$(ARM64_CROSS_VER)

define toolchain_arm64/build :=
endef

define toolchain_arm64/install :=
	$(info TOOLCHAIN: $(TOOLCHAIN))
	$(info BUILD: $(BUILD))
	rm -fr $(TOOLCHAIN)/
	ln -s  $(toolchain_arm64/dir) $(TOOLCHAIN)
endef
