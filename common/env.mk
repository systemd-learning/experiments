
CROSS_MAKE_ENV = \
	PATH=$(TOOLCHAIN)/bin:$(PATH) \
	CPPFLAGS='-I$(HOST)/$(ROOT_PREFIX)/include -L. -fPIC ' \
	CFLAGS=' -I$(HOST)/$(ROOT_PREFIX)/include -L. -fPIC ' \
	HOST_LDFLAGS=' -L$(HOST)/$(ROOT_PREFIX)/lib ' 


LOCAL_MAKE_ENV = PATH=$(PATH)
