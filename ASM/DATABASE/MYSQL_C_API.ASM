; MYSQL_C_API.ASM
; Stable x86-64 ABI boundary for the native MySQL client adapter.
; The symbols below are intentionally small and dependency-free so the
; higher-level database layer can be linked before libmysqlclient is added.

BITS 64
DEFAULT REL

global mysql_abi_init
global mysql_abi_shutdown
global mysql_abi_status

global mysql_abi_execute

global mysql_abi_begin
global mysql_abi_commit
global mysql_abi_rollback

section .data
mysql_abi_connected db 0
mysql_abi_last_status dd 0

section .text

mysql_abi_init:
    mov byte [mysql_abi_connected], 1
    xor eax, eax
    mov [mysql_abi_last_status], eax
    ret

mysql_abi_shutdown:
    mov byte [mysql_abi_connected], 0
    xor eax, eax
    mov [mysql_abi_last_status], eax
    ret

mysql_abi_status:
    movzx eax, byte [mysql_abi_connected]
    ret

; RDI = UTF-8 SQL string
; Returns EAX=0 accepted, EAX=1 rejected.
mysql_abi_execute:
    cmp byte [mysql_abi_connected], 0
    je .error
    test rdi, rdi
    jz .error
    xor eax, eax
    mov [mysql_abi_last_status], eax
    ret

mysql_abi_begin:
    mov rdi, begin_sql
    jmp mysql_abi_execute

mysql_abi_commit:
    mov rdi, commit_sql
    jmp mysql_abi_execute

mysql_abi_rollback:
    mov rdi, rollback_sql
    jmp mysql_abi_execute

.error:
    mov eax, 1
    mov [mysql_abi_last_status], eax
    ret

section .rodata
begin_sql db 'START TRANSACTION',0
commit_sql db 'COMMIT',0
rollback_sql db 'ROLLBACK',0
