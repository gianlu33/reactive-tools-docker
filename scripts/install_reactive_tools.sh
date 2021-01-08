#!/bin/bash

set -eux

git clone https://github.com/gianlu33/authentic-execution.git
cd authentic-execution

git submodule update --init --recursive

pip install libs/reactive-net
pip install sgx/rust-sgx-gen
pip install reactive-tools/
pip install sancus/reactive-uart2ip
