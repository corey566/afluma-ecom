export type TenantStatus =
  | 'REGISTERED' | 'PAYMENT_PENDING' | 'PROVISIONING' | 'ACTIVE'
  | 'RESTRICTED' | 'SUSPENDED' | 'CANCELLATION_PENDING' | 'ARCHIVED'
  | 'DELETION_SCHEDULED' | 'DELETED' | 'PROVISIONING_FAILED';

export type TenantRoute = Readonly<{
  tenantId: string;
  slug: string;
  hostname: string;
  homeRegion: string;
  cellId: string;
  databaseClusterKey: string;
  databaseName: string;
  schemaVersion: number;
  status: TenantStatus;
}>;
