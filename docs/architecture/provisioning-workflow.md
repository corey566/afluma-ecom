# Tenant provisioning workflow

1. Reserve slug and domain.
2. Create tenant registry record in `PROVISIONING` state.
3. Assign region and application cell.
4. Create logical tenant database.
5. Apply tenant schema migrations.
6. Seed country pack, chart of accounts, roles and selected business recipe.
7. Create object-storage namespace and encryption context.
8. Create owner membership.
9. Configure domain route and certificate.
10. Run health verification.
11. Mark tenant `ACTIVE` only after all checks pass.

Every step is durable, retryable and idempotent. A failed step resumes; it does not create another tenant database.
