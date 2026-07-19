CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE tenant_metadata (
  singleton boolean PRIMARY KEY DEFAULT true CHECK (singleton),
  tenant_id uuid NOT NULL UNIQUE,
  schema_version integer NOT NULL,
  country_pack_key text NOT NULL,
  country_pack_version text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE users (
  id uuid PRIMARY KEY,
  email text NOT NULL,
  display_name text NOT NULL,
  status text NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX users_email_lower_uidx ON users (lower(email));

CREATE TABLE locations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  location_type text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE devices (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  location_id uuid NOT NULL REFERENCES locations(id),
  device_code text NOT NULL UNIQUE,
  device_type text NOT NULL,
  certificate_thumbprint text,
  status text NOT NULL DEFAULT 'active',
  last_seen_at timestamptz
);

CREATE TABLE products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  status text NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE product_variants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id),
  sku text NOT NULL UNIQUE,
  barcode text UNIQUE,
  name text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE price_books (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  currency_code char(3) NOT NULL,
  valid_from timestamptz,
  valid_to timestamptz
);

CREATE TABLE price_book_entries (
  price_book_id uuid NOT NULL REFERENCES price_books(id),
  variant_id uuid NOT NULL REFERENCES product_variants(id),
  amount_minor bigint NOT NULL CHECK (amount_minor >= 0),
  PRIMARY KEY (price_book_id, variant_id)
);

CREATE TABLE inventory_ledger_entries (
  id uuid PRIMARY KEY,
  location_id uuid NOT NULL REFERENCES locations(id),
  variant_id uuid NOT NULL REFERENCES product_variants(id),
  movement_type text NOT NULL,
  quantity_delta numeric(20,6) NOT NULL CHECK (quantity_delta <> 0),
  reference_type text NOT NULL,
  reference_id uuid NOT NULL,
  occurred_at timestamptz NOT NULL,
  recorded_at timestamptz NOT NULL DEFAULT now(),
  idempotency_key text NOT NULL UNIQUE
);
CREATE INDEX inventory_ledger_lookup_idx ON inventory_ledger_entries(location_id, variant_id, occurred_at);

CREATE TABLE inventory_balances (
  location_id uuid NOT NULL REFERENCES locations(id),
  variant_id uuid NOT NULL REFERENCES product_variants(id),
  on_hand numeric(20,6) NOT NULL DEFAULT 0,
  reserved numeric(20,6) NOT NULL DEFAULT 0,
  version bigint NOT NULL DEFAULT 0,
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (location_id, variant_id),
  CHECK (reserved >= 0)
);

CREATE TABLE orders (
  id uuid PRIMARY KEY,
  location_id uuid NOT NULL REFERENCES locations(id),
  channel text NOT NULL,
  status text NOT NULL,
  currency_code char(3) NOT NULL,
  subtotal_minor bigint NOT NULL,
  tax_minor bigint NOT NULL,
  discount_minor bigint NOT NULL DEFAULT 0,
  total_minor bigint NOT NULL,
  occurred_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  CHECK (total_minor = subtotal_minor + tax_minor - discount_minor)
);

CREATE TABLE order_lines (
  id uuid PRIMARY KEY,
  order_id uuid NOT NULL REFERENCES orders(id),
  variant_id uuid NOT NULL REFERENCES product_variants(id),
  quantity numeric(20,6) NOT NULL CHECK (quantity > 0),
  unit_price_minor bigint NOT NULL CHECK (unit_price_minor >= 0),
  tax_minor bigint NOT NULL DEFAULT 0,
  discount_minor bigint NOT NULL DEFAULT 0,
  line_total_minor bigint NOT NULL
);

CREATE TABLE payments (
  id uuid PRIMARY KEY,
  order_id uuid NOT NULL REFERENCES orders(id),
  method text NOT NULL,
  status text NOT NULL,
  amount_minor bigint NOT NULL CHECK (amount_minor > 0),
  currency_code char(3) NOT NULL,
  occurred_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  account_type text NOT NULL
);

CREATE TABLE journal_entries (
  id uuid PRIMARY KEY,
  source_type text NOT NULL,
  source_id uuid NOT NULL,
  status text NOT NULL DEFAULT 'posted',
  occurred_at timestamptz NOT NULL,
  posted_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (source_type, source_id)
);

CREATE TABLE journal_lines (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  journal_entry_id uuid NOT NULL REFERENCES journal_entries(id),
  account_id uuid NOT NULL REFERENCES accounts(id),
  debit_minor bigint NOT NULL DEFAULT 0 CHECK (debit_minor >= 0),
  credit_minor bigint NOT NULL DEFAULT 0 CHECK (credit_minor >= 0),
  currency_code char(3) NOT NULL,
  CHECK ((debit_minor = 0) <> (credit_minor = 0))
);

CREATE TABLE idempotency_keys (
  scope text NOT NULL,
  key text NOT NULL,
  request_hash text NOT NULL,
  resource_type text,
  resource_id uuid,
  response_code integer,
  response_body jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  expires_at timestamptz NOT NULL,
  PRIMARY KEY (scope, key)
);

CREATE TABLE sync_outbox (
  event_id uuid PRIMARY KEY,
  device_id uuid NOT NULL REFERENCES devices(id),
  device_sequence bigint NOT NULL,
  event_type text NOT NULL,
  aggregate_type text NOT NULL,
  aggregate_id uuid NOT NULL,
  schema_version integer NOT NULL,
  payload jsonb NOT NULL,
  occurred_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  acknowledged_at timestamptz,
  UNIQUE (device_id, device_sequence)
);

CREATE TABLE sync_inbox (
  event_id uuid PRIMARY KEY,
  source_device_id uuid NOT NULL,
  received_at timestamptz NOT NULL DEFAULT now(),
  processed_at timestamptz,
  processing_status text NOT NULL DEFAULT 'received',
  error_code text
);

CREATE TABLE audit_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_user_id uuid,
  actor_device_id uuid,
  action text NOT NULL,
  entity_type text NOT NULL,
  entity_id uuid,
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  occurred_at timestamptz NOT NULL DEFAULT now()
);
