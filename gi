#!/bin/bash
if [ "$#" == 0 ]; then
	echo "Ussage: gi <language>"
	exit
fi
mode=0;
if [ -f '.gitignore' ]; then
	echo ".gitignore exists"
	options=("Overwrite", "Append", "Quit");
	select opt in "${options[@]}";
	do
		case $opt in
			"Overwrite,")
				break
				;;
			"Append,")
				mode=1;
				break
				;;
			"Quit")
				exit;
				;;
			*) echo "invalid option";;
		esac
	done
fi
count=`curl -s "http://www.gitignore.io/api/list" | grep -o -i ",$1," | wc -w | tr -d ' '`;
if [ "$count" -lt 1 ]; then
	echo "no .gitignore template found";
	exit
fi
if [ "$mode" == 0 ]; then
	curl -s -o .gitignore  "http://www.gitignore.io/api/$1";
elif [ "$mode" == 1 ]; then
	curl -s "http://www.gitignore.io/api/$1" >> .gitignore 
fi
