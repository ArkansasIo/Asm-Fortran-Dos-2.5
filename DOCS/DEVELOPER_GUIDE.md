# Developer Guide

## Source organization

- `ASM/` contains low-level runtime, ABI, console, memory, process, networking, filesystem, and database boundaries.
- `FORTRAN/` contains business objects, services, command handling, repositories, configuration, and database abstractions.
- `MYSQL/` contains schema and migrations.
- `CONFIG/` contains non-secret runtime configuration.
- `MODE_360/`, `MODE_8BIT/`, and `MODE_16BIT/` contain presentation adapters.
- `BUILD/` contains build and test documentation/scripts.
- `DOCS/` contains architecture and operational documentation.

## Coding rules

Use explicit interfaces and strong typing. Keep business rules out of terminal adapters. Keep SQL out of presentation code. Prefer transactions for multi-step mutations. Use prepared statements for values supplied by users.

## Object model

FORTRAN uses derived types and type-bound procedures where object-oriented behavior is appropriate. ASM uses structures, explicit object pointers, and function-pointer/vtable patterns when required.

## Service pattern

```text
Validate input
   -> Authenticate
   -> Authorize
   -> Begin transaction if required
   -> Repository operation
   -> Audit sensitive action
   -> Commit
   -> Return API response
```

## Error handling

Do not silently ignore database, allocation, I/O, or authentication failures. Convert subsystem errors into normalized API status values.

## Security

Never commit passwords, API keys, database secrets, session tokens, or private certificates. Configuration files should use environment-variable references for secrets.

## Testing

Unit-test calculations and validation. Integration-test repositories against a test MySQL database. Test authentication, authorization, transactions, concurrency, inventory consistency, invoice totals, and failure recovery.
