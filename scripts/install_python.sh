#!/bin/bash

set -eux

apt-get update && apt-get install -y --no-install-recommends curl software-properties-common
add-apt-repository -y ppa:deadsnakes/ppa
apt-get update && apt-get install -y --no-install-recommends python3.6

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.6 get-pip.py

echo -e '#!/bin/bash\npython3.6 "$@"' > /usr/bin/python && chmod +x /usr/bin/python
echo -e '#!/bin/bash\npython3.6 "$@"' > /usr/bin/python3 && chmod +x /usr/bin/python3
