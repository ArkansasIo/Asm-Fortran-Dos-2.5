# BUSINESS-OS Job Framework

The scheduler supports recurring background operations without putting scheduled work into interactive clients.

## Job lifecycle

```text
SCHEDULED -> QUEUED -> RUNNING -> SUCCEEDED
                         |
                         +-> FAILED -> RETRY -> DEAD_LETTER
```

## Job classes

- health checks
- report generation
- session cleanup
- audit retention
- database maintenance
- inventory reconciliation
- invoice reminders
- analytics aggregation
- backup verification

Production scheduling may use the included runner, native cron, systemd timers, Windows Task Scheduler, or a queue service. Jobs must be idempotent where retries are possible.
