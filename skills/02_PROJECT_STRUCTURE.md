# 02 — Project Structure

**Purpose:** show where ecosystem code and documents belong.

**Confidence note:** verified against workspace structure and tracked initial commits on 2026-11-22.

## Ecosystem tree

```text
aurelia-ecosystem/
  aurelia-api/       Back-end API repository
  aurelia-web/       Web application repository
  aurelia-android/   Android application repository
  aurelia-specs/     Product specifications and skills
  handoff.md         Handoff instructions
```

## Where new work goes

| Work | Location |
|---|---|
| API routes, middleware, migrations, server tests | `aurelia-api/` |
| Web routes, components, web tests | `aurelia-web/` |
| Android screens, services, tests | `aurelia-android/` |
| Requirements, design, schemas, contracts | `aurelia-specs/` |
| Durable engineering knowledge | `aurelia-specs/skills/NN_TOPIC.md` |

## Naming

- Use repository names to scope commits as described in [git-guidelines.md](../git-guidelines.md).
- Keep skill files numbered and append rather than renumbering entries.
- Use descriptive feature names only after the corresponding feature is accepted by specifications.

## Verified exclusions

No source directories, assets, packages, or build manifests exist yet. Do not assume conventional `src/` paths until implementation creates them.
