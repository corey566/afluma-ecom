# ADR: Money and currency representation

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Amounts are stored as integer minor units with an ISO currency code. No floating-point arithmetic is allowed for money. Exchange rates use fixed-precision decimal values and preserve source, timestamp and rate type.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
