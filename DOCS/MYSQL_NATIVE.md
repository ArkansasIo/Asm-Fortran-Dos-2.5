# Native MySQL Database Layer

BUSINESS-OS now has a defined native database ABI between the FORTRAN domain layer and the assembly layer.

```text
FORTRAN business/repository
        |
        v
FORTRAN/DATABASE/MYSQL_NATIVE.FOR
        |
        | ISO_C_BINDING
        v
ASM/DATABASE/MYSQL_C_API.ASM
        |
        v
MySQL client ABI
        |
        v
MySQL Server :3306
```

## Current implementation status

The assembly bridge is a stable ABI scaffold. It validates the database lifecycle and SQL boundary but does **not** yet call `libmysqlclient` directly.

The next production adapter must bind the MySQL C client functions (`mysql_init`, `mysql_real_connect`, `mysql_query`/prepared statements, result handling, and `mysql_close`) behind this interface.

## Configuration

`CONFIG/MYSQL_NATIVE.CFG` contains non-secret defaults. Production credentials must come from environment variables or a secret manager.

## Security requirements

- Never store a production MySQL password in Git.
- Use TLS for remote MySQL connections.
- Prefer prepared statements for user-controlled values.
- Do not expose MySQL directly to the browser or GitHub Pages.
- Use a restricted database account rather than root.
- Log database errors without logging passwords or session tokens.
