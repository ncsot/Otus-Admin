#!/bin/bash
yum -y install mdadm lsof gdisk rsync

parted /dev/sdb -s mklabel gpt
parted /dev/sdb -s mkpart primary 1MiB 4MiB
parted /dev/sdb -s mkpart primary 4MiB 304Mib
parted /dev/sdb -s mkpart primary 304Mib 3004Mib
parted /dev/sdb -s mkpart primary 3004Mib 100%
parted /dev/sdb -s set 1 bios_grub
parted /dev/sdb -s set 2 raid
parted /dev/sdb -s set 3 raid
parted /dev/sdb -s set 4 raid

sgdisk -R /dev/sdc /dev/sdb
sgdisk -R /dev/sdd /dev/sdb
sgdisk -G /dev/sdd
sgdisk -G /dev/sdb
sgdisk -G /dev/sdc

parted /dev/sde -s mklabel gpt
parted /dev/sde -s mkpart primary 1MiB 4MiB
parted /dev/sde -s mkpart primary 4MiB 304Mib
parted /dev/sde -s mkpart primary 304Mib 3004Mib
parted /dev/sde -s mkpart primary 3004Mib 100% 
parted /dev/sde -s set 1 bios_grub
parted /dev/sde -s set 2 raid
parted /dev/sde -s set 4 raid
sgdisk -G /dev/sde

echo yes | mdadm --create --verbose /dev/md0 -l 1 -n 4 /dev/sdb2 /dev/sdc2 /dev/sdd2 /dev/sde2 
echo yes | mdadm --create --verbose /dev/md1 -l 1 -n 3 /dev/sdb3 /dev/sdc3 /dev/sdd3 
echo yes | mdadm --create --verbose /dev/md2 -l 5 -n 4 /dev/sdb4 /dev/sdc4 /dev/sdd4 /dev/sde4 

echo 'WAITING TO RAID'

sleep 10
cat /proc/mdstat
sleep 60
cat /proc/mdstat

echo 'MAKE FS'
for i in {0..2}; do mkfs.ext4 /dev/md${i}; done 
cat /etc/fstab
swapoff -a
mkswap /dev/sde3
sed -i "/swap/d" /etc/fstab
IDswap=`blkid -s UUID -o value /dev/sde3`
echo UUID=${IDswap} swap swap defaults 0 0 >> /etc/fstab
swapon -a
swapon -s
mkdir /etc/mdadm
echo "DEVICE partitions" >> /etc/mdadm.conf
echo "MAILADDR root" >> /etc/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm.conf

echo  'START COPY ROOT'
mount /dev/md1 /mnt
rsync -auxHAXS --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/mnt/*  --exclude=/boot/* --exclude=/home/* /* /mnt && echo "COPY ROOT"
mount /dev/md0 /mnt/boot
mount /dev/md2 /mnt/home
rsync -auxHAXS /boot/* /mnt/boot
rsync -auxHAXS /home/* /mnt/home
mount --bind /proc /mnt/proc
mount --bind /dev /mnt/dev
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run


mdUUIDboot=`blkid -s UUID -o value /dev/md0`
mdUUIDroot=`blkid -s UUID -o value /dev/md1`
mdUUIDhome=`blkid -s UUID -o value /dev/md2`
sed -i ':a;N;$!ba;s/UUID=[A-Fa-f0-9-]*/UUID='"$mdUUIDroot"'/1' /etc/fstab
sed -i ':a;N;$!ba;s/UUID=[A-Fa-f0-9-]*/UUID='"$mdUUIDboot"'/2' /etc/fstab
echo UUID=${mdUUIDhome} /home ext4 defaults 1 3 >> /etc/fstab


sed -i "s/rhgb quiet/rd.auto rd.auto=1 /" /etc/default/grub
echo 'GRUB_PRELOAD_MODULES="mdraid1x"' >> /etc/default/grub

yes | cp -f /etc/fstab /mnt/etc/fstab
yes | cp -f /etc/default/grub /mnt/etc/default/grub
echo '********NEW FSTAB*********'
cat /mnt/etc/fstab
echo '********NEW GRUB CONF*********'
cat /mnt/etc/default/grub
echo '********MDADMCONF ON RAID*********'
cat /mnt/etc/mdadm.conf
chrootFunc="dracut --mdadmconf --fstab --add=\"mdraid\" --add-drivers=\"raid1 raid5\" --force /boot/initramfs-5.7.1-1.el7.elrepo.x86_64.img 5.7.1-1.el7.elrepo.x86_64 -M 
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-install /dev/sdb
grub2-install /dev/sdc
grub2-install /dev/sdd
grub2-install /dev/sde
exit"
echo "START CHROOT PROVISION"
echo "$chrootFunc" >> /mnt/nextProvis.sh
chmod 700 /mnt/nextProvis.sh
chroot /mnt /bin/bash -c ./nextProvis.sh


