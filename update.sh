#!/bin/bash
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_name_repo="aur-kernel"
_type="zst"
_repo_i686_type=( "zst" )
_repo_x86_64_type=( "zst" )
_repo_any_type=( "zst" )
_arches=("i686" "x86_64")
_flag_update=( "0" "1")
_repo_os_dir="${filesdir}/os"
_pkgbuild_dir="${filesdir}/PKGBUILD"
_pkgbuild_bool=1
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
function full_update()
{
	if [[ $_pkgbuild_bool -eq 1 ]]; then
		cd ${_pkgbuild_dir}
		md5sum * | grep -Evi "index.html|md5sums.txt" > md5sums.txt
		wait
		apindex .
		wait
	fi
	count=0
	for i in ${_arches[*]}; do
		if [[ $i == "i686" ]]; then
			if [[ ${_flag_update[$count]} -eq 1 ]]; then
				### DEBUG
				# echo "$i YES Update"
				### DEBUG
				cd ${_repo_os_dir}/$i
				for j in ${_repo_i686_type[*]}; do
					update_repo "$_name_repo" "$j"
					wait
					### DEBUG
					# echo "$j"
					### DEBUG
				done
				wait
			else
				cd ${_repo_os_dir}/$i
				apindex .
				wait
				### DEBUG
				# echo "$i NOT Update"
				### DEBUG
			fi
		elif [[ $i == "x86_64" ]]; then
			if [[ ${_flag_update[$count]} -eq 1 ]]; then
				### DEBUG
				# echo "$i YES Update"
				### DEBUG
				cd ${_repo_os_dir}/$i
				for j in ${_repo_x86_64_type[*]}; do
					update_repo "$_name_repo" "$j"
					wait
					### DEBUG
					# echo "$j"
					### DEBUG
				done
			else
				cd ${_repo_os_dir}/$i
				apindex .
				wait
				### DEBUG
				# echo "$i NOT Update"
				### DEBUG
			fi
		else
			if [[ ${_flag_update[$count]} -eq 1 ]]; then
				### DEBUG
				# echo "$i YES Update"
				### DEBUG
				for j in ${_repo_any_type[*]}; do
					update_repo "$_name_repo" "$j"
					wait
					### DEBUG
					# echo "$j"
					### DEBUG
				done
				### DEBUG
			else
				cd ${_repo_os_dir}/$i
				apindex .
				wait
				### DEBUG
				# echo "$i NOT Update"
				### DEBUG
			fi
		fi
		let count+=1
	done
	wait
	cd ${_repo_os_dir}
	apindex .
	wait
	cd ${filesdir}
}
wait
full_update
wait
exit 0
