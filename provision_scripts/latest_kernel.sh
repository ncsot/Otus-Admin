LATEST_STABLE=(`curl -s https://www.kernel.org/ | grep -A1 'stable:' | grep -oP '(?<=strong>).*(?=</strong.*)'`)
LATEST_LINK=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link" | grep -o -P '(?<=a href=").*(?=">)')
echo "Download kernel"
echo "=================================================================="
wget $LATEST_LINK &> /dev/null
echo "=================================================================="
echo "Extract kernel"
tar -Jxf *"$LATEST_STABLE"* -C /usr/src
echo "=================================================================="
LINK_MAKEFILE="/usr/src/linux-"$LATEST_STABLE"/Makefile"
echo "Install"
make -f "$LINK_MAKEFILE" mrproper
echo "=================================================================="
wget https://github.com/ncsot/Otus-Admin/blob/master/Week1_HomeWork1/.config -P /usr/src/linux-"$LATEST_STABLE"
make -f "$LINK_MAKEFILE" bzImage
make -f "$LINK_MAKEFILE" modules
make -f "$LINK_MAKEFILE" -j 4
make -f "$LINK_MAKEFILE" install modules_install
make -f "$LINK_MAKEFILE" install
