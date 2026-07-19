# ADR: Idempotency and duplicate prevention

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Every externally retriable command affecting orders, payments, inventory or accounting requires an idempotency key. Replays must return the original outcome without duplicating side effects.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
