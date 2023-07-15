SCRIPTS := source/scripts
DEPS := build/deps
CONFIG := "Release" # or Debug
CSOUND_EXTERNAL := externals/csound~.mxo
VCPKG_ROOT := $(DEPS)/vcpkg
VCPKG_CMAKE := $(VCPKG_ROOT)/scripts/buildsystems/vcpkg.cmake
 
DYLIB_BUNDLER := $(DEPS)/macdylibbundler-build/dylibbundler
LIBCSND6 := $(DEPS)/csound-build/libcsnd6.a
VCPKG := $(DEPS)/vcpkg/vcpkg

.PHONY: build hybrid release install-vcpkg build-external \
		clean clean-build clean-external reset setup 

# build   -> csound.mxo
# hybrid  -> download csound -> libcsnd6.a -> csound.mxo -> csound.mxo (fixed)
# release -> vcpkg -> libsndfile.a (+deps) -> libcsnd6.a -> csound.mxo

all: build

build: clean-externals
	@mkdir -p build && cd build && cmake -GXcode .. && \
		cmake --build . --config '$(CONFIG)'

hybrid: clean-externals $(CSOUND_EXTERNAL) $(DYLIB_BUNDLER)
	@bash $(SCRIPTS)/fix_bundle.sh

build-external: $(CSOUND_EXTERNAL)

$(DYLIB_BUNDLER):
	@bash $(SCRIPTS)/install_macdylibbundler.sh

$(CSOUND_EXTERNAL): $(LIBCSND6)
	@mkdir -p build && cd build && cmake -GXcode -DBUILD_HYBRID=ON .. && \
		cmake --build . --config '$(CONFIG)'

$(LIBCSND6):
	@bash $(SCRIPTS)/install_csound.sh

install-vcpkg: $(VCPKG)

$(VCPKG):
	@bash $(SCRIPTS)/install_vcpkg.sh

release: clean-externals $(LIBCSND6) $(VCPKG)
	@mkdir -p build && cd build && cmake -GXcode -DBUILD_RELEASE=ON -DENABLE_VCPKG=ON  .. && \
		cmake --build . --config '$(CONFIG)'

windows: clean-externals
	@mkdir -p build && cd build && cmake -GNinja \
		-DCMAKE_TOOLCHAIN_FILE=$(VCPKG_CMAKE) .. && \
		cmake --build . --config '$(CONFIG)'


clean: clean-build

clean-build:
	@rm -rf build

clean-externals:
	@rm -rf externals

reset: clean-externals clean-build

setup:
	git submodule init
	git submodule update
	ln -s $(shell pwd) "$(HOME)/Documents/Max 8/Packages/$(shell basename `pwd`)"
