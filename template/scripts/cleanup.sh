#!/bin/bash

sudo yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
sudo yum -y clean all
sudo rm -rf VBoxGuestAdditions_*.iso

# Remove server_config stuff
rm server_config.tar
rm -rf server_config

