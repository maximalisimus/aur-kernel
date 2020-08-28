#!/bin/bash
function out_td_name()
{
	### Name ###
	_td_of_file="$1"
	_pkg_of_name="$2"
	echo -e -n "${_tab_6}${_td_start}${_a_open}${_aur_search}" >> ${_td_of_file}
	echo -e -n "${_pkg_of_name}${_a_close}${_pkg_of_name}${_a_end}${_td_end}\n" >> ${_td_of_file}
	### Name ###
	unset _td_of_file
	unset _pkg_of_name
}
function out_td_version()
{
	_td_of_file="$1"
	_td_vers="$2"
	echo -e -n "${_tab_6}${_td_start}${_td_vers}${_td_end}\n" >> ${_td_of_file}
	unset _td_vers
	unset _td_of_file
}
function out_td_arch()
{
	_td_of_file="$1"
	_td_arch="$2"
	echo -e -n "${_tab_6}${_td_start}${_td_arch}${_td_end}\n" >> ${_td_of_file}
	unset _td_arch
	unset _td_of_file
}
function out_td_date()
{
	_td_of_file="$1"
	_td_date="$2"
	echo -e -n "${_tab_6}${_td_start}${_td_date}${_td_end}\n" >> ${_td_of_file}
	unset _td_date
	unset _td_of_file
}
function out_td_license()
{
	_td_of_file="$1"
	_td_license="$2"
	echo -e -n "${_tab_6}${_td_start}${_td_license}${_td_end}\n" >> ${_td_of_file}
	unset _td_license
	unset _td_of_file
}
function out_base_info()
{
	out_td_name "${out_file}" "$1" # TD: Name
	out_td_version "${out_file}" "$2" # TD: Version
	out_td_arch "${out_file}" "$3" # TD: Architecture
	out_td_date "${out_file}" "$4" # TD: Date
	out_td_license "${out_file}" "$5" # TD: License
}
function out_td_depend_start()
{
	_td_of_file="$1"
	_number="$2"
	echo -e -n "${_tab_6}${_td_start}\n" >> ${_td_of_file}
	echo -e -n "${_tab_7}${_a_open}#hidden${_number}${_a_part}${_number}${_a_part2}${_a_close}More detailed...${_a_end}\n" >> ${_td_of_file}
	echo -e -n "${_tab_7}${_div_start}hidden${_number}${_div_part}\n" >> ${_td_of_file}
	unset _number
	unset _td_of_file
}
function out_depend_part()
{
	please_wait
	_td_of_file="$1"
	_depend_name="$2"
	_pkg_srch=$(echo "$_depend_name" | sed "s/>=.*//g" | sed "s/<=.*//g")
	_search_result=$(pacman -Ss ${_pkg_srch[*]} | grep -Ei "core|extra|community|multilib" | wc -l)
	wait
	please_wait
	if [[ ${_search_result[*]} -ge 1 ]]; then
		echo -e -n "${_tab_8}${_a_open}${_arch_search_start}${_pkg_srch[*]}${_arch_search_end}${_a_close}" >> ${_td_of_file}
		echo -e -n "${_depend_name}${_a_end}${_br}\n" >> ${_td_of_file}
	else
		echo -e -n "${_tab_8}${_a_open}${_aur_search}${_pkg_srch[*]}${_a_close}" >> ${_td_of_file}
		echo -e -n "${_depend_name}${_a_end}${_br}\n" >> ${_td_of_file}
	fi
	wait
	unset _depend_name
	unset _td_of_file
	please_wait
}
function out_td_depend_end()
{
	_td_of_file="$1"
	echo -e -n "${_tab_7}${_div_end}\n${_tab_6}${_td_end}\n" >> ${_td_of_file}
	unset _td_of_file
}
