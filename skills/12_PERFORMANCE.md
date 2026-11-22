# 12 — Performance

**Purpose:** prevent guesses from becoming unverifiable performance policy.

**Confidence note:** no runtime, workload, measurements, or hot paths exist.

## Hard limits

No hard latency, throughput, payload, or storage limits are documented.

## Hot paths

None can be identified until implementations and real usage exist.

## Expensive operations

Potentially expensive operations include list queries, analytics aggregation, retention deletion, backup/restore, and bulk migrations. These remain hypotheses, not measured facts.

## Profiling policy

Measure before optimization. Record tool, workload, environment, median/p95/p99 when relevant, and the cost avoided. Do not add caching or indexing without validating correctness and cache/constraint invalidation.
