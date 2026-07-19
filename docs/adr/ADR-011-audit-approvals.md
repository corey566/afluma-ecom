# ADR: Audit and approvals

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Sensitive actions generate immutable audit events. Maker-checker approval is required for configured financial, payroll, stock, refund, pricing and privilege operations.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
