# Runbook: tenant database migration

1. Mark the tenant migration as scheduled in the control plane.
2. Pause tenant write traffic or enter controlled drain mode.
3. Verify backup and point-in-time recovery position.
4. Copy database to target cluster using approved tooling.
5. Apply and verify schema version.
6. Run tenant health, row-count and ledger-balance checks.
7. Atomically update the control-plane database assignment.
8. Resume traffic and monitor errors, latency and sync backlog.
9. Retain source database during the rollback window.
