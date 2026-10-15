# Database Architecture

MySQL is the durable persistence layer for the multi-user business system.

## Layers

```text
Domain Service
 -> Repository
 -> Prepared Statement
 -> Connection Pool
 -> DB Driver
 -> ASM DB ABI
 -> MySQL
```

## Core tables

Users, roles, user_roles, customers, products, invoices, invoice lines, tickets, ticket messages, email messages, email attachments, accounting records, audit records and account sessions.

## Rules

- Use InnoDB for transactional business data.
- Use foreign keys for ownership relationships.
- Index primary lookup and foreign-key columns.
- Use transactions for financial and inventory mutations.
- Never concatenate untrusted values into SQL.
- Store password hashes, not passwords.
- Store session-token hashes, not raw long-lived tokens.
- Keep database credentials outside source control.

## Connection pooling

The Fortran pool owns a bounded set of logical database connections. A service acquires a connection, performs a short operation, commits or rolls back, and releases the connection.

## Result sets

Result-set objects provide iteration over rows and are intentionally separated from domain objects so database representation does not leak through the entire application.

## Legacy clients

16-bit and 8-bit clients should use a server-side database connection. Direct MySQL protocol implementation in a legacy client is not required.
