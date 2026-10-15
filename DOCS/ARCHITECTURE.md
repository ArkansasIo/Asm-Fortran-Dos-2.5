# Architecture

BUSINESS-OS is one application with three terminal personalities: System/360-inspired, 8-bit, and 16-bit DOS. All modes share the same business domain, command vocabulary, API and persistent data model.

```text
Terminal / Client
      |
      v
Mode Adapter
      |
      v
Command Layer
      |
      v
Business API
      |
      +----------------------+
      |                      |
      v                      v
Domain Services          Account/Security
      |                      |
      +----------+-----------+
                 v
          Repository Layer
                 |
          Prepared Statements
                 |
          Connection Pool
                 |
          Database Driver
                 |
             ASM ABI
                 |
               MySQL
```

## Runtime responsibilities

ASM provides low-level runtime, console, filesystem, network and database ABI boundaries. FORTRAN provides structured business logic, domain objects, calculations, reporting and command orchestration. MySQL provides durable multi-user state.

## Domain objects

User, Customer, Product, SalesOrder, Invoice, Ticket, EmailMessage, Report, LedgerEntry and CalculatorRequest are the principal business objects.

## Transaction boundary

Financial, inventory and account mutations must be transactional. A failed operation must roll back rather than leave partially applied state.

## Security boundary

Authentication and authorization are server-side concerns. Passwords must be salted and hashed, sessions must be revocable, SQL must use parameters, and database credentials must never be hard-coded into source or distributed clients.

## Network boundary

Legacy-style clients communicate with the server Business API. They do not connect directly to MySQL. This preserves compatibility across the three modes while centralizing security and business rules.
