; CONFIG_API.ASM
; Low-level configuration ABI. Configuration parsing is performed by Fortran;
; these routines provide the assembly/runtime state boundary.

BITS 64
DEFAULT REL

global config_init
 global config_mode
 global config_database_enabled

section .data
 config_mode_value db '360',0
 config_db_enabled db 1

section .text
config_init:
    xor eax,eax
    ret

config_mode:
    lea rax,[rel config_mode_value]
    ret

config_database_enabled:
    movzx eax,byte [config_db_enabled]
    ret
