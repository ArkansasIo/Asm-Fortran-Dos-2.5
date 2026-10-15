; BUSINESS_API.ASM
; x86-64 ABI boundary for the unified business API.
BITS 64
DEFAULT REL

global business_api_init
global business_api_shutdown
global business_api_status

gsection .data
api_initialized db 0
api_status dd 0

gsection .text
business_api_init:
    mov byte [api_initialized],1
    xor eax,eax
    mov [api_status],eax
    ret
business_api_shutdown:
    mov byte [api_initialized],0
    xor eax,eax
    mov [api_status],eax
    ret
business_api_status:
    movzx eax,byte [api_initialized]
    ret
