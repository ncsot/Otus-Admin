## Лабараторная № 2
______________________
###### Текущая версия box [v.0.0.1](../packer/raidLabBox/CHANGELOG.md)
Миграция с одного hdd на raid массивы

***[СКРИПТ для сборки](../provision_scripts/migrateRAID.sh)***

***Prerequisites:***
- Virtualbox >6.1.8
- Vagrant >2.2.9
- Packer >1.6
- vagrant-vbguest plugin
- FREE SPACE 22gb+ in ~ directory

***Install:***
```
 git clone https://github.com/ncsot/Otus-Admin.git
 cd ./Otus-Admin/Lab02
 vagrant up && vagrant halt && vagrant up  <--- ###ONLY##
```
***Description:***
 
 ОС стартует на одном hdd c mbr, далее мигрирует на raid массивы находяшихся на партициях 4-ех hdd дисков c gpt. После перезагрузки, загружается с raid массива, первоначальный диск удаляется, триггером в Vagrantfile.
 ```` <!-- language: lang-none -->
                           sda                    sdb           sdc          sdb           sdc
                        +-------+              +-------+     +-------+    +-------+     +-------+ 
                        |       |              |  ef02 |     |  ef02 |    |  ef02 |     |  ef02 |
                        | /boot |              |_______|     |_______|    |_______|     |_______|
                        | sda1  |              | raid1 |     | raid1 |    | raid1 |     | raid1 |  
                        |_______|              | /boot |     | /boot |    | /boot |     | /boot |
                        |       |              |_______|     |_______|    |_______|     |_______| 
                        | swap  |      ====>   | raid1 |     | raid1 |    | raid1 |     |       |
                        | sda2  |              | /root |     | /root |    | /root |     | swap  |
                        |_______|              |_______|     |_______|    |_______|     |_______|  
                        |       |              |       |     |       |    |       |     |       | 
                        |       |              | raid5 |     | raid5 |    | raid5 |     | raid5 | 
                        | /root |              | /home |     | /home |    | /home |     | /home |
                        | sda3  |              |       |     |       |    |       |     |       |
                        |       |              |       |     |       |    |       |     |       | 
                        +-------+              +-------+     +-------+    +-------+     +-------+ 

````
