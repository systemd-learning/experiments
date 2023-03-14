SHELL := /bin/bash
DOWNLOAD := $(DOWNLOAD)
STATE := $(STATE)
ROOT_PREFIX ?= sysroot
export LOCAL_BUILD ?= 0

.PHONY: all
-include $(BASE)/../packages/*/*.mk

depends = $(subst $(BASE),./,$(STATE))/dep.$1.$2

define depfile =
	mkdir -p '$(STATE)'
	touch '$(BASE)/$(call depends,$1,$2)'
endef

#############################################
# Dynamically declare dependencies between packages
#############################################
define declaredeps =
	$(eval .PHONY: $1)
	$(eval $1: $(call depends,$1,package))
	$(eval $(call depends,$1,package) : $(call depends,$1,install) ; $(call packagepkg,$1) )
	$(eval $(call depends,$1,install) : $(call depends,$1,build)   ; $(call installpkg,$1) )
	$(eval $(call depends,$1,build)   : $(call depends,$1,prepare) ; $(call buildpkg,$1)   )
	$(eval $(call depends,$1,prepare) : $(call depends,$1,download); $(call preparepkg,$1) )
	$(eval $(call depends,$1,download):                            ; $(call downloadpkg,$1))

	$(eval $(call depends,$1,build)   : $(foreach dep,$($1/DEPENDS),$(call depends,$(dep),install)))
	$(foreach dep,$($1/DEPENDS),$(call declareonce,$(dep)))
endef

define declaredeps_local =
	$(eval .PHONY: local_$1)
	$(eval local_$1: $(call depends,local_$1,package))
	$(eval $(call depends,local_$1,package) : $(call depends,local_$1,install) ; $(call packagepkg,local_$1) )
	$(eval $(call depends,local_$1,install) : $(call depends,loacl_$1,build)   ; $(call installpkg,local_$1) )
	$(eval $(call depends,local_$1,build)   : $(call depends,local_$1,prepare) ; $(call buildpkg,local_$1)   )
	$(eval $(call depends,local_$1,prepare) : $(call depends,local_$1,download); $(call preparepkg,local_$1) )
	$(eval $(call depends,local_$1,download):                            ; $(call downloadpkg,$1))

	$(eval $(call depends,local_$1,build)   : $(foreach dep,$(local_$1/DEPENDS),$(call depends,$(dep),install)))
	$(foreach dep,$(local_$1/DEPENDS),$(call declareonce,$(dep)))
endef

       $(if $($1_done),,$(call declaredeps,$1) $(eval $1_done=1))

define declareonce_xxx =
	$(info xxx)
	$(if '$2',$(if $(local_$1_doe),,$(call declaredeps_local,$1) $(eval local_$1_done=1)),$(if $($1_done),,$(call declaredeps,$1) $(eval $1_done=1)))
endef

.SHELLFLAGS = -e -c
.ONESHELL:

#############################################
# Macros for specific stages
#############################################
define downloadpkg =
	mkdir -p '$(DOWNLOAD)'
	cd '$(DOWNLOAD)'
	$(info DOWNLOAD: $(DOWNLOAD)/$(notdir $($1/TARBALL)))
	if [ -n '$($1/TARBALL)' ]; then
		if [ ! -f $(notdir $($1/TARBALL)) ]; then
			wget '$($1/TARBALL)' -O- > '$(DOWNLOAD)/$(notdir $($1/TARBALL))'
		fi
	fi
	$(call depfile,$1,download)
endef

define preparepkg =
	mkdir -p '$(BUILD)/$1'
	cd '$(BUILD)/$1'
	if [ -n '$($1/TARBALL)' ]; then
		mkdir -p $($1/dir)
		tar -xf '$(DOWNLOAD)/$(notdir $($1/TARBALL))' --strip-components=1  -C $($1/dir)
	fi
	$(call depfile,$1,prepare)
endef

define buildpkg =
	mkdir -p '$(HOST)'
	$(call $1/build)
	$(call depfile,$1,build)
endef

define installpkg =
	$(call $1/install)
	$(call depfile,$1,install)
endef

define packagepkg =
	mkdir -p '$(OUTPUT)'
	$(call $1/package)
	$(call depfile,$1,package)
endef

#############################################
# Targets
#############################################
all: $(PACKAGES)

# Import dependencies between packages and package stages
$(foreach pkg,$(PACKAGES),$(call declareonce_xxx,$(pkg) $2))

clean:
	rm -rf '$(DOWNLOAD)' '$(STATE)' '$(STAGE)' '$(OUTPUT)' '$(BUILD)'

