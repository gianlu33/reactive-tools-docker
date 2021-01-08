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

cd sancus-main
make install SANCUS_SECURITY=$1 SANCUS_KEY=$2
cd ..

# patch sancus-support and sancus-compiler (TODO remove as soon as these updates are pushed on the main repos)
git clone https://github.com/gianlu33/sancus-support.git
git clone https://github.com/gianlu33/sancus-compiler.git

make_repo "sancus-support" $1 $2
make_repo "sancus-compiler" $1 $2
