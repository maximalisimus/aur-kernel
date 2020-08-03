#!/bin/bash
#
repo-add -n -R aur-kernel.db.tar.gz *.pkg.tar.zst
wait
rm -rf aur-kernel.db
wait
cp -f aur-kernel.db.tar.gz aur-kernel.db
wait
apindex .
wait
exit 0
