#!/bin/bash

set -eux

apt-get update && apt-get install -y git screen unzip # screen + unzip might be useful for Sancus

git clone https://github.com/gianlu33/authentic-execution.git
cd authentic-execution

git submodule update --init --recursive

pip install libs/reactive-net
pip install sgx/rust-sgx-gen
pip install reactive-tools/
pip install sancus/reactive-uart2ip

#install applications for SGX deployment
./sgx/rust-sgx-apps/install_all.sh
