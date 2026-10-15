# Architecture

BUSINESS-OS is one application with three terminal personalities:

1. SYSTEM/360-inspired
2. 8-bit
3. 16-bit DOS

All three use the same command vocabulary and business data. ASM provides low-level runtime/console primitives. FORTRAN implements business logic and command handling. MySQL stores users, roles, customers, inventory, invoices, tickets, email and audit data.

Authentication and authorization are server-side concerns. Passwords must be salted and hashed, and database credentials must not be hard-coded in source.
