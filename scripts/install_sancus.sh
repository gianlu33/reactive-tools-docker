#!/bin/bash

set -eux

function make_repo() {
  cd $1
  mkdir build
  cd build
  cmake .. -DSECURITY=$2 -DMASTER_KEY=$3
  make
  make install
  cd ..
  cd ..
}

apt-get update && apt-get install -y --no-install-recommends make git \
  lsb-release screen unzip cmake wget  \
  build-essential bzip2 curl cmake vim-common expect-dev \
  flex bison libstdc++6 \
  tk binutils-msp430 gcc-msp430 msp430-libc msp430mcu

pip install pyelftools

git clone https://github.com/sancus-tee/sancus-main.git
cd sancus-main

make ti-mspgcc
make clang-sancus

# custom sancus-compiler and sancus-support (in this right order!)
cd ..
git clone https://github.com/gianlu33/sancus-compiler.git
git clone https://github.com/gianlu33/sancus-support.git

make_repo "sancus-compiler" $1 $2
make_repo "sancus-support" $1 $2
