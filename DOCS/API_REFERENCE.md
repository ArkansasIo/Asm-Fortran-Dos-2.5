# API Reference

## Response

`api_response` contains `status`, `http_status`, `object_id`, `message`, and an optional session token.

## Context

`api_context` identifies the authenticated user, role and session. Protected services require `authenticated=.true.` and appropriate permissions.

## Account

- `api_register_user(username,email,password_hash,status)`
- `api_login(email,password,status,session_token)`
- `api_logout(session_token,status)`
- Account disable, role and permission operations belong to the account service.

## Customer

- Create customer
- Update customer
- Search customer
- Retrieve customer
- Delete customer

## Inventory

- Create product
- Update product
- Search product
- Add stock
- Remove stock
- Inventory adjustment

## Sales

- Create order
- Add order line
- Calculate order
- Complete order
- Cancel order
- Record payment

## Accounting

- Create account
- Post journal entry
- Validate debit/credit balance
- Query ledger
- Produce account balance

## Invoice

- Create invoice
- Add invoice line
- Calculate tax/total
- Issue invoice
- Record payment
- Void invoice

## Tickets

- Open ticket
- Assign ticket
- Add message
- Change status
- Close ticket

## Email

- Compose message
- Queue message
- Send message
- Reply
- Store attachment metadata

## Reporting

Reports are named operations with a requested format and row limit. Supported targets include sales, inventory, accounting, customers, tickets and financial summaries.

## Calculator

The business calculator supports arithmetic plus future extensions for profit, margin, tax, ROI, break-even, loans and cash flow.

## Errors

`0` OK, `1` generic error, `2` unauthorized, `3` forbidden, `4` not found, `5` validation failure, `6` database failure, `7` conflict.
