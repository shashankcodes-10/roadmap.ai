# E2E & CI Testing Setup

This document explains how the `CODE TEST` GitHub Actions workflow is configured to run unit tests (Vitest) and end-to-end tests (Playwright) reliably in CI, using a local SQLite database instead of production Turso.

## Why this setup exists

The project uses **Turso** as the production database. Running E2E tests against production Turso is unsafe and non-reproducible — tests could leak data into production, or fail due to state left over from a previous run.

Instead, CI uses a local **SQLite file** (`sqlite.e2e.db`) that is created fresh, migrated, and seeded on every run.

## How the database switch works

`drizzle.config.ts` reads `TURSO_DATABASE_URL`. If it's empty, it falls back to SQLite:

```ts
const tursoUrl = process.env.TURSO_DATABASE_URL;
// falls back to:
url: process.env.SQLITE_PATH ?? "sqlite.db"
```

In CI, we explicitly set `TURSO_DATABASE_URL` and `TURSO_AUTH_TOKEN` to empty strings so the app can never accidentally connect to production, and point `SQLITE_PATH` at a dedicated E2E database file.

## Required environment variables (CI)

| Variable | Value | Purpose |
|---|---|---|
| `TURSO_DATABASE_URL` | `""` (empty) | Forces fallback to SQLite |
| `TURSO_AUTH_TOKEN` | `""` (empty) | Forces fallback to SQLite |
| `SQLITE_PATH` | `sqlite.e2e.db` | Dedicated E2E database file |
| `AUTH_SECRET` | `e2e-test-secret` | Test-only secret so Auth.js (signup, sessions) works in E2E — **not** the production secret |

`AUTH_SECRET` must also be set in `playwright.config.ts`, since Playwright's `webServer` spawns the Next.js server as a child process and needs the variable in its own `env` block:

```ts
webServer: {
  command: "...",
  url: "http://localhost:3000",
  env: {
    SQLITE_PATH: "sqlite.e2e.db",
    AUTH_SECRET: "e2e-test-secret",
  },
}
```

## Step-by-step: what the CI workflow does

1. **Checkout code**
2. **Setup Node.js 22**
3. **Install dependencies** — `npm ci`
4. **Reset the E2E database** — delete any leftover file so every run starts clean:
   ```bash
   rm -f sqlite.e2e.db
   ```
5. **Run migrations** — creates the schema (tables: `users`, `subjects`, `topics`, `resources`, `progress`, etc.):
   ```bash
   npm run db:migrate
   ```
6. **Seed the database** — migrations only create empty tables; seeding populates required application data (e.g. the `DevOps` subject that a test asserts on):
   ```bash
   npm run db:seed
   ```
7. **Run unit tests**:
   ```bash
   npm run test
   ```
8. **Install Playwright + Chromium**:
   ```bash
   npx playwright install --with-deps chromium
   ```
9. **Run E2E tests** (this step also starts the Next.js app via Playwright's `webServer`):
   ```bash
   npm run test:e2e
   ```

## Running this locally

To reproduce the CI environment on your machine:

```bash
# 1. Reset the local E2E database
rm -f sqlite.e2e.db

# 2. Set env vars for this shell session
export TURSO_DATABASE_URL=""
export TURSO_AUTH_TOKEN=""
export SQLITE_PATH="sqlite.e2e.db"
export AUTH_SECRET="e2e-test-secret"

# 3. Migrate and seed
npm run db:migrate
npm run db:seed

# 4. Run tests
npm run test
npx playwright install --with-deps chromium
npm run test:e2e
```

## Common failure and fix

**Error:** `SqliteError: no such table: subjects`, followed by Playwright timing out waiting on `config.webServer`.

**Cause:** The E2E database file exists but has no schema — migrations were never run against it before the server started, or the app connected to an empty/wrong database file.

**Fix:** Ensure migrations (`npm run db:migrate`) run **before** the server starts, and that `SQLITE_PATH` points at a database that was actually migrated in this same run — not a stale file, and not an unmigrated production Turso instance.

## Locator strictness note

One E2E test originally failed with a Playwright **strict-mode violation** because `getByRole("heading", { name: "DevOps" })` matched multiple headings (`DevOps`, `Python for DevOps`, `Introduction to DevOps & Cloud`, `Agentic AI for DevOps`) since `name` does substring matching by default.

Fix — match only the exact heading:

```ts
page.getByRole("heading", { name: "DevOps", exact: true })
```

## Pipeline summary

```
Checkout code
   ↓
Setup Node.js 22
   ↓
npm ci
   ↓
Create fresh E2E SQLite DB
   ↓
Run migrations
   ↓
Seed database
   ↓
Run Vitest
   ↓
Install Playwright + Chromium
   ↓
Start Next.js application (via Playwright webServer)
   ↓
Run Playwright E2E tests
   ↓
PASS ✅
```
