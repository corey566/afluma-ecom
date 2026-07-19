# ADR: Modular monolith before microservices

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Afluma Commerce begins as a modular monolith with strict domain ownership. High-load or regulatory domains may be extracted only after measured operational need. This avoids premature distributed-system complexity while preserving service boundaries.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
