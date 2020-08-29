#!/bin/bash
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_sh_files=$(find "$filesdir/html" -maxdepth 1 -type f -iname "*.sh" | xargs)
_files=( $_sh_files )
unset _sh_files
for i in ${_files[*]}; do
	source $i
done
unset _files
wait
prepare_build
# prepare_archivers
###
count=0
for i in ${_gz_name[*]}; do
	# _info_pkg=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Evi "_src")
	# _info_src=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Ei "_src")
	_info_pkg="${_pkginfo_dir}/$i.txt"
	_info_src="${_pkginfo_dir}/$i_src.txt"
	_date_build=$(cat "${_info_pkg[*]}" | grep -Ei "^builddate" | sed "s/builddate = //g")
	_on_date=$(date -d @${_date_build[*]} +'%Y-%m-%d') 	### Date
	unset _date_build
	
	let count+=1
done
###
# end_archivers
cd "$filesdir/"
exit 0
