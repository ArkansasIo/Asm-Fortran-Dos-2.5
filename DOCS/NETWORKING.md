# Networking

## Model

```text
System/360 client --\
8-bit client --------> Business Server ---> MySQL
16-bit DOS client --/
```

The server owns authentication, authorization, database credentials, transactions and business rules.

## Protocol layers

1. Transport: TCP or another supported reliable transport.
2. Session: connection identification and authentication.
3. Message: request/response framing.
4. Business API: service name, operation, parameters and response status.
5. Persistence: server-side repositories.

## Message concept

A request contains a request identifier, service, operation, authenticated session context, and operation parameters. A response contains the request identifier, status, message, object identifier and result data.

## Compatibility

The wire representation should be simple enough for legacy clients while allowing modern clients to use the same server. A version field is required so protocol evolution does not silently break older clients.

## Failure handling

Clients must handle connection loss, timeout, authentication expiry, malformed responses and server-side errors. Financial operations should be assigned an idempotency key to prevent accidental duplicate execution after retries.
