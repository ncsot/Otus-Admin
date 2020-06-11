#!/bin/bash
echo "REPO PROVISION"
yum clean all
yum-config-manager --enable base updates
yum makecache
yum install -y yum-plugin-remove-with-leaves
sed -i 's/^#remove_always = 1/remove_always = 1/' /etc/yum/pluginconf.d/remove-with-leaves.conf
echo "*************DELETE OLD KERNELS***********"  
yum erase -y kernel*    && echo "Delete old headers"
echo "Installed headers"
yum list installed | grep kernel*  
echo "*******PREPARE NEXT SCRIPT****************"

yum install -y gcc perl bzip2 make
yum install -y kernel-lt-headers* kernel-lt-tools* kernel-lt-devel*


