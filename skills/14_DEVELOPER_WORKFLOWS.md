# 14 — Developer Workflows

**Purpose:** give repeatable setup and change recipes.

**Confidence note:** repository setup cannot be reproduced beyond reading files because no build manifests exist.

## Setup

1. Clone or open the four repositories.
2. Read the target repository `AGENTS.md` and `README.md`.
3. For spec changes, read [business-logic-v1.0.md](../business-logic-v1.0.md), [git-guidelines.md](../git-guidelines.md), and relevant skills.
4. Check status and branch before editing.
5. Stop and record missing setup data rather than inventing commands.

## Inspect repository state

```powershell
git -C .\aurelia-api status --short --branch
git -C .\aurelia-web status --short --branch
git -C .\aurelia-android status --short --branch
git -C .\aurelia-specs status --short --branch
```

## Make a specification change

1. Verify the rule against existing source or accepted requirement text.
2. Update the lockstep set in `04` and a relevant failure limitation if needed.
3. Use the repository commit scope from [git-guidelines.md](../git-guidelines.md).
4. Run all available checks.
5. Add what surprised you to `INBOX.md`.
