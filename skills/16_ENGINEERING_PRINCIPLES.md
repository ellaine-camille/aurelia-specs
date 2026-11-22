# 16 — Engineering Principles

**Purpose:** record durable Aurelia engineering rules with evidence and reasoning.

**Confidence note:** principles below are derived from the repository guidance and verified initial state on 2026-11-22.

1. **Make the code win.**
   - Reasoning: a document that disagrees with implementation is stale or wrong.
   - Evidence: [00_INDEX](./00_INDEX.md) and repository inspection.
   - Story: no implementation was available to validate current placeholder documents.
2. **Record lockstep sets before implementation grows.**
   - Reasoning: roles, feature access, API fields, and database policies will drift unless changed together.
   - Evidence: [04_CHANGE_RULES](./04_CHANGE_RULES.md).
   - Story: user levels and MVP features are placeholders that span every component.
3. **Protect personal and location data at system boundaries.**
   - Reasoning: UI-only filtering or logs can expose data even if the visible client looks safe.
   - Evidence: [09_SECURITY](./09_SECURITY.md) and [business-logic-v1.0.md](../business-logic-v1.0.md).
   - Story: Data Privacy Act and data-resale constraints are explicit ecosystem requirements.
4. **Distinguish verified facts from missing evidence.**
   - Reasoning: confident assumptions can create silent architectural decisions.
   - Evidence: the initial commits contain README files only.
   - Source story: [15_KNOWN_LIMITATIONS](./15_KNOWN_LIMITATIONS.md).

Trust the code over any document, including this one.
