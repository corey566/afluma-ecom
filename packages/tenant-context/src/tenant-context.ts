import type { TenantRoute } from '@afluma/contracts/tenant';

export type AuthenticatedMembership = Readonly<{
  userId: string;
  tenantId: string;
  membershipId: string;
  permissions: readonly string[];
}>;

export function assertTenantBoundary(
  hostnameTenant: TenantRoute,
  membership: AuthenticatedMembership,
  resolvedDatabaseTenantId: string,
): void {
  if (hostnameTenant.status !== 'ACTIVE' && hostnameTenant.status !== 'RESTRICTED') {
    throw new Error('TENANT_NOT_AVAILABLE');
  }
  if (hostnameTenant.tenantId !== membership.tenantId) throw new Error('TENANT_TOKEN_MISMATCH');
  if (hostnameTenant.tenantId !== resolvedDatabaseTenantId) throw new Error('TENANT_DATABASE_MISMATCH');
}

export function extractTenantSlug(hostname: string, baseDomain: string): string {
  const normalized = hostname.toLowerCase().split(':')[0] ?? '';
  const suffix = `.${baseDomain.toLowerCase()}`;
  if (!normalized.endsWith(suffix)) throw new Error('UNRECOGNIZED_TENANT_DOMAIN');
  const slug = normalized.slice(0, -suffix.length);
  if (!/^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$/.test(slug)) throw new Error('INVALID_TENANT_SLUG');
  return slug;
}
