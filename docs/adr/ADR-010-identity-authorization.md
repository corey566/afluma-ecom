# ADR: Identity and authorization

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Authentication is central; authorization is tenant and membership aware. The hostname tenant, access-token tenant and resolved database tenant must match. Permissions are enforced server-side for every action.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
