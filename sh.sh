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
### Start html ###
out_html_start
### Start html ###
out_tr_start ### TR
out_base_info "rstudio-desktop-git" "1.2.5033.r5032-1" "i686 x86_64" "2020-08-03" "AGPL3" # name / version / arch / date / license
### Debug ###
_depend=("r>=3.0.1" boost-libs qt5-sensors qt5-svg qt5-webengine qt5-xmlpatterns postgresql-libs sqlite3 soci clang hunspell-en_US mathjax2 pandoc)
### Debug ###
out_td_depend_start "1" # TD: Dependens start
for i in ${_depend[*]}; do
	out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
done
out_td_depend_end # TD: Dependens end
### Debug ###
_outdepend=(git subversion openssh-askpass)
### Debug ###
out_td_depend_start "2" # TD: Optdependens start
for i in ${_outdepend[*]}; do
	out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
done
out_td_depend_end # TD: Optdependens end
### Debug ###
_makedependens=(git cmake boost desktop-file-utils jdk8-openjdk apache-ant unzip openssl libcups pam patchelf wget yarn)
### Debug ###
out_td_depend_start "3" # TD: Makedependenses start
for i in ${_makedependens[*]}; do
	out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
done
### MakeDepend Flag ###
if [[ ${_flag_md_i686[*]} == "1" ]]; then
	out_td_depend_mflag "0" # Out 8 tabulation and text: "i686:"
	for i in ${_on_pkgmakedepends_i686[*]}; do
		out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
	done
fi
if [[ ${_flag_md_x86_64[*]} == "1" ]]; then
	out_td_depend_mflag "1" # Out 8 tabulation and text: "x86_64:"
	for i in ${_on_pkgmakedepends_x86_64[*]}; do
		out_depend_part "$i" # TD: a link in packages on search to aur or archlinux.org
	done
fi
### MakeDepend Flag ###
out_td_depend_end # TD: Makedependenses end
### Debug ###
_desc="A powerful and productive integrated development environment (IDE) for R programming language"
### Debug ###
echo -e -n "${_tab_6}${_td_start}${_desc}${_td_end}\n" >> ${out_file} # TD: Description
out_tr_end ### TR
### End html ###
out_html_end
### End html ###
wait
exit 0
