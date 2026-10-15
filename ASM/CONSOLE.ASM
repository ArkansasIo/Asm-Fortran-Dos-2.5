; Terminal output helper
BITS 64
default rel
global asm_console_write
extern asm_strlen
section .text
asm_console_write:
    push rdi
    call asm_strlen
    mov rdx, rax
    pop rsi
    mov eax, 1
    mov edi, 1
    syscall
    ret
