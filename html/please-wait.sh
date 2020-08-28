#!/bin/bash
pleasewait=1
function please_wait()
{
	if [[ $pleasewait -eq 2 ]]; then
		let pleasewait-=1
		echo -n  -e "\e[1;34mPlease wait: $x ...\e[0m"\\r
	else
		let pleasewait+=1
		echo -n  -e "\e[1;33mPlease wait: $x ...\e[0m"\\r
	fi
}
