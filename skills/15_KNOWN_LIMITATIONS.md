# 15 — Known Limitations

**Purpose:** rank gaps that can surprise contributors.

**Confidence note:** verified by workspace inspection on 2026-11-22.

## Ranked gaps

1. **Critical - no implementation exists:** API, web, Android, and database behavior cannot be verified.
2. **Critical - placeholders remain:** product name, code name, platform detail, userbase, feature list, and several requirements are unresolved in [business-logic-v1.0.md](../business-logic-v1.0.md).
3. **High - no routes or schema:** API contracts and Supabase table/RLS/migration maps are absent.
4. **High - no tests or CI:** confidence and release gates cannot be automated.
5. **High - no deployment evidence:** build artifacts, hosting, tags, and rollback procedures are unknown.
6. **Medium - no dependencies:** package choices and security/upgrade posture are undefined.
7. **Medium - no incidents:** failure signatures and repair shortcuts do not yet exist.

## Redesign candidates

No redesign is justified yet. First establish the requirements and implementation, then identify measured bottlenecks or coupling.
