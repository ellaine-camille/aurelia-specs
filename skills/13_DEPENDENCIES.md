# 13 — Dependencies

**Purpose:** manage ecosystem dependency choices and upgrade risks.

**Confidence note:** no package manifests exist, so no third-party implementation dependencies can be inventoried.

## Dependency policy

- Prefer dependencies already accepted in specifications or repository manifests.
- Record the reason, upgrade risk, license/hosting constraint, and deliberate rejection for each major dependency.
- Keep API, web, and Android dependency decisions independent unless a shared contract is the reason.

## Known dependencies

| Dependency | Status | Verified fact |
|---|---|---|
| Supabase | Intended database/API platform | Named in the API README only |

Google Sign-In is a listed requirement, but no SDK or implementation dependency is selected.

## Upgrade traps

No upgrade traps can be known until package manifests exist. After implementation, recheck auth SDK, Supabase client/server versions, database migrations, Android platform level, and web build compatibility.
