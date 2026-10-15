# Security

## Authentication

Users authenticate through the server account service. Passwords must be processed by a real password-hashing implementation before production use.

## Sessions

Sessions require expiration, revocation and server-side validation. Production sessions should use cryptographically random opaque tokens; only a hash of the token should be persisted.

## Authorization

Roles include USER, ACCOUNTANT, MANAGER, ADMIN and SUPERADMIN. Permissions must be checked at the service boundary, not only in the user interface.

## Database security

Prepared statements are mandatory for user-controlled values. SQL string concatenation is prohibited in production authentication and CRUD paths.

## Secrets

Database passwords, encryption keys, signing keys and service credentials must come from environment variables or an external secret store. Never commit real secrets to Git.

## Audit

Security-sensitive events should be recorded: login success/failure, lockout, logout, password change, role change, account disablement, privileged actions and administrative data changes.

## Network

Use encrypted transport for production remote connections. Legacy clients should connect to a controlled API gateway/server rather than directly to MySQL.

## Current implementation status

The repository contains architecture and service scaffolding. It must not be described as production-secure until real password hashing, cryptographic token generation, parameterized database execution, transport security and comprehensive tests are implemented.
