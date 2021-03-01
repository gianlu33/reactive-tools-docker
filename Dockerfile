FROM ubuntu:16.04

WORKDIR /usr/src/install

RUN useradd -ms /bin/bash reactive

## Python ##
COPY scripts/install_python.sh .
RUN ./install_python.sh

## Rust ##
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY scripts/install_rust.sh .
RUN ./install_rust.sh

## EDP ##
COPY scripts/install_edp.sh .
RUN ./install_edp.sh

## Sancus ##
ENV PYTHONPATH=\$PYTHONPATH:/usr/local/share/sancus-compiler/python/lib/
ARG SANCUS_SECURITY=128
ARG SANCUS_KEY=deadbeefcafebabec0defeeddefec8ed

COPY scripts/install_sancus.sh .
RUN ./install_sancus.sh $SANCUS_SECURITY $SANCUS_KEY

ARG DUMMY1=0

RUN apt-get update && apt-get install -y --no-install-recommends git make \
    && git clone https://github.com/gianlu33/rust-sgx-apps.git \
    && cd rust-sgx-apps && make install

ARG DUMMY2=0

RUN git clone https://github.com/gianlu33/reactive-net.git \
    && git clone https://github.com/gianlu33/rust-sgx-gen.git \
    && git clone https://github.com/gianlu33/reactive-tools.git \
    && pip install reactive-net/ rust-sgx-gen/ reactive-tools/ \
    && rm -rf /usr/src/install

WORKDIR /usr/src/app
