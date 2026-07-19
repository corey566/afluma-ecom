# Afluma Commerce Foundation

This repository is the technical starting point for Afluma Commerce.

## Locked tenancy decision

- One immutable, versioned application codebase.
- One verified tenant subdomain or custom domain.
- One central control-plane database.
- One logical PostgreSQL database per tenant by default.
- Shared application cells for SME plans; dedicated cells remain an enterprise option.
- Tenant databases may share a PostgreSQL cluster and can later move to dedicated clusters without changing the tenant-facing domain.

## First proof milestone

> Receive 10 units, disconnect cloud connectivity, sell 5 units through two cashiers connected to Store Edge, restore connectivity, synchronize exactly once, show 5 units remaining, and create balanced accounting journals.

## Repository map

- `apps/control-plane-api`: registration, pricing, provisioning and tenant registry.
- `apps/commerce-api`: tenant business APIs and domain modules.
- `apps/worker`: durable background jobs.
- `apps/web`: merchant administration web application.
- `apps/store-edge`: local store coordination service.
- `apps/pos-desktop`: Tauri desktop POS shell.
- `packages/contracts`: versioned API/event contracts.
- `packages/tenant-context`: hostname, token and database resolution rules.
- `database/control-plane`: platform registry schema.
- `database/tenant-template`: schema applied to every tenant database.
- `docs/adr`: approved architecture decisions.
- `tests/acceptance`: cross-domain executable scenarios.

## Local start

1. Copy `.env.example` to `.env`.
2. Run `docker compose up -d`.
3. Install Node.js, Corepack and pnpm.
4. Run `pnpm install`.
5. Run `pnpm validate:architecture`.
6. Start apps with `pnpm dev` after their implementation dependencies are installed.

This is a foundation scaffold, not a claim that the product is production-ready.
