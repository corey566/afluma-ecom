import { access, readFile } from 'node:fs/promises';

const required = [
  'docs/adr/ADR-001-modular-monolith.md',
  'docs/adr/ADR-002-database-per-tenant.md',
  'database/control-plane/001_initial.sql',
  'database/tenant-template/001_initial.sql',
  'packages/contracts/src/event-envelope.ts',
  'packages/tenant-context/src/tenant-context.ts',
  'tests/acceptance/offline-multi-cashier.feature'
];

for (const path of required) await access(path);
const tenantSql = await readFile('database/tenant-template/001_initial.sql', 'utf8');
for (const token of ['inventory_ledger_entries', 'journal_entries', 'sync_outbox', 'idempotency_keys']) {
  if (!tenantSql.includes(token)) throw new Error(`Missing required tenant schema token: ${token}`);
}
console.log('Architecture foundation validation passed.');
