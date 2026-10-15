#!/usr/bin/env python3
"""Session cleanup boundary.

Actual cleanup should execute a parameterized DELETE against account_sessions
where revoked_at is set or expires_at is in the past.
"""
print('session cleanup: database adapter boundary ready')
