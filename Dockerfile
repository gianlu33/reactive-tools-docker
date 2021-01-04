FROM python:3.6

WORKDIR /usr/src/installation_scripts

# Rust & Fortanix EDP

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY scripts/install_rust.sh .
RUN ./install_rust.sh

COPY scripts/install_edp.sh .
RUN ./install_edp.sh

# Sancus
#TODO

# TrustZone
#TODO

# install reactive-tools and its dependencies

COPY scripts/install_reactive_tools.sh .
RUN ./install_reactive_tools.sh

WORKDIR /usr/src/app
RUN rm -rf /usr/src/installation_scripts

# run command
#CMD TODO
