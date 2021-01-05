FROM ubuntu:18.04

WORKDIR /usr/src/installation_scripts

#################################################### Python

COPY scripts/install_python.sh .
RUN ./install_python.sh

#################################################### Rust & Fortanix EDP

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY scripts/install_rust.sh .
RUN ./install_rust.sh

COPY scripts/install_edp.sh .
RUN ./install_edp.sh

#################################################### Sancus

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/install_sancus_deps.sh .
RUN ./install_sancus_deps.sh

ARG SANCUS_SECURITY=128
ARG SANCUS_KEY=deadbeefcafebabec0defeeddefec8ed

COPY scripts/install_sancus.sh .
RUN ./install_sancus.sh $SANCUS_SECURITY $SANCUS_KEY

#################################################### Trustzone
#TODO

#################################################### Reactive-tools

COPY scripts/install_reactive_tools.sh .
RUN ./install_reactive_tools.sh

#################################################### Run

WORKDIR /usr/src/app
RUN rm -rf /usr/src/installation_scripts
#CMD TODO
