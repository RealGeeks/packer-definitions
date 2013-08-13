# Installing the virtualbox guest additions
sudo yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget

VBOX_VERSION=$(cat /home/packer/.vbox_version)
cd /tmp
sudo mount -o loop /home/packer/VBoxGuestAdditions.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo rm -rf /home/packer/VBoxGuestAdditions_*.iso

sudo yum -y remove gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget

