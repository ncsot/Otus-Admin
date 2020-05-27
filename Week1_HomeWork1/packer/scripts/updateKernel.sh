#!/bin/bash
echo "********************************************"
echo "START PROVISIONS SCRIPT 'updateKernel.sh'"
echo "********************************************"

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org && echo "KEY ADD"
yum install -y https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm 
echo "ElRepo added" 

echo "*************Next Stage*****************"
yum install -y yum-utils
yum-config-manager --disable \* >/dev/null  &&
yum-config-manager --enable elrepo-kernel >/dev/null 
echo "REPOLIST"  
yum repolist  
echo "Provision repo"  
yum install -y kernel-ml  &&
echo "GOTCHA Kernel Loaded"  

echo "DELETE OLD KERNEL"  
rm -f /boot/*3.10* 
echo "************UPDATE GRUB*******************"  
# Update GRUB 
grub2-set-default 0 
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"
echo "Grub update done." 
echo "\n***********FINISH*************"
reboot
