#!/usr/bin/env bash

ROOT=`pwd`

# $1 NAME
# $2 REPO
# $3 CMAKE-OPTS

function build_external_dep() {
	src_dir="${1}-src"
	build_dir="${1}-build"
	install_dir="${1}-install"
	cd ${ROOT}
	echo `pwd`
	mkdir -p build/deps
	cd build/deps
	if [ -d ${src_dir} ] 
		then rm -rf %{build_dir} ${install_dir} 
	else 
		git clone --depth=1 ${2} ${1}-src
	fi
	mkdir -p ${1}-build
	cd ${1}-build
	cmake ${3} ../${1}-src
	make
	cmake --install . --prefix `pwd`/../${1}-install
}

build_external_dep \
	csound \
	https://github.com/csound/csound.git \
	"-DBUILD_STATIC_LIBRARY=ON -DUSE_GETTEXT=OFF -DBUILD_TESTS=OFF"
