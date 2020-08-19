#!/bin/bash
#
rm -rf ./index.html *.sig update.sh.sig
wait
# find ./ -type f -iname "*.tar.xz" -exec gpg2 -b {} \;
# wait
# find ./ -type f -iname "*.tar.zst" -exec gpg2 -b {} \;
find ./ -type f -exec gpg2 -b {} \;
wait
rm -rf ./index.html.sig update.sh.sig aur-kernel.db.sig aur-kernel.db.tar.gz.sig aur-kernel.db.tar.gz.old.sig aur-kernel.files.sig aur-kernel.files.tar.gz.sig aur-kernel.files.tar.gz.old.sig
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
a=0
rm -rf index.html.bp
touch index.html.bp
while read line; do
	if [[ $line == *"update.sh"* ]]; then
		let a+=1
	fi
	if [[ $a -eq 0 ]]; then
		echo "$line" >> index.html.bp
	elif [[ $a -le 3 ]]; then
		# echo "$line" # Debug
		let a+=1
	elif [[ $a -gt 3 ]]; then
		echo "$line" >> index.html.bp
	fi
done < index.html
wait
# rm -rf index.html && mv index.html.bp index.html
cp -f index.html.bp index.html && rm -rf index.html.bp
wait
exit 0
