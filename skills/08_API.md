# 08 — API

**Purpose:** specify the Aurelia API contract once implementation exists.

**Confidence note:** no API routes or response types are implemented or documented beyond the README architecture statement.

## Response envelope

No envelope is established. Do not invent one in clients or add a second envelope during implementation.

## Route inventory

No routes exist.

## Adding an endpoint

1. Add it to the specification and assign authentication/authorization requirements.
2. Implement the server route and validation.
3. Add database constraints/RLS if data access requires it.
4. Update web and Android callers or prove they do not consume the endpoint.
5. Add contract, negative authorization, and integration tests.
6. Document exact success/error codes and response fields.

## Validators and versioning

No validator library or API versioning policy exists. Reaching implementation without these decisions leaves contracts ambiguous; record decisions in specs before wide use.
