# Mainframe Client Framework

This directory defines the presentation framework for the SYSTEM/360-inspired client.

The mainframe personality shares the BUSINESS-OS API and domain model with the web and DOS clients.

## Screen model

```text
+----------------------------------------------------------+
| BUSINESS-OS / SYSTEM-360                 USER: ADMIN     |
+----------------------------------------------------------+
| COMMAND | CUSTOMER | INVENTORY | SALES | ACCOUNTING      |
+----------------------------------------------------------+
|                                                          |
|                         APPLICATION                      |
|                                                          |
+----------------------------------------------------------+
| STATUS: ONLINE                         DB: CONNECTED     |
+----------------------------------------------------------+
```

The eventual native terminal implementation belongs in `MODE_360/` and communicates through the same server protocol.
