#!/usr/bin/env bash

build/deps/macdylibbundler-build/dylibbundler -od -b \
	-x externals/csound~.mxo/Contents/MacOS/csound~ \
	-d externals/csound~.mxo/Contents/Frameworks \
	-p @loader_path/../Frameworks
