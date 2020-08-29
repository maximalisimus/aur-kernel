#!/bin/bash
function unpack()
{
	case $1 in
		*.tar.gz) tar -xzf "$1" ;;
		*.tar.xz) tar -xJf "$1" .PKGINFO && mv .PKGINFO $filesdir/pkginfo.txt && sed -i '/^#/d' "$filesdir/pkginfo.txt" ;;
		*.tar.zst) tar --zstd -xf "$1" .PKGINFO && mv .PKGINFO $filesdir/pkginfo.txt && sed -i '/^#/d' "$filesdir/pkginfo.txt" ;;
	esac
}
function prepare_build()
{
	_gz_archivers=$(find ${_pkgbuild_dir} -type f -iname "*.tar.gz" | xargs)
	_gz_files=( $_gz_archivers )
	unset _gz_archivers
	_tmp=""
	_gz_for_dir=""
	for i in ${_gz_files[*]}; do
		_tmp=$(echo "$i" | rev | cut -d '/' -f1 | rev | sed 's/.tar.gz//g')
		_gz_for_dir="${_gz_for_dir[*]} ${_tmp[*]}"
	done
	_gz_dir=( $_gz_for_dir )
	unset _gz_for_dir
}
