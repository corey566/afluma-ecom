# ADR: API and event versioning

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Public APIs and event payloads are explicitly versioned. Consumers must tolerate additive fields. Breaking changes require a new major contract and a supported migration window.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
