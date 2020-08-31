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
# echo -e -n "Name\t\t\t\tVersion\t\t\tArch\t\tDate\t\tLicense\n" #> "$filesdir/001.txt"
count=0
for i in ${_gz_name[*]}; do
	#_info_pkg=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Evi "_src")
	#_info_src=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Ei "_src")
	_info_pkg="${_pkginfo_dir}/${i}.txt"
	_info_src="${_pkginfo_dir}/${i}_src.txt"
	get_info_pkgs
	### DEBUG ###
	# echo -e -n "${_on_pkgname}\t\t\t${_on_pkgver}-${_on_pkgrel}\t\t${_on_pkgarch_v}\t\t${_on_date}\t${_on_pkglicense}\n" #>> "$filesdir/001.txt"
	# echo -e -n "${_on_pkgdepends[*]}\n" | xargs
	# echo -e -n "${_on_pkgoptdepends[*]}\n" | xargs
	# echo -e -n "${_on_pkgmakedepends[0]}\n"
	# if [[ ${_flag_md_i686[*]} == "1" ]]; then
	#	echo -e -n "${_on_pkgmakedepends_i686[*]}\n"
	# fi
	# if [[ ${_flag_md_x86_64[*]} == "1" ]]; then
	#	echo -e -n "${_on_pkgmakedepends_x86_64[*]}\n"
	# fi
	### DEBUG ###
	let count+=1
done
###
# end_archivers
cd "$filesdir/"
exit 0
