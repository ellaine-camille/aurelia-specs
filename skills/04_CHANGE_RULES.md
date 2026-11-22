# 04 — Change Rules

**Purpose:** identify lockstep sets and hidden dependencies before changes.

**Confidence note:** verified against the current specifications and repository README files on 2026-11-22. Lockstep sets are expected from future implementation, not present today.

## Lockstep sets

1. **User levels and feature access** - [business-logic-v1.0.md](../business-logic-v1.0.md)
   - Files: future API authorization, web navigation/UI, Android navigation/UI, specs.
   - Miss -> unauthorized or hidden features disagree across clients.
2. **System requirements and MVP features** - [business-logic-v1.0.md](../business-logic-v1.0.md)
   - Files: feature specifications, API routes, web/Android UI, tests.
   - Miss -> accepted requirements are not implemented consistently.
3. **API contracts** - future API route inventory and client models.
   - Files: server routes/types, web models/calls, Android models/calls, schema snapshots.
   - Miss -> runtime integration failures or silently incompatible fields.
4. **Database constraints and migrations** - future Supabase schema and migration files.
   - Files: migrations, RLS policies, API models, client models, seed/test fixtures.
   - Miss -> data leakage or rejected writes.
5. **Privacy requirements** - Data Privacy Act, location protection, retention, consent, and aggregation thresholds.
   - Files: API/storage policy, logs, analytics, web/Android consent flows.
   - Miss -> personal data may be collected or retained contrary to requirements.
6. **Commit/release names** - [git-guidelines.md](../git-guidelines.md)
   - Files: commit messages and tags across repositories.
   - Miss -> releases cannot be identified or promoted safely.

## Retest matrix

| Change | Retest |
|---|---|
| Auth or user levels | API authorization, web, Android, privacy, negative tests |
| Data or migration | API integration, RLS, web, Android, rollback/restore |
| API contract | Every web/Android caller and integration tests |
| Privacy or analytics | Log review, retention, consent, aggregation thresholds |
| Release metadata | Tag target, commit date, branch promotion, candidate build |
