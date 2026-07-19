export type ProvisioningStep =
  | 'RESERVE_DOMAIN'
  | 'ASSIGN_CELL'
  | 'CREATE_DATABASE'
  | 'MIGRATE_DATABASE'
  | 'SEED_COUNTRY_PACK'
  | 'CREATE_STORAGE_NAMESPACE'
  | 'CREATE_OWNER_MEMBERSHIP'
  | 'CONFIGURE_ROUTE'
  | 'VERIFY_HEALTH'
  | 'ACTIVATE';

export interface ProvisioningContext {
  tenantId: string;
  slug: string;
  countryPack: string;
  businessRecipe: string;
}

export interface DurableProvisioningWorkflow {
  run(context: ProvisioningContext): Promise<void>;
  resume(tenantId: string): Promise<void>;
}

// Implementation rule: each step records success before the workflow advances.
// Repeating a completed step must return the original outcome.
