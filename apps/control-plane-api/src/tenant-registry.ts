import type { TenantRoute } from '@afluma/contracts/tenant';

export interface TenantRegistry {
  resolveByHostname(hostname: string): Promise<TenantRoute | null>;
  reserveSlug(slug: string, displayName: string): Promise<{ tenantId: string }>;
  setProvisioningState(tenantId: string, step: string, status: string): Promise<void>;
}
