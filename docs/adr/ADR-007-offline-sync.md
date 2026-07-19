# ADR: Offline event synchronization

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Offline synchronization transfers immutable, versioned events using globally unique IDs, device sequences, transactional outboxes, acknowledgements and idempotency keys. Whole-table replication is prohibited.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
