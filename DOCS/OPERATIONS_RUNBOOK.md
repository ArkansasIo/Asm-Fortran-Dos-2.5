# Operations Runbook

## Startup

1. Verify MySQL is reachable.
2. Load database schema and migrations.
3. Provide database credentials through the deployment environment.
4. Start the business server/API.
5. Start terminal clients.
6. Verify authentication and database health endpoints.

## Shutdown

1. Stop new client sessions.
2. Allow active transactions to complete.
3. Close connection pools.
4. Flush audit/log output.
5. Shut down the service.

## Database backup

Use a tested MySQL backup procedure appropriate to the deployment. Verify restore procedures regularly; a backup that cannot be restored is not considered a reliable backup.

## Incident response

For authentication anomalies, revoke affected sessions and review account audit records. For database corruption or failed transactions, stop writes when necessary and restore from a verified recovery point.

## Monitoring

Monitor database connectivity, connection-pool utilization, authentication failures, API error rates, transaction failures, inventory inconsistencies, and service availability.

## Secrets

Secrets belong in the deployment environment or a dedicated secret manager, never in Git-tracked configuration files.
