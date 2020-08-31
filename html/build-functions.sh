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
function out_version_txt()
{
	echo -e -n "${_on_pkgname}\t\t\t${_on_pkgver}-${_on_pkgrel}\t\t${_on_pkgarch_v}\t\t${_on_date}\t${_on_pkglicense}\n" >> "${_pkgbuild_version}"
}
function out_html_string()
{
	### Output html string info ###
	out_tr_start ### TR
	out_base_info "${_on_pkgname[*]}" "${_on_pkgver[*]}-${_on_pkgrel[*]}" "${_on_pkgarch[*]}" "${_on_date[*]}" "${_on_pkglicense[*]}" # name / version / arch / date / license
	wait
	out_td_depend_start "$count" # TD: Dependens start
	wait
	for i in ${_on_pkgdepends[*]}; do
		out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
	done
	wait
	out_td_depend_end # TD: Dependens end
	let count+=1
	wait
	out_td_depend_start "$count" # TD: Optdependens start
	wait
	for j in ${_on_pkgoptdepends[*]}; do
		out_depend_part "$j" # TD: a link in packages on search to aur or archlinux.org
	done
	wait
	out_td_depend_end # TD: Optdependens end
	let count+=1
	wait
	out_td_depend_start "$count" # TD: Makedependenses start
	wait
	for k in ${_on_pkgmakedepends[*]}; do
		out_depend_part "$k" # TD: a link in packages on search to aur or archlinux.org
	done
	wait
	if [[ ${_flag_md_i686[*]} == "1" ]]; then
		out_td_depend_mflag "0" # Out 8 tabulation and text: "i686:"
		wait
		for i in ${_on_pkgmakedepends_i686[*]}; do
			out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
		done
		wait
	fi
	wait
	if [[ ${_flag_md_x86_64[*]} == "1" ]]; then
		out_td_depend_mflag "1" # Out 8 tabulation and text: "x86_64:"
		wait
		for i in ${_on_pkgmakedepends_x86_64[*]}; do
			out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
		done
		wait
	fi
	wait
	out_td_depend_end # TD: Makedependenses end
	wait
	echo -e -n "${_tab_6}${_td_start}${_on_pkgdesc}${_td_end}\n" >> ${out_file} # TD: Description
	out_tr_end ### TR
	let count+=1
	wait
	### Output html string info ###
}
function full_build()
{
	### Full Build ###
	if [[ $_flag_prepare_archive -eq 1 ]]; then
		prepare_archivers
	fi
	echo -e -n "Name\t\t\t\tVersion\t\t\tArch\t\tDate\t\tLicense\n" > "${_pkgbuild_version}"
	### Start html ###
	out_html_start
	### Start html ###
	count=1
	for i in ${_gz_name[*]}; do
		#_info_pkg=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Evi "_src")
		#_info_src=$(find "${_pkginfo_dir}" -type f -iname "$i*" | grep -Ei "_src")
		_info_pkg="${_pkginfo_dir}/${i}.txt"
		_info_src="${_pkginfo_dir}/${i}_src.txt"
		wait
		get_info_pkgs
		wait
		out_version_txt
		wait
		out_html_string
		wait
	done
	### End html ###
	out_html_end
	### End html ###
	cd "$filesdir/"
	end_archivers
	### Full Build ###
}
