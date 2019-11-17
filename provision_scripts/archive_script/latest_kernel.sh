
LATEST_STABLE=(`curl -s https://www.kernel.org/ | grep -A1 'stable:' | grep -oP '(?<=strong>).*(?=</strong.*)'`)

LATEST_LINK=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link" | grep -o -P '(?<=a href=").*(?=">)')




sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grubby --set-default /boot/vmlinuz-"$LATEST_STABLE"