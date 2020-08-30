#!/bin/bash
function update_repo()
{
	_repo_name="$1"
	_archive="$2"
	rm -rf ./index.html *.sig
	wait
	# find ./ -type f -iname "*.tar.xz" -exec gpg2 -b {} \;
	# wait
	# find ./ -type f -iname "*.tar.zst" -exec gpg2 -b {} \;
	find ./ -type f -exec gpg2 -b {} \;
	wait
	rm -rf ./index.html.sig ${_repo_name}.db.sig ${_repo_name}.db.tar.gz.sig ${_repo_name}.db.tar.gz.old.sig ${_repo_name}.files.sig ${_repo_name}.files.tar.gz.sig ${_repo_name}.files.tar.gz.old.sig
	wait
	repo-add -n -R ${_repo_name}.db.tar.gz *.pkg.tar.${_archive}
	wait
	rm -rf ${_repo_name}.db
	wait
	cp -f ${_repo_name}.db.tar.gz ${_repo_name}.db
	wait
	##optional-remove for old repo.db##
	# rm -rf *gz.old{,.sig}
	wait
	apindex .
	wait
}
function update_any_repo()
{
	_in_flags="$1"
	if [[ ${_in_flags} -eq 1 ]]; then
		for j in ${_repo_any_type[*]}; do
			update_repo "$_name_repo" "$j"
			wait
		done
	fi
	wait
	apindex .
	wait
}
function update_i686_repo()
{
	_in_flags="$1"
	if [[ ${_in_flags} -eq 1 ]]; then
		for j in ${_repo_i686_type[*]}; do
			update_repo "$_name_repo" "$j"
			wait
		done
	fi
	wait
	apindex .
	wait
}
function update_x86_64_repo()
{
	_in_flags="$1"
	if [[ ${_in_flags} -eq 1 ]]; then
		for j in ${_repo_x86_64_type[*]}; do
			update_repo "$_name_repo" "$j"
			wait
		done
	fi
	wait
	apindex .
	wait
}
function update_pkg_repo()
{
	_architectures="$1"
	_work_dir="$2"
	_on_flags="$3"
	cd ${_work_dir}
	case ${_architectures} in
		"${_full_arch[0]}") update_any_repo "${_on_flags}";;
		"${_full_arch[1]}") update_i686_repo "${_on_flags}";;
		"${_full_arch[2]}") update_x86_64_repo "${_on_flags}";;
	esac
}
function full_update()
{
	if [[ $_pkgbuild_bool -eq 1 ]]; then
		cd ${_pkgbuild_dir}
		sha256sum * | grep -Evi "index.html|sha256sums.txt" > sha256sums.txt
		wait
		apindex .
		wait
	fi
	count=0
	for i in ${_arches[*]}; do
		update_pkg_repo "$i" "${_repo_os_dir}/$i" "${_flag_update[$count]}"
		let count+=1
	done
	wait
	cd ${_repo_os_dir}
	apindex .
	wait
	cd ${filesdir}
}
