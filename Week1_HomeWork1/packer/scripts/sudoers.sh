echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant &&
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers &&
echo "*********MODE SUDOERS 2********"