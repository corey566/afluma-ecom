# Architecture overview

```text
                                  AFLUMA CONTROL PLANE
                          registration, pricing, billing, routing
                                           │
                              tenant registry + workflow engine
                                           │
                  ┌────────────────────────┼────────────────────────┐
                  │                        │                        │
              Cell LK-01               Cell LK-02               Future region
        stateless APIs/workers    stateless APIs/workers    stateless APIs/workers
                  │                        │
       ┌──────────┴─────────┐    ┌────────┴──────────┐
       │                    │    │                   │
 tenant_alpha DB       tenant_beta DB          tenant_gamma DB

Physical store:
Cloud cell ⇄ Store Edge ⇄ POS-01 / POS-02 / POS-03
```

## Request routing invariant

A request is accepted only when domain tenant, authenticated membership tenant, registry tenant and resolved database assignment all match.

## Data ownership

The control plane stores platform metadata. Merchant operational records remain only in the tenant database. Analytics receives explicitly approved events, not arbitrary cross-tenant SQL access.
