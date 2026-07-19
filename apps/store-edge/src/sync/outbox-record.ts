import type { EventEnvelope } from '@afluma/contracts/event-envelope';

export type OutboxRecord<T> = Readonly<{
  envelope: EventEnvelope<T>;
  state: 'PENDING' | 'SENDING' | 'ACKNOWLEDGED' | 'FAILED';
  attemptCount: number;
  nextAttemptAt?: string;
}>;

export function canDeleteOutboxRecord<T>(record: OutboxRecord<T>): boolean {
  return record.state === 'ACKNOWLEDGED';
}
