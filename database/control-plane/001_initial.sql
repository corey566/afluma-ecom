CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TYPE tenant_status AS ENUM (
  'REGISTERED','PAYMENT_PENDING','PROVISIONING','ACTIVE','RESTRICTED',
  'SUSPENDED','CANCELLATION_PENDING','ARCHIVED','DELETION_SCHEDULED',
  'DELETED','PROVISIONING_FAILED'
);

CREATE TABLE tenants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  display_name text NOT NULL,
  status tenant_status NOT NULL DEFAULT 'REGISTERED',
  home_region text NOT NULL,
  cell_id text NOT NULL,
  schema_version integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE tenant_domains (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  hostname text NOT NULL UNIQUE,
  is_primary boolean NOT NULL DEFAULT false,
  verification_status text NOT NULL DEFAULT 'pending',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE database_assignments (
  tenant_id uuid PRIMARY KEY REFERENCES tenants(id) ON DELETE CASCADE,
  cluster_key text NOT NULL,
  database_name text NOT NULL UNIQUE,
  secret_reference text NOT NULL,
  migration_status text NOT NULL DEFAULT 'pending',
  target_schema_version integer NOT NULL DEFAULT 0,
  last_migrated_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE plans (
  id text PRIMARY KEY,
  name text NOT NULL,
  active boolean NOT NULL DEFAULT true
);

CREATE TABLE subscriptions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(id),
  plan_id text NOT NULL REFERENCES plans(id),
  status text NOT NULL,
  trial_ends_at timestamptz,
  current_period_ends_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE feature_entitlements (
  tenant_id uuid NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  feature_key text NOT NULL,
  enabled boolean NOT NULL,
  limit_value bigint,
  PRIMARY KEY (tenant_id, feature_key)
);

CREATE TABLE provisioning_runs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  workflow_version integer NOT NULL,
  current_step text NOT NULL,
  status text NOT NULL,
  attempt integer NOT NULL DEFAULT 1,
  error_code text,
  error_detail jsonb,
  started_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
