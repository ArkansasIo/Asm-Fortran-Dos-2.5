# Build

Prerequisites: NASM, GNU Fortran and MySQL.

The ASM layer targets x86-64 NASM for modern development. The three terminal modes are unified presentation layers. MySQL is the persistent data layer.

Typical build flow:

    nasm -f elf64 ASM/KERNEL.ASM -o kernel.o
    gfortran -c FORTRAN/MAIN.FOR FORTRAN/BUSINESS.FOR
    mysql -u root -p < MYSQL/schema.sql

Database credentials belong in protected deployment configuration; do not commit real passwords.
