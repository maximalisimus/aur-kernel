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
# unpack "$filesdir/os/x86_64/linux-lts44-4.4.232-1-x86_64.pkg.tar.zst"
cd "${_pkgbuild_dir}"
prepare_build

cd "$filesdir/"
exit 0
