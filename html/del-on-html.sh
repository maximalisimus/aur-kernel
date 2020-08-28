#!/bin/bash
function del_on_html()
{
	_html_file="$1"
	_del_string="$2"
	a=0
	rm -rf ${_html_file}.bp
	touch ${_html_file}.bp
	while read line; do
		if [[ $line == *"${_del_string}"* ]]; then
			let a+=1
		fi
		wait
		if [[ $a -eq 0 ]]; then
			echo "$line" >> ${_html_file}.bp
		elif [[ $a -le 3 ]]; then
			# echo "$line" # Debug
			let a+=1
		elif [[ $a -gt 3 ]]; then
			echo "$line" >> ${_html_file}.bp
		fi
		wait
	done < ${_html_file}
	wait
	unset _del_string
	# rm -rf ${_html_file} && mv ${_html_file}.bp ${_html_file}
	cp -f ${_html_file}.bp ${_html_file} && rm -rf ${_html_file}.bp
	wait
}
