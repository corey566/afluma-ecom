import type { TenantRoute } from '@afluma/contracts/tenant';
import { assertTenantBoundary, type AuthenticatedMembership } from '@afluma/tenant-context/src/tenant-context.js';

export function authorizeTenantRequest(input: {
  route: TenantRoute;
  membership: AuthenticatedMembership;
  connectedDatabaseTenantId: string;
}): void {
  assertTenantBoundary(input.route, input.membership, input.connectedDatabaseTenantId);
}
