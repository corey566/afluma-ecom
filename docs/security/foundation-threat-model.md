# Foundation threat model

Primary threats addressed in the first milestone:

- Hostname/token/database tenant mismatch.
- Guessing another tenant's identifiers.
- Worker jobs losing tenant context.
- Duplicate offline events.
- Out-of-order device events.
- Local database theft or tampering.
- Device certificate compromise.
- Overselling through concurrent cashiers.
- Unbalanced or duplicated accounting postings.
- Provisioning retries creating duplicate databases.

Security tests are release gates, not optional hardening work.
