#!/bin/env bash


mkdir -p cpython/builddir/emscripten-browser

# install emcc ports so configure is able to detect the dependencies
embuilder build zlib

pushd cpython/builddir/emscripten-browser
CONFIG_SITE=../../Tools/wasm/config.site-wasm32-emscripten \
  emconfigure ../../configure -C \
    --host=wasm32-unknown-emscripten \
    --build=$(../../config.guess) \
    --with-emscripten-target=browser \
    --with-build-python=$(pwd)/../build/python

emmake make -j$(nproc)

popd
