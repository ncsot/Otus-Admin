yum install -y bzip2 gcc make perl 
yum --enablerepo=elrepo-kernel install -y kernel-ml-devel

mkdir /tmp/vbox
VER=$(cat /home/vagrant/.vbox_version)
curl https://download.virtualbox.org/virtualbox/6.0.14/VBoxGuestAdditions_6.0.14.iso -o /tmp/VBoxGuestAdditions_6.0.14.iso
mount -o loop /tmp/VBoxGuestAdditions_6.0.14.iso /tmp/vbox
sh /tmp/vbox/VBoxLinuxAdditions.run --nox11
umount /tmp/vbox
rmdir /tmp/vbox
rm /tmp/VBoxGuestAdditions_6.0.14.iso



rm -rf /tmp/*
rm  -f /var/log/wtmp /var/log/btmp
rm -rf /var/cache/* /usr/share/doc/*
rm -rf /var/cache/yum
rm -rf /vagrant/home/*.iso
rm  -f ~/.bash_history
history -c

rm -rf /run/log/journal/*
readonly swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
readonly swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
/sbin/swapoff "$swappart"
dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed" 
/sbin/mkswap -U "$swapuuid" "$swappart"
# Remove Ansible and its dependencies.

echo "Start Cleanup"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync