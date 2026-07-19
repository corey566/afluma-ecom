# Tenant resolution sequence

```text
Browser → wildcard domain → application cell
                         → read hostname
                         → query control-plane tenant registry
                         → validate tenant status
                         → validate access-token membership
                         → resolve trusted database assignment
                         → compare hostname tenant == token tenant == database tenant
                         → execute tenant request
```

The client never submits a database name or database credential. Database assignments are resolved only from trusted control-plane state.
