#!/bin/bash

# Copy over server_config
tar xvf server_config.tar||true #sometimes this returns with exit code 1 due to weird timestamp problems

chmod +x /home/packer/server_config/puppet/node_classifier

# Copy rgenvs.py to /usr/local/bin/rgenvs
sudo cp /home/packer/server_config/rgenvs.py /usr/local/bin/rgenvs.py
sudo chmod +x /usr/local/bin/rgenvs.py

sudo puppet apply server_config/puppet/manifests/site.pp --node_terminus=exec --external_nodes=/home/packer/server_config/puppet/node_classifier

