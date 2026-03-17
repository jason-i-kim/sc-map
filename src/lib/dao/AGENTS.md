# Database Access Object (DAO) Implementations

## Directory Structure

Each entity gets its own subdirectory:

```
src/lib/dao/<entity>/
  types.ts       — Zod schemas and inferred TypeScript types
  index.ts       — DAO class and domain error classes
  index.test.ts  — Integration tests against a real database
```

## types.ts

Define Zod schemas for the entity, then derive TypeScript types from them using `z.infer<>`.

- Use `z.bigint()` for all `bigint` columns (`id`, foreign keys, etc.). The SQL client is configured with `bigint: true`, so the driver returns bigint columns as native `bigint` values.
- Export named schemas (`EntitySchema`, `EntityInsertSchema`, `EntityUpdateSchema`) alongside their inferred types (`Entity`, `EntityInsert`, `EntityUpdate`).
- `InsertSchema` is typically `EntitySchema.omit({ id: true, created_at: true })`.
- `UpdateSchema` is typically `EntitySchema.omit({ id: true }).partial()`.

## index.ts

- Export a single `EntityDao` class that takes a `SQL` instance in its constructor.
- Parse all database results through the Zod schema (e.g. `EntitySchema.parse(row)`) instead of casting with `as`.
- Define and export domain-specific error classes (`EntityNotFoundError`, `DuplicateFieldError`, etc.) in this file.
- Export union types for each operation's possible errors (e.g. `InsertEntityError`, `UpdateEntityError`).
- Methods that write to the database accept an optional `tx?: TransactionSQL` parameter to support transactions.

## index.test.ts

- Mock the database — do not use a real database connection.
- Create two mock SQL factory functions: one returning rows (`createMockSQL`), one throwing Postgres errors (`createErrorSQL`). Each returns a function that satisfies the tagged template literal interface and passes through `sql(object)` interpolation calls unchanged.
- Mock row fixtures should use native `bigint` values for bigint columns (e.g. `id: 1n`), matching what the SQL client returns with `bigint: true`.
- Each test constructs its own `PlacesDao` instance with the appropriate mock — no shared state or `beforeEach` DB setup needed.
