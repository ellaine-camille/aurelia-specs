# 01 — Architecture

**Purpose:** describe the Aurelia ecosystem model, boundaries, and design debt.

**Confidence note:** verified against repository README files and commits d55d4bc, 2a36bd7, a2a6508, f307d4e on 2026-11-22. Components below that lack implementation evidence are marked unverified.

## System model

Aurelia is intended to be a three-client/data-plane ecosystem: the [aurelia-api](../../aurelia-api/) repository will mediate between Supabase and web/Android clients; [aurelia-web](../../aurelia-web/) will provide regulatory-compliance front-end behavior; [aurelia-android](../../aurelia-android/) will provide Android behavior; and [aurelia-specs](../) owns product specifications. This is the only verified ecosystem model. No routes, entry points, Supabase tables, or runtime configuration exist in the tracked initial commits.

## Components

| Component | Verified ownership |
|---|---|
| API | Owns communication between the database API and web/Android clients (README; not implemented). |
| Web | Owns regulatory-compliance front-end behavior (README; not implemented). |
| Android | Owns Android application behavior (README; not implemented). |
| Specs | Owns product documents and ecosystem conventions (README). |

## Data flow

The intended flow is Android/Web -> Aurelia API -> Supabase -> Aurelia API -> Android/Web, based on API README wording. Actual request methods, envelopes, authentication, and data paths are unverified.

## Hard boundaries

1. Keep product and technical specifications in `aurelia-specs`, not as duplicated comments or private notes.
2. Keep application code in its matching repository.
3. Do not invent a shared API contract until web and Android consumers and API routes are defined.
4. Apply Data Privacy Act, retention, consent, location protection, and aggregation requirements from [business-logic-v1.0.md](../business-logic-v1.0.md).

## Decision records

- No implementation decisions are recorded in the repositories. The business logic and sense-making templates are the only product requirement artifacts.

## Ranked debt

1. **Critical:** no implementation, schema, or contract exists to ground higher-level architecture.
2. **High:** duplicated or speculative role and feature lists remain placeholders.
3. **High:** no CI, deployment, test, or local setup evidence exists.
