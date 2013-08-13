# Allow vagrant to not have shell
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Vagrant specific
sudo date > /etc/vagrant_box_build_time

# Add vagrant user
sudo /usr/sbin/groupadd vagrant
sudo /usr/sbin/useradd vagrant -g vagrant -G wheel
sudo echo "vagrant"|passwd --stdin vagrant
sudo echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sudo chmod 0440 /etc/sudoers.d/vagrant

# Installing vagrant keys
sudo mkdir -p /home/vagrant/.ssh
sudo chmod 700 /home/vagrant/.ssh
sudo cd /home/vagrant/.ssh
sudo wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
sudo chown -R vagrant /home/vagrant/.ssh

