## Find files in filesystem

`Get-ChildItem -Path C:\ -Recurse -Include interesting*.txt -ErrorAction SilentlyContinue`

## Get list of cmdlets and count them
`Get-Command | Where-Object -Property CommandType -eq cmdlet | Measure-Object`


## Get MD5 Filehash
```powershell
PS C:\> Get-FileHash -Algorithm md5 '.\Program Files\interesting-file.txt.txt'

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
MD5             49A586A2A9456226F8A1B4CEC6FAB329                                       C:\Program Files\interesting-file.txt.txt
```

## Check if the directory exists

`Test-Path C:\Users\Administrator\Documents\Passwords`

## bas64 en- and decoding with powershell

Encoding:

`[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("TextToEncode"))`

Decoding:

`[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String(texttobedecoded'))`

### Solving the task

```powershell
PS C:\Users\Administrator\Desktop> $Filename=".\b64.txt"
PS C:\Users\Administrator\Desktop> $Filecontent = Get-Content $Filename
PS C:\Users\Administrator\Desktop> $filecontentdecoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Filecontent))
PS C:\Users\Administrator\Desktop> Write-Host "Decoded String: $filecontentdecoded"
Decoded String: this is the flag - ihopeyoudidthisonwindows
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
the rest is garbage
```

## Get Netconnections with listen state

```powershell
PS C:\Users\Administrator\Desktop> Get-NetTCPConnection | Where-Object -Property State -eq Listen | measure


Count    : 20
Average  :
Sum      :
Maximum  :
Minimum  :
Property :
```

## Get all installed patches/updates

`Get-HotFix`

Some examples:

```powershell
PS C:\Users\Administrator\Desktop> Get-HotFix | Where-Object -Property HotFixID -eq KB4023834

Source        Description      HotFixID      InstalledBy          InstalledOn
------        -----------      --------      -----------          -----------
EC2AMAZ-5M... Update           KB4023834     EC2AMAZ-5M13VM2\A... 6/15/2017 12:00:00 AM


PS C:\Users\Administrator\Desktop> Get-HotFix -ID KB4509091

Source        Description      HotFixID      InstalledBy          InstalledOn
------        -----------      --------      -----------          -----------
EC2AMAZ-5M... Security Update  KB4509091     NT AUTHORITY\SYSTEM  9/6/2019 12:00:00 AM
```

## Find files with specific content

`Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "API_KEY"`

## Do some scripting for a password search and some file iteration

```powershell
$path_mails = "C:\Users\Administrator\Desktop\emails\*"
$string_pattern = "password"
$command = Get-ChildItem -Path $path_mails -Recurse | Select-String -Pattern $string_pattern 
echo $command
```

## Little Portscanner

```powershell
$target = "localhost"
$portrange = 130..140

$portrange | % { Test-NetConnection $target -Port $_ -ErrorAction SilentlyContinue | Where-Object -Property TcpTestSucceeded -eq True }
```
