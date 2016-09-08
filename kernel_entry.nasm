; insures we jump straight into the kernels entry function
[bits 32]
[extern main]

call main

jmp $
