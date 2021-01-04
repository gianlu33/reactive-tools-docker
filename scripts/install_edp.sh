#!/bin/bash

set -eux

rustup default nightly
rustup target add x86_64-fortanix-unknown-sgx --toolchain nightly

apt-get update && apt-get install -y pkg-config libssl-dev protobuf-compiler
cargo install fortanix-sgx-tools sgxs-tools

mkdir -p $HOME/.cargo
echo -e '[target.x86_64-fortanix-unknown-sgx]\nrunner = "ftxsgx-runner-cargo"' >> $HOME/.cargo/config
