#Skynet

## 1. NMAP scan
First of all I'll do a nmapscan with `-sC -sV` on the target host.

```
PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 99:23:31:bb:b1:e9:43:b7:56:94:4c:b9:e8:21:46:c5 (RSA)
|   256 57:c0:75:02:71:2d:19:31:83:db:e4:fe:67:96:68:cf (ECDSA)
|_  256 46:fa:4e:fc:10:a5:4f:57:57:d0:6d:54:f6:c3:4d:fe (ED25519)
80/tcp  open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Skynet
110/tcp open  pop3        Dovecot pop3d
|_pop3-capabilities: SASL PIPELINING CAPA TOP RESP-CODES UIDL AUTH-RESP-CODE
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
143/tcp open  imap        Dovecot imapd
|_imap-capabilities: LITERAL+ IDLE Pre-login ID more post-login listed have ENABLE capabilities OK LOGINDISABLEDA0001 SASL-IR IMAP4rev1 LOGIN-REFERRALS
445/tcp open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
Service Info: Host: SKYNET; OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

## 2. Gobuster scan
Secondly I'll check web-service with `gobuster`.

## 3. SMB Checks

Used `enum4linux`.
See logfile

## 4. Password
Bruteforce password with burpsuite `cyborg007haloterminator`.
In the mails we can find the new password `)s{A&2Z=F^n_E.B``

## 5. Hidden dir
We can find the hidden directory in the smb share of milesdyson in the `notes` dir.
There is a file named `important.txt`.




