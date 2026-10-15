# Operations Guide

## Startup

1. Verify configuration.
2. Verify database availability.
3. Start the Business Server.
4. Verify API health.
5. Start clients.

## Shutdown

Stop accepting new requests, allow active transactions to complete, close database connections and terminate the server cleanly.

## Backups

Back up the MySQL database on a schedule appropriate to business requirements. Test restoration regularly rather than assuming backups are usable.

## Monitoring

Monitor process health, database connectivity, connection-pool exhaustion, request latency, failed logins, lockouts, transaction failures and disk capacity.

## Logs

Logs should contain timestamps, severity, subsystem, request identifier and safe diagnostic information. Passwords, session tokens and database credentials must never be logged.

## Recovery

For database outages, clients should display a controlled service-unavailable state. Financial operations must be retried only when their idempotency behavior is known.

## Administration

Administrative actions should require the appropriate role and produce audit records.
