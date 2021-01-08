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

COPY scripts/deps .
RUN ./install_deps.sh $SANCUS_SECURITY $SANCUS_KEY

COPY scripts/install_sancus_libs.sh .
RUN ./install_sancus_libs.sh $SANCUS_SECURITY $SANCUS_KEY

COPY scripts/install_sgx_apps.sh .
RUN ./install_sgx_apps.sh

COPY scripts/install_reactive_tools.sh .
RUN ./install_reactive_tools.sh

RUN rm -rf /usr/src/install
WORKDIR /usr/src/app
