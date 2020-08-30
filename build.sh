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
	echo ""
	#_info_pkg=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Evi "_src")
	#_info_src=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Ei "_src")
	_info_pkg="${_pkginfo_dir}/${i}.txt"
	_info_src="${_pkginfo_dir}/${i}_src.txt"
	_date_build=$(cat "${_info_pkg[*]}" | grep -Ei "^builddate" | sed "s/builddate = //g")
	_on_date=$(date -d @${_date_build[*]} +'%Y-%m-%d') 	### Date
	unset _date_build
	_on_pkgname=$(cat ${_info_src} | grep -Ei "^pkgbase" | sed "s/pkgbase = //g") # Package Name
	_on_pkgver=$(cat ${_info_src} | grep -Ei "^pkgver" | sed "s/pkgver = //g") # Package Version
	_on_pkgrel=$(cat ${_info_src} | grep -Ei "^pkgrel" | sed "s/pkgrel = //g") # Package Release
	_on_pkgdesc=$(cat ${_info_src} | grep -Ei "^pkgdesc" | sed "s/pkgdesc = //g") # Package Description
	_on_pkgarch=$(cat ${_info_src} | grep -Ei "^arch" | sed 's/arch = //g' | xargs) # Package arch
	_on_pkglicense=$(cat ${_info_src} | grep -Ei "^license" | sed 's/license = //g' | xargs) # Package License
	_on_pkgoptdepends=$(cat ${_info_src} | grep -Ei "^optdepends" | sed 's/optdepends = //g' | sed 's/:.*//g') # Package Optdepends
	_on_pkgdepends=$(cat ${_info_src} | grep -Ei "^depends" | sed 's/depends = //g') # Package depends
	# echo -e -n "${_on_pkgname}\t\t${_on_pkgver}-${_on_pkgrel}\t${_on_pkgarch}\t\t${_on_date}\t${_on_pkglicense}\n"
	# echo -e -n "${_on_pkgdepends[*]}\n" | xargs
	# echo -e -n "${_on_pkgoptdepends[*]}\n" | xargs
	
	let count+=1
done
###
# end_archivers
cd "$filesdir/"
exit 0
