BITS 64
DEFAULT REL

section .text
global mysql_native_c_init
global mysql_native_c_connect
global mysql_native_c_status
global mysql_native_c_execute
global mysql_native_c_begin
global mysql_native_c_commit
global mysql_native_c_rollback
global mysql_native_c_error
global mysql_native_c_close

; These symbols are provided by C/MYSQL_ADAPTER.c.
; This assembly unit documents and exposes the ABI symbols for the
; FORTRAN/ASM build graph. Calls follow the System V x86-64 ABI.

extern mysql_native_c_init
extern mysql_native_c_connect
extern mysql_native_c_status
extern mysql_native_c_execute
extern mysql_native_c_begin
extern mysql_native_c_commit
extern mysql_native_c_rollback
extern mysql_native_c_error
extern mysql_native_c_close
