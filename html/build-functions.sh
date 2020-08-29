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
