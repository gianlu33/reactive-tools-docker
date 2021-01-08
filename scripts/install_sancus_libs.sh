#!/bin/bash

set -eux

# patch sancus-support and sancus-compiler
# TODO remove this as soon as these patches are merged into main repo

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

git clone https://github.com/gianlu33/sancus-support.git
git clone https://github.com/gianlu33/sancus-compiler.git

make_repo "sancus-support" $1 $2
make_repo "sancus-compiler" $1 $2
