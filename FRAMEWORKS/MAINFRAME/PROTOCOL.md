# Mainframe Framework Protocol

The mainframe, DOS, 8-bit, CLI, and web clients use the same logical request model.

```text
CLIENT
  -> REQUEST_ID
  -> PROTOCOL_VERSION
  -> AUTHENTICATION CONTEXT
  -> SERVICE
  -> OPERATION
  -> PARAMETERS

SERVER
  -> REQUEST_ID
  -> STATUS
  -> MESSAGE
  -> OBJECT_ID
  -> RESULT DATA
```

Clients must never receive database credentials. Authentication is performed by the server. Financial mutations should carry an idempotency key.
