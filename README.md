# repo
# https://github.com/maximalisimus/repo.git

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


