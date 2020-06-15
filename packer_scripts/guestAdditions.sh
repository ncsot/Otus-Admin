#!/bin/bash
echo "********************************************"
echo "START PROVISIONS SCRIPT 'guestAdditions.sh'"
echo "********************************************"

yum list installed | grep kernel
wget -P /home/vagrant http://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT
boxv=`cat /home/vagrant/LATEST-STABLE.TXT`
echo "BOXV= ${boxv}"
mkdir -p /media/VirtualBoxGuestAdditions/ &&
wget -P /home/vagrant/ http://download.virtualbox.org/virtualbox/${boxv}/VBoxGuestAdditions_${boxv}.iso &&
mount --options loop,ro /home/vagrant/VBoxGuestAdditions_${boxv}.iso /media/VirtualBoxGuestAdditions/ &&
echo 'Download additions' &&
sh /media/VirtualBoxGuestAdditions/VBoxLinuxAdditions.run 
lsmod | grep vbox 

echo "*******************FINISH********************"

reboot