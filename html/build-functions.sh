#!/bin/bash
function unpack()
{
	please_wait
	wait
	case $1 in
		*.tar.gz) tar -xzf "$1" ;;
		*.tar.xz) tar -xJf "$1" .PKGINFO && mv .PKGINFO "${_pkginfo_dir}/$2.txt" && sed -i '/^#/d' "${_pkginfo_dir}/$2.txt" ;;
		*.tar.zst) tar --zstd -xf "$1" .PKGINFO && mv .PKGINFO "${_pkginfo_dir}/$2.txt" && sed -i '/^#/d' "${_pkginfo_dir}/$2.txt" ;;
	esac
	wait
	please_wait
	wait
}
function prepare_build()
{
	_gz_archivers=$(find ${_pkgbuild_dir} -type f -iname "*.tar.gz" | xargs)
	_gz_files=( $_gz_archivers )
	unset _gz_archivers
	_tmp=""
	_gz_for_name=""
	for i in ${_gz_files[*]}; do
		_tmp=$(echo "$i" | rev | cut -d '/' -f1 | rev | sed 's/.tar.gz//g')
		_gz_for_name="${_gz_for_name[*]} ${_tmp[*]}"
	done
	_gz_name=( $_gz_for_name )
	unset _gz_for_name
}
function prepare_archivers()
{
	###
	mkdir -p ${_pkginfo_dir}
	echo "Unpacking information from zst (xz) archives and gz sources."
	for i in ${_gz_name[*]}; do
		_xz_zst_name=$(find "${_repo_os_dir}/x86_64/" -type f -iname "$i*" | grep -Evi "*.sig|headers")
		unpack "${_xz_zst_name[*]}" "$i"
	done
	counter=0
	for i in ${_gz_files[*]}; do
		cd "${_pkgbuild_dir}"
		unpack "$i"
		wait
		_temp=$(echo "$i" | rev | cut -d '/' -f1 | rev | sed 's/.tar.gz//g')
		cd "${_pkgbuild_dir}/${_temp[*]}"
		makepkg --printsrcinfo | sed 's/^[ \t]*//' | awk '!/^$/{print $0}' | grep -Evi "^source|^sha256sums|^md5sums" >> srcinfo.txt
		mv srcinfo.txt "${_pkginfo_dir}/${_temp}_src.txt"
		let counter+=1
		cd "$filesdir/"
		rm -rf "${_pkgbuild_dir}/${_temp[*]}"
	done
	###
}
function end_archivers()
{
	rm -rf "${_pkginfo_dir}"
}
function get_info_pkgs()
{
	_date_build=$(cat "${_info_pkg[*]}" | grep -Ei "^builddate" | sed "s/builddate = //g")
	_on_date=$(date -d @${_date_build[*]} +'%Y-%m-%d') 	### Date
	unset _date_build
	_on_pkgname=$(cat ${_info_src} | grep -Ei "^pkgbase" | sed "s/pkgbase = //g") # Package Name
	_on_pkgver=$(cat ${_info_src} | grep -Ei "^pkgver" | sed "s/pkgver = //g") # Package Version
	_on_pkgrel=$(cat ${_info_src} | grep -Ei "^pkgrel" | sed "s/pkgrel = //g") # Package Release
	_on_pkgdesc=$(cat ${_info_src} | grep -Ei "^pkgdesc" | sed "s/pkgdesc = //g") # Package Description
	_on_pkgarch=$(cat ${_info_src} | grep -Ei "^arch" | sed 's/arch = //g' | xargs) # Package arch
	_on_pkgarch_v=$(cat ${_info_src} | grep -Ei "^arch" | sed 's/arch = //g' | xargs | tr ' ' '_') # Package arch version.txt
	_on_pkglicense=$(cat ${_info_src} | grep -Ei "^license" | sed 's/license = //g' | xargs) # Package License
	_as_pkgoptdepends=$(cat ${_info_src} | grep -Ei "^optdepends" | sed 's/optdepends = //g' | sed 's/:.*//g' | xargs)
	_on_pkgoptdepends=( $_as_pkgoptdepends ) # Package Optdepends
	unset _as_pkgoptdepends
	_as_pkgdepends=$(cat ${_info_src} | grep -Ei "^depends" | sed 's/depends = //g' | xargs)
	_on_pkgdepends=( $_as_pkgdepends ) # Package Depends
	unset _as_pkgdepends
	_flag_md_i686=$(cat ${_info_src} | grep -Ei "^makedepends" | grep -Ei "i686|x86_64" | grep -Ei "i686" | wc -l) # Flag to makepedends_i686
	_flag_md_x86_64=$(cat ${_info_src} | grep -Ei "^makedepends" | grep -Ei "i686|x86_64" | grep -Ei "x86_64" | wc -l) # Flag to makedepends_x86_64
	_as_pkgmakedepends=$(cat ${_info_src} | grep -Ei "^makedepends" | grep -Evi "i686|x86_64" | sed 's/makedepends = //g' | xargs) # Package makedepends
	_on_pkgmakedepends=( $_as_pkgmakedepends )
	unset _as_pkgmakedepends
	if [[ ${_flag_md_i686[*]} == "1" ]]; then
		_as_pkgmakedepends_i686=$(cat ${_info_src} | grep -Ei "^makedepends" | grep -Ei "i686|x86_64" | grep -Ei "i686" | sed 's/makedepends_i686 = //g' | sed 's/makedepends_x86_64 = //g' | xargs)
		_on_pkgmakedepends_i686=( $_as_pkgmakedepends_i686 )
		unset _as_pkgmakedepends_i686
		# Package makedepends_i686
	fi
	if [[ ${_flag_md_x86_64[*]} == "1" ]]; then
		_as_pkgmakedepends_x86_64=$(cat ${_info_src} | grep -Ei "^makedepends" | grep -Ei "i686|x86_64" | grep -Ei "x86_64" | sed 's/makedepends_i686 = //g' | sed 's/makedepends_x86_64 = //g' | xargs)
		_on_pkgmakedepends_x86_64=( $_as_pkgmakedepends_x86_64 )
		unset _as_pkgmakedepends_x86_64
		# Package makedepends_x86_64
	fi
}
