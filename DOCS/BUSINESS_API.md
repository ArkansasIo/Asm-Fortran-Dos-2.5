# Business API

The Business API is the unified application boundary for the ASM + FORTRAN + MySQL business operating system.

## Services

- Authentication and accounts
- Customers
- Inventory and products
- Sales
- Accounting
- Invoices
- Tickets/support
- Email
- Reports and analytics
- Business calculator
- Audit/security

## Architecture

```text
System/360 Mode  ─┐
8-bit Mode       ─┼─> Unified Command/API ─> FORTRAN Services ─> Database Layer ─> MySQL
16-bit DOS Mode  ─┘             │
                                └──────────────> ASM ABI
```

## API response

Every service should return `api_response` containing a status code, HTTP-style status, object identifier, message, and optional session token.

## Security

Authentication must be required for protected operations. Authorization must be enforced by role/permission. Passwords and session credentials must never be stored in plaintext. Database writes should use prepared statements rather than SQL string concatenation.

## Service groups

`ACCOUNT`, `CUSTOMER`, `INVENTORY`, `SALES`, `ACCOUNTING`, `INVOICE`, `TICKET`, `EMAIL`, `REPORT`, `CALCULATOR`.

The API is intentionally transport-neutral so the same business layer can be used by the System/360-style terminal, 8-bit terminal, 16-bit DOS terminal, local client, or future network client.
