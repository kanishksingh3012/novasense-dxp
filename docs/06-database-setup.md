# Database foundation — setup and handoff

Scope: setup files for a new Supabase project. No hosted database has been created or connected. UI changes are paused at the user's request.

## Minimal workflow

1. Apply the two SQL migrations in filename order to a new development Supabase project using the SQL Editor.
2. Run `supabase/seed.sql` to load synthetic data. Rerunning the seed preserves existing rows instead of resetting scenarios.
3. Create your admin login through Supabase Auth. Obtain its user UUID, then run the admin bootstrap below in the SQL Editor.
4. Confirm row access with an authenticated client before connecting the future admin/customer UI.
5. Add the project URL and publishable key to a local `.env` based on `.env.example`. Keep any secret key server-only.

These migrations target a fresh project. The core migration runs once in a transaction; use a new migration for later changes. If adopting the CLI later, initialize/link it and reconcile migration history before pushing files already applied manually. Do not rerun the core migration on populated tables.

```sql
-- Replace with the UUID of your own existing Supabase Auth user.
insert into private.admin_accounts(user_id)
values ('YOUR_AUTH_USER_UUID') on conflict do nothing;
```

Do not use the original brief's single `users` CREATE TABLE statement alongside these migrations. `profiles` is the domain record, while `auth.users` remains managed by Supabase.

## Tables and relationships

| Table | Purpose / key columns |
| --- | --- |
| `profiles` | Identity, nullable unique Auth user link, goal, demo marker. Synthetic profiles have no real login. |
| `customer_context` | One row per profile: lifecycle, demo preset, illustrative cycle phase, data availability, engagement, detail preference. |
| `devices` | Profile FK, unique serial, connection state, activation/sync times. One non-retired device per profile. |
| `orders` | Profile FK, unique order number, starter-kit state, delivery dates. Demo orders only; no invented prices/payment data. |
| `sensor_readings` | Profile + device composite FK, relative pattern value, unit, timestamp. Simulated values only, 0–100. |
| `check_ins` | Profile FK, date, mood, energy, note. One entry per profile per day. |
| `demo_sessions` | Admin owner, selected synthetic profile, website/customer surface. Selection is session-scoped. |
| `audit_events` | Actor, entity, operation, before/after state, time. Automatically records context and demo-selection changes. |
| `private.admin_accounts` | Trusted admin allowlist linked to Auth; browser clients cannot modify it. |

All IDs are UUIDs; timestamps use `timestamptz`. Customer children reference profiles; readings also enforce that the device belongs to the same profile. `updated_at` is maintained by triggers. Deletes of a profile cascade to its domain records; historical audit entries are retained. Account deletion/retention workflows need a separate product decision before real data is stored.

The original buckets remain `demo_bucket` presets (10 prospect, 10 pre-arrival, 15 stable, 10 peak, 5 churn). They do not assert medical inference or force a website layout. Device state is stored on devices rather than duplicated in customer context. A UI projection can resolve the eventual experience from these inputs.

## Access rules

- Anonymous website visitors have no access to customer or demo records. Public brand content stays outside this database for now.
- Authenticated customers read only their own profile and related rows. They can create/edit/delete their own check-ins, but cannot alter sensor data, lifecycle, orders, admin membership, or audit history.
- Allowlisted admins manage domain data and read audit events. Demo sessions are visible/changeable only by their owning admin.
- Service-role infrastructure is privileged; it must remain server-side. Admin membership is provisioned through SQL, not client-editable profile metadata.
- Realtime publication includes context, devices, demo sessions, and check-ins. Publication setup is not proof of websocket delivery; hosted integration must be checked later.

To show an admin-selected profile in a separate preview tab, that tab must use the same signed-in admin and demo-session ID. The selected ID never grants an anonymous browser access. A real customer's own-data access remains independent of admin demo selection.

## Seed and validation

Expected seed: 50 profiles + contexts, 40 devices, 40 orders, 420 relative readings, 30 check-ins. No Auth passwords or real customer records are created. Admin sessions are created after login, not seeded globally.

The test harness runs migrations against embedded PostgreSQL with Supabase Auth/role stubs. It checks real SQL execution, repeatable seeding, RLS, denied privilege escalation, session isolation, audit attribution, and FK/check constraints. Hosted Auth, REST APIs, and Realtime delivery are outside this local check.

```sh
npm --prefix database-tests ci
npm --prefix database-tests test
```

## Deferred to protect the remaining work budget

UI integration/revamp, production authentication flows, anonymous analytics ingestion, assessments, coaching bookings, pricing/subscriptions, automated lifecycle transitions, and clinical metrics. Expand these in additive migrations after their requirements are agreed. No speculative tables or migrations are needed now.

References: [Supabase RLS](https://supabase.com/docs/guides/database/postgres/row-level-security) and [Postgres Changes](https://supabase.com/docs/guides/realtime/postgres-changes).
