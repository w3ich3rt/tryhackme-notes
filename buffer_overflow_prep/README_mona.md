# Set working dir
`!mona config -set workingfolder c:\mona\%p`

# find offset
Change distance to the used amount of bytes from fuzzer.

`!mona findmsp -distance 600`

# Bad Chars
To get bad chars, we need to check each run.
First set initial with this:
`!mona bytearray -b "\x00"`
After that check with ESP address:
`!mona compare -f C:\mona\oscp\bytearray.bin -a <address>`
You will get a list, just take the first one!
Set new bytearry with determined bad chars.

# Finding a Jump Point
`!mona jmp -r esp -cpb "<BAD CHARS> "`

Take first address from "log data" window.
