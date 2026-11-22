# 10 — Deployment

**Purpose:** describe release and deployment procedures.

**Confidence note:** no CI, build, hosting, or deployment configuration exists. Release commit/tag conventions are verified from [git-guidelines.md](../git-guidelines.md).

## Current state

No deployable is configured in any repository.

## Release order

Do not infer an order until actual deployables exist. A future cross-component release must promote specifications, database migrations, API, web, and Android in a reviewed order that preserves backward compatibility.

## Build and tagging

- Tag only stable/release candidate commits from the designated branch.
- Never move or reuse tags.
- Follow the ISO-week release format and Friday release-cut rules in [git-guidelines.md](../git-guidelines.md).

## Release checklist

1. Confirm branch and commit.
2. Run applicable migrations and database backup/restore checks.
3. Build API, web, and Android candidates.
4. Run integration and privacy checks.
5. Tag the exact published build.
6. Deploy in a compatibility-safe order.
7. Verify health and rollback readiness.
