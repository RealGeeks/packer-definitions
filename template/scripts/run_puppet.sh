#!/bin/bash

# Copy over server_config
tar xvf server_config.tar||true #sometimes this returns with exit code 1 due to weird timestamp problems

#Remove localdomain from /etc/resolv.conf because puppet doesn't like it
sudo sed -i "s/localdomain//g" /etc/resolv.conf

echo "OMG RESOLV.CONF"
cat /etc/resolv.conf
echo "OMG RESOLV.CONF DONE"

chmod +x /home/packer/server_config/puppet/node_classifier

# Copy rgenvs.py to /usr/local/bin/rgenvs
sudo cp /home/packer/server_config/rgenvs.py /usr/local/bin/rgenvs.py
sudo chmod +x /usr/local/bin/rgenvs.py

echo "RUNNING PUPPET WITH HOSTNAME $(hostname)"

sudo puppet apply server_config/puppet/manifests/site.pp --node_terminus=exec --modulepath=server_config/puppet/modules/ --external_nodes=/home/packer/server_config/puppet/node_classifier

