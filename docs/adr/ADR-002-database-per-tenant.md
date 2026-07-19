# ADR: Database per tenant

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Each tenant receives a separate logical PostgreSQL database. Databases may share a managed cluster. A central control plane stores tenant routing and schema status but never merchant operational records. This improves isolation, backup, restoration and later movement to dedicated clusters.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
