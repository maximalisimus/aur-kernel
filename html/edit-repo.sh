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
