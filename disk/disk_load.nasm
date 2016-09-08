; load DH sectors to ES:BX from drive DL
disk_load:
    push dx         ; Store DX on stack so we can always recall number of sectors to be read

    mov ah, 0x02    ; BIOS read sector function
    mov al, dh      ; read DH sectors
    mov ch, 0x00    ; select cylinder 0
    mov dh, 0x00    ; select head 0
    mov cl, 0x02    ; start reading from second sector (not boot sector)

    int 0x13        ; BIOS interrupt

    jc disk_error   ; jump if carry flag set -- i.e. there is an error

    pop dx          ; restore dx from stack
    cmp dh, al      ; if the number of read sectors doesnt match expected, print error
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Variables
DISK_ERROR_MSG db "Disk read error!", 0
