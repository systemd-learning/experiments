SHELL := /bin/bash

export BASE := $(PWD)
export DOWNLOAD := $(BASE)/../download
export TOOLCHAIN := $(BASE)/toolchain
export WORK := $(BASE)/work
export OUTPUT := $(BASE)/output
export STATE := $(BASE)/state
export STAGE := $(BASE)/staging
export BUILD := $(BASE)/build
export HOST := $(BASE)/host

export ARCH=arm64
export KCFG=defconfig
export IMG=Image.gz
export DTB=arm/vexpress-v2f-1xv7-ca53x2.dtb
export CROSS_PREFIX=aarch64-none-linux-gnu-

all: packages_host
	$(info "generating image ...")
	#+cp $(STAGE)/$(IMG) $(OUT)/
	#+source ../common/utils.sh && make_initramfs $(STAGE) $(OUT) rootfs.gz
	#$(info "success.")

packages_host: packages_build
	$(info "building dependent packages ...")
	$(info "building dependent packages ...")
	'$(MAKE)' -f ../common/package.mk PACKAGES=linux
	'$(MAKE)' -f ../common/package.mk PACKAGES=glibc
	'$(MAKE)' -f ../common/package.mk PACKAGES=busybox
	'$(MAKE)' -f ../common/package.mk PACKAGES=pkgconf
	'$(MAKE)' -f ../common/package.mk PACKAGES=libcap
#	'$(MAKE)' -f ../common/package.mk PACKAGES=systemd

packages_build: toolchain
	$(info "building dependent packages ...")
	'$(MAKE)' -f ../common/package.mk PACKAGES=pkgconf LOCAL_BUILD=1
	'$(MAKE)' -f ../common/package.mk PACKAGES=libcap LOCAL_BUILD=1
#	'$(MAKE)' -f ../common/package.mk PACKAGES=systemd

toolchain:
	$(info "preparing toolchain ...")
	'$(MAKE)' -f ../common/package.mk PACKAGES=toolchain_arm64

clean:
	'$(MAKE)' -f ../common/package.mk clean
