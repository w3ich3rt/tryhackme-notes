# Brainpan 1
Brainpan is perfect for OSCP practice and has been highly recommended to complete before the exam. Exploit a buffer overflow vulnerability by analyzing a Windows executable on a Linux machine. If you get stuck on this machine, don't give up (or look at writeups), just try harder. 


All credit to superkojiman - This machine is used here with the explicit permission of the creator <3

__Answer the questions below__

## Task 1 - Deploy the machine.
```
Just start :D 
```

## Task 2 - Gain initial access
```
no answer needed.
```

## Task 3 - Escalate your privileges to root.
```
no answer needed.
```

### Notes

 - With gobuster we found an directory named `/bin`. There we will find the `brainpan.exe`.
 - Load exe into immunity debugger in my windows vm
 - Running fuzzing (600 bytes)
 - Finding offset
 - Finding bad chars
 - Setting payload and so on...

> BÄM Connected as `puck`

 - Go to `Z:\` --> its a linux!
 - Building linux payload
 - stabilize shell `python -c 'import pty; pty.spawn("/bin/bash")'`
 - `sudo -l`
 - trying `sudo /home/anansi/bin/anansi_util manual bash`
   - Okay we see the man-page ... gtfobins
 - in the manpage type `!/bin/bash`

> ROOT!!!!

Some notes...
> Had some trouble with normal reverseshell and the anansi tool... after stabilize shell with python it works.


