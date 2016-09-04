;
; Boot sector that prints 'Hello' to the screen using BIOS routine.
;

	mov ah, 0x0e

	mov al, 'H'
	int 0x10
	mov al, 'e'
	int 0x10
	mov al, 'l'
	int 0x10
	mov al, 'l'
	int 0x10
	mov al, 'o'
	int 0x10

	jmp $	; Jump to the current address (i.e. forever)

	times 510-($-$$) db 0 ; Pad boot sector with zeros

	dw 0xaa55	; let the BIOS know it has reached the end of a boot sector

