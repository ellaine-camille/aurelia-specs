# 07 — Database

**Purpose:** guide schema and Supabase change safety.

**Confidence note:** the API README says Supabase is the database API target, but no table, migration, or policy files exist. Information beyond that statement is unverified.

## Identity, constraints, deletes

- No identity strategy, primary keys, soft-delete convention, or constraint names are defined.
- Do not choose these by local convention until specifications and migrations establish them.
- Every new destructive operation requires a reviewed migration and restore procedure.

## Table map

No table map exists.

## Migration strategy

No migration tool or strategy exists. Before implementation, record the tool, migration location, environment promotion order, rollback approach, and seed/test data policy.

## Integrity and indexing

- Document constraints in migrations and mirrored API/contracts rather than only in application validation.
- Add indexes only with measured query evidence and verify migration impact.
- User-level authorization must be enforced in server and database policies; client visibility alone is insufficient.

## Dangerous operations

Prohibit ad hoc production schema changes and table truncation until access controls and recovery procedures exist. Miss -> data loss or inconsistent environments.
