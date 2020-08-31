#!/bin/bash
function out_html_start()
{
	cat ${_html_start} > ${out_file}
	echo "Search for dependencies in official repositories and AUR."
}
function out_html_end()
{
	cat ${_html_end} >> ${out_file}
}
function out_tr_start()
{
	echo -e -n "${_tab_5}${_tr_start}" >> ${out_file}
}
function out_tr_end()
{
	echo -e -n "${_tab_5}${_tr_end}" >> ${out_file} ### TR
}
function out_td_name()
{
	### Name ###
	_pkg_of_name="$1"
	echo -e -n "${_tab_6}${_td_start}${_a_open}${_aur_search}" >> ${out_file}
	echo -e -n "${_pkg_of_name}${_a_close}${_pkg_of_name}${_a_end}${_td_end}\n" >> ${out_file}
	### Name ###
	unset _pkg_of_name
}
function out_td_version()
{
	_td_vers="$1"
	echo -e -n "${_tab_6}${_td_start}${_td_vers}${_td_end}\n" >> ${out_file}
	unset _td_vers
}
function out_td_arch()
{
	_td_arch="$1"
	echo -e -n "${_tab_6}${_td_start}${_td_arch}${_td_end}\n" >> ${out_file}
	unset _td_arch
}
function out_td_date()
{
	_td_date="$1"
	echo -e -n "${_tab_6}${_td_start}${_td_date}${_td_end}\n" >> ${out_file}
	unset _td_date
}
function out_td_license()
{
	_td_license="$1"
	echo -e -n "${_tab_6}${_td_start}${_td_license}${_td_end}\n" >> ${out_file}
	unset _td_license
}
function out_base_info()
{
	out_td_name "$1" # TD: Name
	out_td_version "$2" # TD: Version
	out_td_arch "$3" # TD: Architecture
	out_td_date "$4" # TD: Date
	out_td_license "$5" # TD: License
}
function out_td_depend_start()
{
	_number="$1"
	echo -e -n "${_tab_6}${_td_start}\n" >> ${out_file}
	echo -e -n "${_tab_7}${_a_open}#hidden${_number}${_a_part}${_number}${_a_part2}${_a_close}More detailed...${_a_end}\n" >> ${out_file}
	echo -e -n "${_tab_7}${_div_start}hidden${_number}${_div_part}\n" >> ${out_file}
	unset _number
}
function out_depend_part()
{
	_depend_name="$1"
	_pkg_srch=$(echo "$_depend_name" | sed "s/>=.*//g" | sed "s/<=.*//g")
	_search_result=$(pacman -Ss ${_pkg_srch[*]} | grep -Ei "core|extra|community|multilib" | wc -l)
	wait
	please_wait
	if [[ ${_search_result[*]} -ge 1 ]]; then
		echo -e -n "${_tab_8}${_a_open}${_arch_search_start}${_pkg_srch[*]}${_arch_search_end}${_a_close}" >> ${out_file}
		echo -e -n "${_depend_name}${_a_end}${_br}\n" >> ${out_file}
	else
		echo -e -n "${_tab_8}${_a_open}${_aur_search}${_pkg_srch[*]}${_a_close}" >> ${out_file}
		echo -e -n "${_depend_name}${_a_end}${_br}\n" >> ${out_file}
	fi
	wait
	unset _depend_name
	please_wait
}
function out_td_depend_mflag()
{
	if [[ ${1} -eq 0 ]]; then
		echo -e -n "${_tab_8}i686:${_br}\n" >> ${out_file}
	else
		echo -e -n "${_tab_8}x86_64:${_br}\n" >> ${out_file}
	fi
}
function out_td_depend_end()
{
	echo -e -n "${_tab_7}${_div_end}\n${_tab_6}${_td_end}\n" >> ${out_file}
}
function cut_html()
{
	sed -i "/<\/tbody>/q" "${out_file}"
	sed -i "/<\/tbody>/d" "${out_file}"
}
function paste_html()
{
	### End html ###
	out_html_end
	### End html ###
}
