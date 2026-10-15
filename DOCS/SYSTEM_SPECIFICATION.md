# BUSINESS-OS System Specification

## Purpose

BUSINESS-OS is one unified business operating environment implemented around Assembly, FORTRAN, and MySQL. It presents the same business domain through SYSTEM/360-inspired, 8-bit, and 16-bit DOS terminal personalities.

## Architecture

```text
Terminal / Client
      |
Mode Adapter
      |
Command / Business API
      |
Business Services
      |
Repositories
      |
Prepared Statements
      |
Connection Pool
      |
Database Driver
      |
ASM ABI / Native Adapter
      |
MySQL
```

## Business domains

Account, customer, inventory, sales, accounting, invoice, ticket/support, email, reporting, analytics, and calculator.

## Account model

Accounts contain identity, credential metadata, role, enabled/locked state, failed-login count, and timestamps. Sessions are represented by server-side records. Passwords must be stored only as strong password hashes.

## Authorization

Roles include USER, ACCOUNTANT, MANAGER, ADMIN, and SUPERADMIN. Authorization is enforced at the service boundary before protected mutations or administrative operations.

## Data integrity

Financial operations use transactions. Inventory changes are atomic. Invoice totals are reproducible from invoice lines. Security-sensitive administrative actions produce audit records.

## Failure handling

Every API operation returns a normalized status. Database failures must never be reported as successful operations. Unrecoverable transaction failures cause rollback.

## Compatibility

The SYSTEM/360 personality is an interface/design personality unless a native System/360 target is separately implemented. The 16-bit mode is a target personality until a true DOS-compatible executable path is implemented. Modern native ASM uses x86-64 NASM where applicable.

## Security boundary

Legacy terminals must not receive database credentials. They communicate with a trusted server/service boundary. Modern clients may use a network API. Direct database access is reserved for trusted server-side components.
