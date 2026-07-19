# ADR: Inventory ledger and reservations

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Inventory truth is an immutable movement ledger. Balances are projections. Sales reserve or commit stock through atomic operations. Corrections use compensating movements rather than destructive edits.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
