# aur-kernel
# https://maximalisimus.github.io/repo/aur-kernel/

Старые версии ядер для Archlinux.

Old versions of cores for Archlinux.

Для добавления репозитория в систему отредактируйте файл: /etc/pacman.conf
Обратите внимание на строку SigLevel. Все коммиты данного репозитория верифицированы цифровой подписью. Поэтому выполнять проверку пакетов в "pacman" необязательно.

To add a repository to the system, edit the file: /etc/pacman.conf

Note the SigLevel string. All commits in this repository are digitally signed. Therefore, it is not necessary to check packages in "pacman".

[aur-kernel]

SigLevel = Never

Server = https://maximalisimus.github.io/repo/aur-kernel/$arch

Однако вы можете отказаться от строки SigLevel, но сначало установите публичные ключи для "pacman".

However, you can opt out of the SigLevel string, but first set the public keys for "pacman".

wget https://maximalisimus.github.io/elseworld-keyring/install-keyring.sh

sudo sh install-keyring.sh

Или загрузите и установите публичные ключи доступа вручную следующими командами.

Or download and install public access keys manually using the following commands.

sudo pacman-key --init

wget https://maximalisimus.github.io/elseworld-keyring/elseworld{.gpg,-revoked,-trusted,-id.txt}

sudo mv elseworld{.gpg,-revoked,-trusted} /usr/share/pacman/keyrings/

sudo pacman-key --add /usr/share/pacman/keyrings/elseworld.gpg

id_keyring=$(cat elseworld-id.txt)

sudo pacman-key --lsign-key ${id_keyring}

sudo pacman-key --populate archlinux elseworld

rm -rf elseworld-id.txt


