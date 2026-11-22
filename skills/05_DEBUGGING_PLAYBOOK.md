# 05 — Debugging Playbook

**Purpose:** provide reliable diagnostic entry points for the ecosystem.

**Confidence note:** verified from repository state on 2026-11-22. No application logs or exact runtime messages exist.

## Where to look

1. Confirm the failing repository and branch.
2. Read `AGENTS.md` and README files in that repository.
3. Check local environment, build manifest, CI output, and service logs if the implementation exists.
4. Check the API contract and database state only after reproducing the symptom.

## Known symptoms

No exact application symptoms or messages are documented. Do not diagnose by intuition: record the exact message, endpoint/screen, request/response shape, and reproduction steps, then add it here.

## Useful commands

```powershell
git -C .\aurelia-api status --short --branch
git -C .\aurelia-web status --short --branch
git -C .\aurelia-android status --short --branch
git -C .\aurelia-specs status --short --branch
```

Use repository-specific manifests once they exist. A missing manifest is a diagnosis fact: the repository has not been implemented or the wrong checkout is present.
