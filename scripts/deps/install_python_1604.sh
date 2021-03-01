#!/bin/bash

set -eux

# Install requirements
apt-get update && apt-get install -y build-essential \
checkinstall \
libreadline-gplv2-dev \
libncursesw5-dev \
libssl-dev \
libsqlite3-dev \
tk-dev \
libgdbm-dev \
libc6-dev \
libbz2-dev \
zlib1g-dev \
openssl \
libffi-dev \
python3-dev \
python3-setuptools \
wget

# Prepare to build
mkdir /tmp/Python37
cd /tmp/Python37

# Pull down Python 3.7, build, and install
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
tar xvf Python-3.7.0.tar.xz
cd /tmp/Python37/Python-3.7.0
./configure
make altinstall

# aliases
echo -e '#!/bin/bash\npython3.7 "$@"' > /usr/bin/python && chmod +x /usr/bin/python
echo -e '#!/bin/bash\npip3.7 "$@"' > /usr/bin/pip && chmod +x /usr/bin/pip
