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
out_file="$filesdir/Release.html"									# Output HTML File
_html_dir="$filesdir/html"											# HTML Directory
_pkgbuild_version="${_pkgbuild_dir}/version.txt"						# PKGBUILD/version.txt
_flag_prepare_archive=1												# Flag preparation archivers to .PKGINFO .SRCINFO files
### Base info ###
