#!/bin/bash
### Base info
_name_repo="aur-kernel"												# Full Name repo
_full_arch=("any" "i686" "x86_64")										# Full type archive repos
_repo_i686_type=( "zst" )											# Archive on i686 repo update
_repo_x86_64_type=( "zst" )											# Archive on x86_64 repo update
_repo_any_type=( "zst" ) 											# Archive on any repo update
_arches=("i686" "x86_64") 											# Architecture on Repo
_flag_update=( "0" "1") 											# Update repo in x86_64 and not update i686
_repo_os_dir="${filesdir}/os"										# OS dir Repo
_pkgbuild_dir="${filesdir}/PKGBUILD"								# PKGBUILD Dir
_pkgbuild_bool=1 													# Flag PKGBUILD update
### HTML
_html_start="$filesdir/html/html_start.txt"							# HTML structure part start
_html_end="$filesdir/html/html_finish.txt"							# HTML structure part finish
_aur_search="https://aur.archlinux.org/packages/?O=0&K=" 			# AUR link search
_arch_search_start="https://www.archlinux.org/packages/?sort=&q="	# Archlinux.org search link part start
_arch_search_end="&maintainer=&flagged="							# Archlinux.org search link part finish
_tab_5="\t\t\t\t\t" 												# 5 tab
_tab_6="\t\t\t\t\t\t" 												# 6 tab
_tab_7="\t\t\t\t\t\t\t" 											# 7 tab
_tab_8="\t\t\t\t\t\t\t\t" 											# 8 tab
_tr_start="<tr>\n" 													# tr line start
_tr_end="</tr>\n" 													# tr line end
_td_start="<td>" 													# td cell start
_td_end="</td>" 													# td cell end
_a_open="<a href=\""												# <a href="
_a_part="\" onclick=\"view('hidden" 								# href="#hidden-n" part-1
_a_part2="'); return false" 										# href="#hidden-n" part-2
_a_close="\">"														# ">
_a_end="</a>"														# </a>
_div_start="<div id=\""												# div hidden block part 1
_div_part="\" style=\"display: none;\">"							# div hidden block part 2
_div_end="</div>"													# </div>
_br="<br>"															# <br>
