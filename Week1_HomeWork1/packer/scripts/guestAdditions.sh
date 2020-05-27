#!/bin/bash
echo "********************************************"
echo "START PROVISIONS SCRIPT 'guestAdditions.sh'"
echo "********************************************"

yum list installed | grep kernel 

mkdir -p /media/VirtualBoxGuestAdditions/ &&
wget -P /home/vagrant/ http://download.virtualbox.org/virtualbox/6.1.8/VBoxGuestAdditions_6.1.8.iso &&
mount --options loop,ro /home/vagrant/VBoxGuestAdditions_6.1.8.iso /media/VirtualBoxGuestAdditions/ &&
echo 'Download additions' &&
sh /media/VirtualBoxGuestAdditions/VBoxLinuxAdditions.run 
lsmod | grep vbox 

echo "*******************FINISH********************"

reboot