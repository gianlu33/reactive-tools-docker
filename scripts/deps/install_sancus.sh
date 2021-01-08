#!/bin/bash

set -eux

apt-get install -y make git lsb-release screen unzip

export DEBIAN_FRONTEND=noninteractive

git clone https://github.com/sancus-tee/sancus-main.git
cd sancus-main
make install_deps
make install SANCUS_SECURITY=$1 SANCUS_KEY=$2
