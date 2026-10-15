# Native MySQL C Adapter

This directory contains the real MySQL client boundary used by the FORTRAN/ASM database layer.

Build with the MySQL client development package installed:

```bash
gcc -fPIC -I/usr/include/mysql -c C/MYSQL_ADAPTER.c -o MYSQL_ADAPTER.o
gfortran ... MYSQL_ADAPTER.o -lmysqlclient
```

On systems where the MySQL headers or library are installed elsewhere, use the paths reported by `mysql_config --cflags --libs`.

The adapter intentionally keeps credentials outside source control. TLS is requested by the adapter when enabled by the caller.
