;
; prints null terminated string using BIOS routine
;

print_string:
    pusha

    loop:
        mov al, [bx]    ; move next character in string to al register
        cmp al, 0       ; if we reached terminating character,return
        je return
    
        mov ah, 0x0e    ; load BIOS teletype routine and print
        int 0x10        ; contents of al
    
        inc bx          ; increment bx register to next character
        jmp loop

    return:
        popa
        ret
