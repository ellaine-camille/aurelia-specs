# 09 — Security

**Purpose:** identify Aurelia's privacy and security obligations.

**Confidence note:** privacy requirements are verified in [business-logic-v1.0.md](../business-logic-v1.0.md); threat implementation details are unverified.

## Threat model

Assets at risk include personal and location data, account identities, administrative actions, Supabase records, logs, and analytics exports. There is no implementation evidence to complete an attack-surface or trust-boundary map.

## Authentication and authorization

- Google Sign-In is listed as a system requirement.
- Roles include System Administrator, Administrator, Moderator, Contributor, and Guest; some role definitions are placeholders.
- Authorization must exist on server/API and database boundaries. UI hiding alone does not protect records.

## Secrets

Never commit credential values. Name environment variables and keep setup instructions secret-safe.

## Privacy requirements

Security and privacy by design requires Data Privacy Act compliance, location protection, retention limits, no per-user trails, aggregation thresholds, and consent for any data resale.

## Change checklist

1. Identify affected roles and personal data.
2. Apply least privilege in API and database policy.
3. Prevent logging of secrets and location/person identifiers.
4. Verify retention and consent behavior.
5. Add negative authorization tests.
6. Record accepted gaps and residual risk in this document.
