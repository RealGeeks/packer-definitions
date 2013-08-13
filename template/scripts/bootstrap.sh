#!/bin/bash

#INSTALL EPEL
sudo rpm -ivh http://ftp.osuosl.org/pub/fedora-epel/6/i386/epel-release-6-8.noarch.rpm

# Install Puppet

#Add the puppet yum repos
sudo rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm

sudo yum -y install puppet facter

# 'puppet' user is created by the puppet rpm, but it has no login
# shell. We give a shell to it because we use this user to ssh and
# apply puppet config
sudo chsh -s /bin/bash puppet
