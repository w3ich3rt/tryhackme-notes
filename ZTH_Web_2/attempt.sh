#!/bin/bash

url="http://10.10.71.1/note.php?"
param="note="
counter=0

for i in {0..100}; 
	do 
		echo "Working on ID ${i}" # Because i love to see some lines flowing over the screen
		size=$(curl ${url}${param}${i} -w %{size_download} --silent --output /dev/null)
		echo "Pagesize: ${size}"
		if [[ ${size} > 0 ]]
		then
			echo "Checking for Content of ID ${i}"
			curl ${url}${param}${id}
		fi
	done

echo ""
