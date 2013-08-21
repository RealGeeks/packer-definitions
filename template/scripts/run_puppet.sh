#!/bin/bash

# Copy over server_config
tar xvf server_config.tar||true #sometimes this returns with exit code 1 due to weird timestamp problems

# For some reason, /etc/resolv.conf has to have "search dev" in it.  Other stuff in there makes the
# node classifier barf
sudo sed -i "s/^search.*/search dev/g" /etc/resolv.conf

if ! sudo grep 'search' /etc/resolv.conf ; then
    sudo bash -c "echo 'search dev' >> /etc/resolv.conf"
fi

echo "CONTENTS OF RESOLV.CONF ARE AS FOLLOWS"
cat /etc/resolv.conf
echo "THIS HAS BEEN A MESSAGE FROM YOUR FRIENDLY RESOLV.CONF"

chmod +x /home/packer/server_config/puppet/node_classifier

# Copy rgenvs.py to /usr/local/bin/rgenvs
sudo cp /home/packer/server_config/rgenvs.py /usr/local/bin/rgenvs.py
sudo chmod +x /usr/local/bin/rgenvs.py

echo "RUNNING PUPPET WITH HOSTNAME $(hostname)"

sudo puppet apply server_config/puppet/manifests/site.pp --node_terminus=exec --modulepath=server_config/puppet/modules/ --external_nodes=/home/packer/server_config/puppet/node_classifier

