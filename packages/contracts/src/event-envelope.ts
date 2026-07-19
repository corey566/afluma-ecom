export type EventEnvelope<TPayload> = Readonly<{
  eventId: string;
  tenantId: string;
  locationId?: string;
  deviceId?: string;
  deviceSequence?: number;
  eventType: string;
  aggregateType: string;
  aggregateId: string;
  schemaVersion: number;
  occurredAt: string;
  recordedAt: string;
  idempotencyKey: string;
  correlationId: string;
  causationId?: string;
  payload: TPayload;
}>;
