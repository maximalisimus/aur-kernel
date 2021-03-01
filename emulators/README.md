# aur-nvidia-390xx
# https://maximalisimus.github.io/aur-nvidia-390xx/

Драйвера AUR nvidia-390xx. Собранные в формат xz и zst пакеты для установки с помощью pacman.

Nvidia-390xx AUR drivers. Collected in the xz and zst format for packages to install via pacman.

Для добавления репозитория в систему отредактируйте файл: /etc/pacman.conf
Обратите внимание на строку SigLevel. Все коммиты данного репозитория верифицированы цифровой подписью. Поэтому выполнять проверку пакетов в "pacman" необязательно.

To add a repository to the system, edit the file: /etc/pacman.conf
Note the SigLevel string. All commits in this repository are digitally signed. Therefore, it is not necessary to check packages in "pacman".

[aur-nvidia-390xx]

SigLevel = Never

Server = https://maximalisimus.github.io/$repo/$arch

Однако вы можете отказаться от строки SigLevel, но сначало установите публичные ключи для "pacman".

However, you can opt out of the SigLevel string, but first set the public keys for "pacman".

wget https://maximalisimus.github.io/elseworld-keyring/install-keyring.sh

sudo sh install-keyring.sh

