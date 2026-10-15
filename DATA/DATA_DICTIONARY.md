# Data Dictionary

| Field | Type | Input | Entry | Output | Notes |
|---|---|---:|---:|---:|---|
| `customer_id` | integer | No | Yes | Yes | Customer primary key |
| `name` | string | Yes | Yes | Yes | Display/business name |
| `email` | email | Yes | Yes | Yes | Valid email format |
| `phone` | string | Yes | Yes | Yes | Optional contact number |
| `address` | text | Yes | Yes | Yes | Optional address |
| `product_id` | integer | No | Yes | Yes | Product primary key |
| `sku` | string | Yes | Yes | Yes | Inventory stock keeping unit |
| `quantity` | integer | Yes | Yes | Yes | Must be zero or greater |
| `unit_price` | currency | Yes | Yes | Yes | Non-negative monetary value |
| `invoice_id` | integer | No | Yes | Yes | Invoice primary key |
| `subtotal` | currency | Yes | Yes | Yes | Amount before tax |
| `tax` | currency | No | Yes | Yes | Calculated tax |
| `tax_rate` | decimal | Yes | No | No | Fraction from 0 through 1 |
| `total` | currency | No | Yes | Yes | Subtotal plus tax |
| `status` | enum/string | No | Yes | Yes | Business lifecycle state |
| `username` | string | Yes | Yes | Yes | Login identifier |
| `role` | enum/string | No | Yes | Yes | USER, ACCOUNTANT, MANAGER, ADMIN, SUPERADMIN |
| `enabled` | boolean | No | Yes | Yes | Account enabled state |
| `locked` | boolean | No | Yes | Yes | Account lock state |
| `created_at` | datetime | No | Yes | Yes | Record creation timestamp |
| `updated_at` | datetime | No | Yes | Yes | Last record update |

## Rules

1. Validate input before business logic.
2. Normalize and validate entry records before persistence.
3. Never accept client-supplied calculated fields such as invoice tax or total as authoritative.
4. Use parameterized SQL for database writes.
5. Never place plaintext passwords or credentials in datasets.
6. Output fields are presentation contracts and must not expose secrets.
