# ADR: Double-entry accounting

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Every posted financial event creates a balanced journal. Posted journals are immutable; corrections use reversal or adjustment journals. Operational modules publish financial events rather than directly changing ledger balances.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
