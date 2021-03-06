;
; A boot sector that boots a c kernel in 32 bit protected mode 
;
[org 0x7c00]
KERNEL_OFFSET equ 0x1000    ; memory offset to which we will load the kernel

    mov [BOOT_DRIVE], dl    ; BIOS stores boot drive in dl

    mov bp, 0x9000          ; setup the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE   ; announces we are starting from 16 bit real mode
    call print_string

    call load_kernel        ; load our kernel

    call switch_to_pm       ; switch to protected mode

    jmp $

; include routines
%include "print/print_string.nasm"
%include "disk/disk_load.nasm"
%include "pm/gdt.nasm"
%include "pm/print_string_pm.nasm"
%include "pm/switch_to_pm.nasm"

[bits 16]

; load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL  ; print a message to say we are loading kernel
    call print_string
    
    mov bx, KERNEL_OFFSET   ; set up parameters for our disk_load routine
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

[bits 32]
; this is where we switch to after switching to and initializing protected mode
BEGIN_PM:
    
    mov ebx, MSG_PROT_MODE  ; use 32-bit print routine to announce we are in 32-bit PM
    call print_string_pm

    call KERNEL_OFFSET      ; jumps to location of kernel code

    jmp $

; Global Vars
BOOT_DRIVE        db 0
MSG_REAL_MODE    db "Started  in 16-bit  Real  Mode", 0
MSG_PROT_MODE    db "Successfully  landed  in 32-bit  Protected  Mode", 0
MSG_LOAD_KERNEL  db "Loading  kernel  into  memory.", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55


    




