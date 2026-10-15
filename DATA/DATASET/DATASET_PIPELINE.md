# Dataset Pipeline

The unified data pipeline is:

INPUT FIELD -> VALIDATION -> ENTRY RECORD -> DATASET -> BUSINESS SERVICE -> DATABASE -> OUTPUT FIELD

## Input

Input fields represent values received from the web client, CLI, DOS mode, 8-bit mode, or System/360-inspired terminal.

## Entry

An entry record identifies the operation and groups validated fields into a business transaction.

## Dataset

Datasets provide structured collections for customers, products, invoices, users, inventory, tickets, accounting, and reports.

## Output

Output records use a consistent status, request ID, message, affected-row count, data object, and error collection.

## Rules

- Validate type, required state, length, range, and format before persistence.
- Never place passwords, session tokens, database passwords, or encryption keys in datasets.
- Database writes must use parameterized statements.
- Every request should carry a request ID for tracing.
- Financial mutations should support an idempotency key.
