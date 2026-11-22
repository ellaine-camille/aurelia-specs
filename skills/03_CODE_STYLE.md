# 03 — Code Style

**Purpose:** define repository conventions while implementation is established.

**Confidence note:** verified from repository guidance and existing code absence on 2026-11-22. Language-specific style is not yet established.

## Repository conventions

- Follow each repository's `AGENTS.md`.
- Use the commit scopes and imperative summaries in [git-guidelines.md](../git-guidelines.md).
- Prefer the most specific product/subsystem scope. Split commits that genuinely touch independent repositories.
- Keep documentation and code truthful to the current implementation.

## Comments

- Comment why a guard, workaround, or tradeoff exists; do not narrate self-evident code.
- When a comment records a scar, link the path and failure in `06_FAILURE_STORIES.md` if it becomes established.

## Error handling

- No application logger or error vocabulary exists yet.
- Add an established pattern before introducing a second competing one.
- Never return success-shaped fallbacks for actual failures.
- Never log secrets or personal data.

## Anti-patterns

| Anti-pattern | Cost |
|---|---|
| Placeholder requirements presented as implementation facts | Trains contributors on nonexistent behavior. |
| Duplicating roles or feature lists across repositories | Prevents clients and API from agreeing; see [04_CHANGE_RULES](./04_CHANGE_RULES.md). |
| Creating an undocumented direct Supabase dependency in clients | Bypasses the API boundary stated by the README. |

