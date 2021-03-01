#!/bin/bash

set -eux

# add target
rustup default nightly
rustup target add x86_64-fortanix-unknown-sgx --toolchain nightly

# Install utilities
apt-get update && apt-get install -y pkg-config libssl-dev protobuf-compiler
cargo install fortanix-sgx-tools sgxs-tools

# Configure Cargo integration with EDP
mkdir -p $HOME/.cargo
echo -e '[target.x86_64-fortanix-unknown-sgx]\nrunner = "ftxsgx-runner-cargo"' >> $HOME/.cargo/config

# Install clang 3.8 for rust-mbedtls
# See https://github.com/fortanix/rust-mbedtls/issues/5
apt-get update && apt-get install -y clang-3.8 cmake
ln -s /usr/lib/llvm-3.8/lib/libclang.so.1 /usr/lib/llvm-3.8/lib/libclang.so
