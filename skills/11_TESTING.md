# 11 — Testing

**Purpose:** establish an honest testing strategy.

**Confidence note:** no test directories, frameworks, or coverage results exist in the initial commits.

## Current coverage

No automated tests are present or can be claimed.

## Required test dimensions

Once features are implemented, test:

- authentication and role/feature authorization;
- public/guest access boundaries;
- input validation and exact error responses;
- Supabase constraints and RLS;
- web and Android API consumers;
- privacy consent, retention, aggregation, and location handling;
- migrations and rollback;
- release build/package behavior.

## Mocking

Mock external services only at integration boundaries. A mock must not replace authorization or RLS verification.

## Manual drills

No manual drill is established. Future drills should include a restore, credential revocation, unauthorized access attempt, and production-like release promotion.
