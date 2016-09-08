[bits 16]
; switch to protected mode
switch_to_pm:
    
    cli

    lgdt [gdt_descriptor]       ; load our GDT
    

    mov eax, cr0        ; to switch to protected mode, we
    or eax, 0x1         ; set the first bit of CR0 to a control register
    mov cr0, eax

    jmp CODE_SEG:init_pm

    
[bits 32]
; initilize registers and stack once in PM
init_pm:
    
    mov ax, DATA_SEG    ; old segments are meaningless
    mov ds, ax          ; point segment registers to data selector we defined in GDT
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp
    
    call BEGIN_PM   
