#!/usr/bin/env bash

DEPENDENCIES="\
	libsndfile \
	boost-circular-buffer \
	boost-config \
	boost-property-tree \
	boost-ptr-container \
	boost-smart-ptr \
	boost-spirit"


ROOT=`pwd`

# $@: any number of install targets

function install_with_vcpkg() {
	cd ${ROOT}
	echo `pwd`
	mkdir -p build/deps && \
	cd build/deps && \
	git clone --depth=1 https://github.com/Microsoft/vcpkg.git && \
	./vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
	cd vcpkg && \
	./vcpkg install "$@"
}


install_with_vcpkg ${DEPENDENCIES}
