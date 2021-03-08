
sudo echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex-disk.list
wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add -
sudo apt update
sudo apt install yandex-disk


sudo add-apt-repository ppa:slytomcat/ppa
sudo apt-get update
sudo apt-get install yd-tools


sudo vi /etc/yum.repos.d/yandex.repo

[yandex]
name=Yandex
failovermethod=priority
baseurl=http://repo.yandex.ru/yandex-disk/rpm/stable/$basearch/
enabled=1
metadata_expire=1d
gpgcheck=1
gpgkey=http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG

sudo rpm --import http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG
sudo yum install yandex-disk



yandex-disk setup


dnf install alien
yum install alien

http://ppa.launchpad.net/slytomcat/ppa/ubuntu/pool/main/y/yd-tools/
http://ppa.launchpad.net/slytomcat/ppa/ubuntu/pool/main/y/yd-tools/yd-tools_1.11.0_all.deb






