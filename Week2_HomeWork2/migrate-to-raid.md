






rsync -auxHAXSv --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/mnt/*  --exclude=/boot/* --exclude=/home/* /* /mnt
rsync -auxHAXSv /boot/* /mnt/boot
rsync -auxHAXSv /home/* /mnt/home


rsync -axu --exclude=/home/* --exclude=/boot/* / /mnt/
dracut --mdadmconf --fstab --add="mdraid" --filesystems "xfs ext4 ext3 tmpfs devpts sysfs proc" --add-drivers="raid1 raid5 " --force /boot/initramfs-$(uname -r).img $(uname -r) -M

UPD: Из-за использования rd.auto=1, замечены проблемы с LVM, если он располагается на software raid разделе — LVM раздел будет not available после перезагрузки. Чтобы этого не происходило, нужно сделать следующее:
В пункте 11, нужно передать rd.md.uuid= UUID который мы положили в mdadm.conf, вместо «rd.auto=1», тем самым явно указав какой raid раздел нам собрать, чтобы загрузился корень.
Источник https://habr.com/ru/post/248073/






https://vadosware.io/post/dedicated-server-rescue-raid-and-grub/
https://wiki.centos.org/HowTos/Install_On_Partitionable_RAID1
https://www.linux.org.ru/forum/admin/11922762
https://wiki.archlinux.org/index.php/GRUB#RAID
https://www.linux.com/training-tutorials/how-rescue-non-booting-grub-2-linux/
https://www.altlinux.org/CreateMdRAID1onLiveSystem
https://raid.wiki.kernel.org/index.php/RAID_superblock_formats
https://my.esecuredata.com/index.php?/knowledgebase/article/124/create---migrate-existing-working-redhat---centos-system-to-raid-1---raid-10/
https://www.sysadmin.in.ua/2013/05/10/nastrojka-programmnogo-raid1-na-rabotayushhej-sisteme-linux-debian-ispolzuya-zagruzchik-grub2/
https://habr.com/ru/post/327572/
https://habr.com/ru/post/347002/
http://www.rodsbooks.com/gdisk/mbr2gpt.html
https://wiki.centos.org/TipsAndTricks/CreateNewInitrd
https://mdex-nn.ru/page/avarijnyj-zapusk-sistemy-iz-komandnoj-stroki-grub
https://blog.fpmurphy.com/2011/10/fedora-16-mbr-grub-legacy-to-gpt-grub2.html
https://en.wikipedia.org/wiki/BIOS_boot_partition
https://wiki.archlinux.org/index.php/Partitioning_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
https://docs.hytrust.com/DataControl/Admin_Guide-4.0/Default.htm#Books/Admin-Guide/Linux-Root-Swap-Drive-Encryption/Creating-Boot-Partition-RHEL-CentOS-7.htm%3FTocPath%3DHyTrust%2520DataControl%2520Administration%2520Guide%7CLinux%2520Root%2520and%2520Swap%2520Drive%2520Encryption%7CPrerequisites%2520and%2520Restrictions%7C_____3
https://www.av8n.com/computer/htm/grub-reinstall.htm
https://habr.com/ru/post/248073/
https://habr.com/ru/post/450896/
http://www.bog.pp.ru/work/dracut.html
https://www.linux.org.ru/forum/admin/13293826
https://cmatthew.net/wiki/Convert_to_raid_1_CentOS_7