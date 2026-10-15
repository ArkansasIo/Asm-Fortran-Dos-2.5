; DB_API.ASM
; x86-64 assembly boundary for the database subsystem.
; The actual MySQL client implementation is kept behind this ABI.

BITS 64
DEFAULT REL

global db_init
 global db_shutdown
 global db_status
 global db_execute

section .data
 db_connected db 0
 db_last_status dd 0

section .text

db_init:
    mov byte [db_connected],1
    xor eax,eax
    mov [db_last_status],eax
    ret

db_shutdown:
    mov byte [db_connected],0
    xor eax,eax
    mov [db_last_status],eax
    ret

db_status:
    movzx eax,byte [db_connected]
    ret

; RDI = pointer to UTF-8 SQL string
; Returns EAX=0 when accepted, 1 when not connected/invalid.
db_execute:
    cmp byte [db_connected],0
    je .error
    test rdi,rdi
    jz .error
    xor eax,eax
    mov [db_last_status],eax
    ret
.error:
    mov eax,1
    mov [db_last_status],eax
    ret
