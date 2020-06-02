```lsblk```

```cat /proc/devices```

```stat /dev/sda```

```fdisk -l```

```parted /dev/sda print free```

текущее состояние swap
- ```swapon -s```

посмотреть файловые системы
- ```df -Th```
- ```mount | column -t```
- 

```cat /proc/devices
cat /etc/fstab
cat /proc/mdstat
stat /dev/sda
```
blkid
http://rus-linux.net/nlib.php?name=/MyLDP/consol/HuMan/blkid-ru.html