#!/bin/bash
#
rm -rf *.sig
rm -rf update.sh.sig
wait
# find ./ -type f -iname "*.tar.xz" -exec gpg2 -b {} \;
# wait
# find ./ -type f -iname "*.tar.zst" -exec gpg2 -b {} \;
find ./ -type f -exec gpg2 -b {} \;
wait
rm -rf ./index.html.sig
rm -rf update.sh.sig
rm -rf aur-nvidia-390xx.db.sig
rm -rf aur-nvidia-390xx.db.tar.gz.sig
rm -rf aur-nvidia-390xx.db.tar.gz.old.sig
rm -rf aur-nvidia-390xx.files.sig
rm -rf aur-nvidia-390xx.files.tar.gz.sig
rm -rf aur-nvidia-390xx.files.tar.gz.old.sig
wait
repo-add -n -R aur-nvidia-390xx.db.tar.gz *.pkg.tar{.xz,.zst}
wait
rm -rf aur-nvidia-390xx.db
wait
cp -f aur-nvidia-390xx.db.tar.gz aur-nvidia-390xx.db
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
