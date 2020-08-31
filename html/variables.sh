#!/bin/bash
### Base info ###
_name_repo="aur-kernel"												# Full Name repo
_full_arch=("any" "i686" "x86_64")									# Full type archive repos
_repo_i686_type=( "zst" )											# Archive on i686 repo update
_repo_x86_64_type=( "zst" )											# Archive on x86_64 repo update
_repo_any_type=( "zst" ) 											# Archive on any repo update
_arches=("i686" "x86_64") 											# Architecture on Repo
_flag_update=( "0" "1") 											# Update repo in x86_64 and not update i686
_repo_os_dir="${filesdir}/os"										# OS dir Repo
_pkgbuild_dir="${filesdir}/PKGBUILD"								# PKGBUILD Dir
_pkgbuild_bool=1 													# Flag PKGBUILD update
out_file="$filesdir/primer.html"									# Output HTML File
_html_dir="$filesdir/html"											# HTML Directory
### Base info ###
### HTML ###
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
### HTML ###
### Build Function ###
declare -a _gz_files												# *.tar.gz archivers
declare -a _gz_name													# dirname on directory *.tar.gz archivers
_xz_zst_name=""														# *.tar.xz or *.tar.zst archivers
_pkginfo_dir="$filesdir/pkginfo"									# .PKGINFO Directory
_info_pkg=""														# .PKGINFO File to pkginfo directory
_info_src=""														# .SRCINFO File to pkginfo directory
_on_date=""															# Date
_on_pkgname=""														# Package Name
_on_pkgver=""														# Package Version
_on_pkgrel=""														# Package Release
_on_pkgdesc=""														# Package Description
_on_pkgarch=""														# Package arch
_on_pkgarch_v=""													# Package arch version.txt
_on_pkglicense=""													# Package License
_on_pkgoptdepends=""												# Package Optdepends
_on_pkgdepends=""													# Package Depends
_flag_md_i686=""													# Flag to makepedends_i686
_flag_md_x86_64=""													# Flag to makedepends_x86_64
_on_pkgmakedepends=""												# Package makedepends
_on_pkgmakedepends_i686=""											# Package makedepends_i686
_on_pkgmakedepends_x86_64=""										# Package makedepends_x86_64
### Build Function ###
