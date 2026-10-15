# Testing

## Unit tests

Test calculators, validation, permissions, accounting balance rules, inventory quantities, session expiration and report parameter validation.

## Integration tests

Test repository operations against an isolated MySQL database. Each test should create controlled fixtures and clean them afterward.

## Authentication tests

Cover registration, duplicate accounts, invalid credentials, disabled accounts, lockout, session expiry, logout, password changes and privilege escalation attempts.

## Transaction tests

Force failures during multi-step invoice, sales and inventory operations and verify that no partial state remains.

## Protocol tests

Test request framing, version negotiation, malformed messages, authentication expiry, timeouts, retries and idempotency.

## Compatibility tests

Run command and rendering tests for all three UI modes. Verify that shared API operations produce equivalent business results.

## Security tests

Include SQL injection, authorization bypass, replay, session fixation, credential leakage and malformed-input tests.
