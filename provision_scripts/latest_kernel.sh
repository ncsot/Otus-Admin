LATEST_STABLE=(`curl -s https://www.kernel.org/ | grep -A1 'stable:' | grep -oP '(?<=strong>).*(?=</strong.*)'`)
LATEST_LINK=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link" | grep -o -P '(?<=a href=").*(?=">)')

wget $LATEST_LINK &> /dev/null

tar -Jxvf *"$LATEST_STABLE"* -C /usr/src
/usr/src/linux-"$LATEST_STABLE"/make mrproper
wget https://github.com/ncsot/Otus-Admin/blob/master/Week1_HomeWork1/.config -P /usr/src/linux-"$LATEST_STABLE"
/usr/src/linux-"$LATEST_STABLE"/make bzImage
/usr/src/linux-"$LATEST_STABLE"/make modules
/usr/src/linux-"$LATEST_STABLE"/make
/usr/src/linux-"$LATEST_STABLE"/make install modules_install
/usr/src/linux-"$LATEST_STABLE"/make install
