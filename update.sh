#!/bin/bash
function del_on_html()
{
	_del_string="$1"
	a=0
	rm -rf index.html.bp
	touch index.html.bp
	while read line; do
		if [[ $line == *"${_del_string}"* ]]; then
			let a+=1
		fi
		wait
		if [[ $a -eq 0 ]]; then
			echo "$line" >> index.html.bp
		elif [[ $a -le 3 ]]; then
			# echo "$line" # Debug
			let a+=1
		elif [[ $a -gt 3 ]]; then
			echo "$line" >> index.html.bp
		fi
		wait
	done < index.html
	wait
	unset _del_string
	# rm -rf index.html && mv index.html.bp index.html
	cp -f index.html.bp index.html && rm -rf index.html.bp
	wait
}
cd PKGBUILD
md5sum * | grep -Evi "update.sh|index.html|md5sums.txt" > md5sums.txt
wait
apindex .
wait
del_on_html "update.sh"
cd ../
exit 0
