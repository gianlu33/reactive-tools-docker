FROM ubuntu:18.04

WORKDIR /usr/src/install

# Environment variables
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    PYTHONPATH=\$PYTHONPATH:/usr/local/share/sancus-compiler/python/lib/

# Parameters for Sancus installation
ARG SANCUS_SECURITY=128
ARG SANCUS_KEY=deadbeefcafebabec0defeeddefec8ed

COPY scripts/ .
RUN ./install_all.sh $SANCUS_SECURITY $SANCUS_KEY

ARG DUMMY1=0

RUN apt-get update && apt-get install -y git make \
    && git clone https://github.com/gianlu33/reactive-uart2ip.git \
    && git clone https://github.com/gianlu33/rust-sgx-apps.git \
    && pip install reactive-uart2ip/ \
    && cd rust-sgx-apps && make install

ARG DUMMY2=0

RUN git clone https://github.com/gianlu33/reactive-net.git \
    && git clone https://github.com/gianlu33/rust-sgx-gen.git \
    && git clone --branch sgx-extension https://github.com/gianlu33/reactive-tools.git \
    && pip install reactive-net/ \
    && pip install rust-sgx-gen/ \
    && pip install reactive-tools/ \
    && rm -rf /usr/src/install

WORKDIR /usr/src/app
