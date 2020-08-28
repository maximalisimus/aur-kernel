#!/bin/bash
### Base info
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
### HTML
_html_start="$filesdir/html/html_start.txt"
_html_end="$filesdir/html/html_finish.txt"
_aur_search="https://aur.archlinux.org/packages/?O=0&K=" # aur link
_arch_search_start="https://www.archlinux.org/packages/?sort=&q="
_arch_search_end="&maintainer=&flagged="
_tab_5="\t\t\t\t\t" # 5 tab
_tab_6="\t\t\t\t\t\t" # 6 tab
_tab_7="\t\t\t\t\t\t\t" # 7 tab
_tab_8="\t\t\t\t\t\t\t\t" # 8 tab
_tr_start="<tr>\n" # line start
_tr_end="</tr>\n" # line end
_td_start="<td>" # td cell start
_td_end="</td>" # td cell end
_a_open="<a href=\""
_a_part="\" onclick=\"view('hidden" # href="#hidden-n" part-1
_a_part2="'); return false" # href="#hidden-n" part-2
_a_close="\">"
_a_end="</a>"
_div_start="<div id=\""
_div_part="\" style=\"display: none;\">"
_div_end="</div>"
_br="<br>"
