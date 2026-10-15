# BUSINESS-OS Documentation

## Purpose
BUSINESS-OS is a unified business application implemented around an ASM/Fortran core, a database abstraction layer, and a MySQL persistence backend.

## Runtime modes

- System/360-inspired terminal mode
- 8-bit terminal mode
- 16-bit DOS-style terminal mode

These are presentation/runtime modes over one business domain, not three independent applications.

## Major domains

Account management, customers, inventory, sales, accounting, invoices, tickets, email, reports, analytics, calculator, configuration, networking, files, and database services.

## Design principles

1. One domain model.
2. Data-driven configuration.
3. Explicit APIs between subsystems.
4. ASM used for low-level/runtime boundaries.
5. Fortran used for business logic and structured domain services.
6. MySQL used for durable multi-user state.
7. Network clients should use a server API rather than direct database access.
8. Credentials and secrets must not be committed to source control.

## Documentation index

- `ARCHITECTURE.md` — complete architecture
- `API_REFERENCE.md` — API contracts
- `DATABASE.md` — database architecture
- `SECURITY.md` — authentication and security model
- `NETWORKING.md` — server/client networking
- `UI_MODES.md` — terminal modes
- `MODULES.md` — business modules
- `BUILD.md` — build and deployment process
- `TESTING.md` — test strategy
- `OPERATIONS.md` — administration and operations
- `ROADMAP.md` — implementation roadmap
