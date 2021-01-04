#!/bin/bash

set -eux

git clone https://github.com/gianlu33/authentic-execution.git
cd authentic-execution

#TODO: update this when time comes
git submodule update --init --recursive libs/reactive-net
git submodule update --init --recursive sgx/rust-sgx-gen
git submodule update --init --recursive sgx/rust-sgx-apps
git submodule update --init --recursive reactive-tools

pip install libs/reactive-net
pip install sgx/rust-sgx-gen
pip install reactive-tools/

#install applications for SGX deployment
./sgx/rust-sgx-apps/install_deployer.sh
