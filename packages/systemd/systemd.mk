SHELL := /bin/bash
systemd/VERSION := 253.1
systemd/TARBALL := https://github.com/systemd/systemd-stable/archive/refs/tags/v$(systemd/VERSION).tar.gz

systemd/dir = $(BUILD)/systemd/systemd-$(systemd/VERSION)

# meson setup --prefix=/usr --libdir=lib --default-library=shared --buildtype=release --cross-file=./cross.txt -Db_pie=false -Dstrip=false -Dbuild.pkg_config_path=/mnt_sdb/git/buildroot/output/host/lib/pkgconfig -Dbuild.cmake_prefix_path=/mnt_sdb/git/buildroot/output/host/lib/cmake -Ddbus=false -Ddbus-interfaces-dir=no -Ddefault-compression='auto' -Ddefault-hierarchy=unified -Ddefault-locale='C.UTF-8' -Ddefault-user-shell=/bin/sh -Dfirst-boot-full-preset=false -Didn=true -Dima=false -Dkexec-path=/usr/sbin/kexec -Dkmod-path=/usr/bin/kmod -Dldconfig=false -Dlink-boot-shared=true -Dloadkeys-path=/usr/bin/loadkeys -Dman=false -Dmount-path=/usr/bin/mount -Dmode=release -Dnspawn-locale='C.UTF-8' -Dnss-systemd=true -Dquotacheck-path=/usr/sbin/quotacheck -Dquotaon-path=/usr/sbin/quotaon -Drootlibdir='/usr/lib' -Dsetfont-path=/usr/bin/setfont -Dsplit-bin=true -Dsplit-usr=false -Dsulogin-path=/usr/sbin/sulogin -Dsystem-gid-max=999 -Dsystem-uid-max=999 -Dsysvinit-path= -Dsysvrcnd-path= -Dtelinit-path= -Dtests=false -Dtmpfiles=true -Dumount-path=/usr/bin/umount -Dacl=false -Durlify=false -Dapparmor=false -Daudit=false -Dlibcryptsetup=false -Dlibcryptsetup-plugins=false -Delfutils=false -Dlibiptc=false -Dlibidn=false -Dlibidn2=false -Dseccomp=false -Dxkbcommon=false -Dbzip2=false -Dzstd=false -Dlz4=false -Dpam=false -Dfdisk=false -Dxz=false -Dzlib=false -Dlibcurl=false -Dgcrypt=false -Dp11kit=false -Dpcre2=false -Dblkid=true -Dnologin-path=/bin/false -Dinitrd=false -Dkernel-install=false -Danalyze=false -Dremote=false -Dmicrohttpd=false -Dqrencode=false -Dselinux=false -Ddefault-dnssec=no -Dhwdb=true -Dbinfmt=false -Dutmp=false -Dvconsole=true -Dquotacheck=false -Dsysusers=false -Dfirstboot=false -Drandomseed=false -Dbacklight=false -Drfkill=false -Dlogind=false -Dmachined=false -Dnss-mymachines=false -Dimportd=false -Dhomed=false -Dhostnamed=true -Dnss-myhostname=true -Dtimedated=true -Dlocaled=false -Drepart=false -Duserdb=false -Dcoredump=false -Dpstore=true -Doomd=false -Dpolkit=false -Dportabled=false -Dsysext=false -Dsysupdate=false -Dnetworkd=true -Dnss-resolve=true -Dresolve=true -Dgnutls=false -Dopenssl=false -Ddns-over-tls=false -Ddefault-dns-over-tls=no -Dtimesyncd=true -Dsmack=false  -Dhibernate=false /mnt_sde/git/little-experiments/packages/systemd     /mnt_sde/git/little-experiments/packages/systemd/build

define systemd/build :=
	$(info PATH=$(PATH))
	+cd $(systemd/dir)
	+mkdir -p build && cd build
	../configure --host=aarch64-linux CC='$(TOOLCHAIN)/bin/$(CROSS_PREFIX)gcc' LDFLAGS='-L$(STAGE)/rootfs' --with-sysroot='$(STAGE)/rootfs' --prefix='$(STAGE)/rootfs'
	+'$(MAKE)' -j 8
endef

define systemd/install :=
	+cd $(systemd/dir)/build
	$(warn "not implemented!")
endef
