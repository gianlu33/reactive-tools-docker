#!/bin/bash

set -eux

./install_python.sh
./install_rust.sh
./install_edp.sh
./install_sancus_deps.sh
./install_sancus.sh "$@"
