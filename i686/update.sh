#!/bin/bash
#
rm -rf *.sig
wait
# find ./ -type f -iname "*.tar.xz" -exec gpg2 -b {} \;
# wait
# find ./ -type f -iname "*.tar.zst" -exec gpg2 -b {} \;
find ./ -type f -exec gpg2 -b {} \;
wait
repo-add -n -R aur-kernel.db.tar.gz *.pkg.tar.zst
wait
rm -rf aur-kernel.db
wait
cp -f aur-kernel.db.tar.gz aur-kernel.db
wait
##optional-remove for old repo.db##
# rm -rf *gz.old{,.sig}
wait
apindex .
wait
exit 0
