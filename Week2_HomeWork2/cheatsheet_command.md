- ```lsblk```
- ```lsblk -f```
- ``` ls -l /dev/disk/* (path, uuid, label) ```
```cat /proc/devices```

```stat /dev/sda```

```fdisk -l```

```
parted --script /dev/sda unit s \ print
```

текущее состояние swap
- ```swapon -s```

посмотреть файловые системы
- ```df -Th```
- ```mount | column -t```
- ```parted -l```

```cat /proc/devices
cat /etc/fstab
cat /proc/mdstat
stat /dev/sda
```

```udevadm info --query=path /dev/sdb```

blkid

blkid -s UUID -o value /dev/sdX


http://rus-linux.net/nlib.php?name=/MyLDP/consol/HuMan/blkid-ru.html
https://wiki.archlinux.org/index.php/Udev_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
https://wiki.archlinux.org/index.php/Persistent_block_device_namingv
http://fibrevillage.com/9-storage/4-blkid-useful-examples

mbr без таблицы но с кодом загрузчика

```
dd if=/dev/sda of=./mbr bs=512 count=1
dd if=./mbr of=./mbr.1 bs=446 count=1
dd if=/dev/zero of=./mbr.2 bs=64 count=1
dd if=./mbr of=./mbr.3 bs=1 count=2 skip=510
cat mbr.1 mbr.2 mbr.3 >mbr.finish
```
http://linuxshare.ru/docs/disk-image-with-boot-and-mbr-to-vm.html 

Как скопировать GPT с одного диска на другой?
Копирование GPT с одного диска на другой:

# sgdisk -R /dev/sdb /dev/sda
Копирование выполняется с диска /dev/sda на диск /dev/sdb. Не перепутайте!

Рандомизация GUID:

# sgdisk -G /dev/sdb
The operation has completed successfully.


Создаем раздел, с типом фс linux-swap, можно использовать Gparted или mkswap:

Copy to clipboard
mkswap /dev/sdxn
Включаем swap:

Copy to clipboard
swapon /dev/sdxn
Смотрим UUID диска:

Copy to clipboard
blkid /dev/sdxn
Прописываем в fstab:

Copy to clipboard
UUID=d6875e5c-7a82-4e0e-8651-57b71833f5e6    swap    swap    defaults    0    0
Просмотр состояния:

Copy to clipboard
swapon -s
Filename				Type		Size	Used	Priority
/dev/sdb2                              	partition	5122044	0	-1
/dev/dm-1                              	partition	3506172	0	-2
Или так:

Copy to clipboard
cat /proc/swaps 
Filename				Type		Size	Used	Priority
/dev/sdb2                               partition	5122044	0	-1
/dev/dm-1                               partition	3506172	0	-2




mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm.conf