#!/bin/bash

rm -f /home/vagrant/*.iso
rm -rf /media
rm -f ~root/.bash_history
rm -f ~root/*.log
rm -f /home/vagrant/.bash_history 

rm -rf /tmp/*
find /var/log -type f | while read f; do echo -ne '' > $f; done;
rm -f /var/log/vbox*
yum erase -y gcc make bzip2 perl kernel-lt-headers\* kernel-lt-tools\* kernel-lt-devel\* postfix *iwl* aic* yum-utils
yum -y clean all
rm -rf /var/cache/yum

rm -f /boot/*rescue*
grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"

echo "Fill with 0 the swap partition to reduce box size"
readonly swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
readonly swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
/sbin/swapoff "$swappart"
dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed"
/sbin/mkswap -U "$swapuuid" "$swappart"

dd if=/dev/zero of=/EMPTY bs=1M | true
rm -rf /EMPTY
sync