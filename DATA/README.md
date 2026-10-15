# Unified Data, Input, Entry, and Output Layer

This directory defines the shared data contract used by the BUSINESS-OS server, clients, FORTRAN services, ASM runtime, mainframe-style UI, 8-bit UI, 16-bit DOS UI, and MySQL persistence layer.

## Data flow

```text
INPUT FIELD
   -> ENTRY VALIDATION
   -> DATASET RECORD
   -> BUSINESS SERVICE
   -> DATABASE / COMPUTATION
   -> OUTPUT FIELD
```

The same logical fields are used across all three UI modes.

## Files

- `FIELD_TYPES.json` - canonical field types and validation rules.
- `INPUT_FIELDS.json` - user-facing input definitions.
- `ENTRY_FIELDS.json` - record-entry definitions and required fields.
- `OUTPUT_FIELDS.json` - output/report definitions.
- `DATASET_SCHEMA.json` - dataset and record schema.
- `datasets/customers.json` - sample customer dataset.
- `datasets/products.json` - sample inventory dataset.
- `datasets/invoices.json` - sample invoice dataset.
- `datasets/users.json` - sample account dataset.
- `DATA_DICTIONARY.md` - human-readable field dictionary.

No passwords, API keys, database passwords, or other secrets belong in these files.
