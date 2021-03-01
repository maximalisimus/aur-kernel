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

wait
exit 0
