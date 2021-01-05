#!/bin/bash

#python
apt-get update && apt-get install -y curl python3.6 python3-distutils
echo -e '#!/bin/bash\npython3.6 "$@"' > /usr/bin/python && chmod +x /usr/bin/python

# pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
