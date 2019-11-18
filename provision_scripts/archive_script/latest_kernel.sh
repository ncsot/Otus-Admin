#!/bin/bash
yum -y update
yum -y groupinstall "Development-Tools"
yum -y install ncurses-devel bison flex elfutils-libelf-devel openssl-devel zlib-devel binutils-devel bc
yum install -y yum-utils git wget

LATEST_STABLE=(`curl -s https://www.kernel.org/ | grep -A1 'stable:' | grep -oP '(?<=strong>).*(?=</strong.*)'`)

LATEST_LINK=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link" | grep -o -P '(?<=a href=").*(?=">)')

wget "$LATEST_LINK" -P /home/vagrant/



#sudo grub2-mkconfig -o /boot/grub2/grub.cfg
#sudo grubby --set-default /boot/vmlinuz-"$LATEST_STABLE"