; BUSINESS-OS low-level x86-64 ASM kernel helpers
BITS 64
default rel
global asm_strlen
global asm_clear_registers
section .text
asm_strlen:
    xor rax, rax
.loop:
    cmp byte [rdi+rax], 0
    je .done
    inc rax
    jmp .loop
.done:
    ret

asm_clear_registers:
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
