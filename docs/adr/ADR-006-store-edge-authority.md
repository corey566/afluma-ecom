# ADR: Store Edge operational authority

- Status: Accepted for foundation
- Date: 2026-07-19

## Decision

Cloud is the long-term system of record. During loss of internet connectivity, Store Edge is temporary operational authority for one physical location and coordinates all reachable cashier devices over the local network.

## Consequences

Implementation and tests must enforce this decision. Any exception requires a superseding ADR.
