#!/usr/bin/env python3
"""Security-service boundary.

Credential hashing/verification should be implemented with a vetted native
cryptographic library in production. This module intentionally does not store
or compare plaintext passwords in persistent storage.
"""
import hashlib, hmac, secrets

def new_session_token():
    return secrets.token_urlsafe(32)

def token_hash(token):
    return hashlib.sha256(token.encode('utf-8')).hexdigest()

def constant_time_equal(a,b):
    return hmac.compare_digest(a,b)
