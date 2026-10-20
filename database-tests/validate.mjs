import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
const { PGlite } = await import(process.env.PGLITE_MODULE || '@electric-sql/pglite');
const db = new PGlite();
const root = new URL('../', import.meta.url);
let checks = 0;
const sql = async (path) => db.exec(await readFile(new URL(path, root), 'utf8'));
const count = async (table) => Number((await db.query(`select count(*) as n from ${table}`)).rows[0].n);
const check = (actual, expected) => { assert.deepEqual(actual, expected); checks++; };
async function denied(query, code) {
  await assert.rejects(db.query(query), error => error.code === code); checks++;
}
async function asUser(id, role='authenticated') {
  await db.exec('reset role');
  await db.query("select set_config('request.jwt.claim.sub', $1, false)",[id]);
  await db.exec(`set role ${role}`);
}
try {
  // Supabase supplies these roles, auth objects, and publication in hosted projects.
  await db.exec(`
    create role anon; create role authenticated; create role service_role bypassrls;
    create schema auth; create table auth.users(id uuid primary key);
    create function auth.uid() returns uuid language sql stable as $$
      select nullif(current_setting('request.jwt.claim.sub',true),'')::uuid;
    $$;
    grant usage on schema public,auth to anon,authenticated,service_role;
    grant execute on function auth.uid() to anon,authenticated,service_role;
    create publication supabase_realtime;
  `);
  await sql('supabase/migrations/202610210001_core.sql');
  await sql('supabase/migrations/202610210002_realtime.sql');
  await sql('supabase/migrations/202610210002_realtime.sql');
  await sql('supabase/seed.sql');
  await sql('supabase/seed.sql');
  check(await count('public.profiles'),50);
  check(await count('public.devices'),40);
  check(await count('public.orders'),40);
  check(await count('public.sensor_readings'),420);
  check(await count('public.check_ins'),30);
  check(await count('public.audit_events'),50);
  check((await db.query('select demo_bucket,count(*)::int as n from customer_context group by demo_bucket order by demo_bucket')).rows,
    [{demo_bucket:'churn_risk',n:5},{demo_bucket:'peak_phase',n:10},{demo_bucket:'pre_arrival',n:10},{demo_bucket:'prospect',n:10},{demo_bucket:'stable_baseline',n:15}]);
  check(Number((await db.query("select count(*) as n from pg_publication_tables where pubname='supabase_realtime'")).rows[0].n),4);
  const admin='00000000-0000-0000-0000-000000000001', otherAdmin='00000000-0000-0000-0000-000000000002', customer='00000000-0000-0000-0000-000000000003';
  await db.exec(`insert into auth.users values('${admin}'),('${otherAdmin}'),('${customer}');
    insert into private.admin_accounts(user_id) values('${admin}'),('${otherAdmin}');
    insert into public.profiles(id,auth_user_id,full_name,email) values('${customer}','${customer}','Test customer','customer@example.test');
    insert into public.customer_context(profile_id) values('${customer}');`);
  await asUser('', 'anon');
  await denied('select * from public.profiles','42501');
  await asUser(customer);
  check(await count('public.profiles'),1);
  check(await count('public.customer_context'),1);
  check(await count('public.sensor_readings'),0);
  check(await count('public.audit_events'),0);
  await denied("insert into private.admin_accounts(user_id) values(auth.uid())",'42501');
  check((await db.query("update public.customer_context set demo_bucket='churn_risk' returning profile_id")).rows.length,0);
  await db.exec(`insert into public.check_ins(profile_id,entry_date,note) values('${customer}',current_date,'My note');`);
  check(await count('public.check_ins'),1);
  await denied("insert into public.check_ins(profile_id,entry_date,note) values(md5('novasense-demo-21')::uuid,current_date,'Wrong owner')",'42501');
  await denied("update public.check_ins set profile_id=md5('novasense-demo-21')::uuid",'42501');
  await denied(`insert into public.demo_sessions(owner_id) values('${customer}')`,'42501');
  await asUser(admin);
  check(await count('public.profiles'),51);
  await db.exec("update public.customer_context set detail_preference='detail' where profile_id=md5('novasense-demo-1')::uuid");
  check((await db.query("select actor_id from public.audit_events where operation='UPDATE' order by created_at desc limit 1")).rows[0].actor_id,admin);
  await denied('delete from public.audit_events','42501');
  await denied(`insert into public.demo_sessions(owner_id,active_profile_id) values('${admin}','${customer}')`,'P0001');
  await denied(`insert into public.demo_sessions(owner_id) values('${otherAdmin}')`,'42501');
  await db.exec(`insert into public.demo_sessions(owner_id,active_profile_id) values('${admin}',md5('novasense-demo-1')::uuid);`);
  check(await count('public.demo_sessions'),1);
  await asUser(otherAdmin);
  check(await count('public.demo_sessions'),0);
  check((await db.query("update public.demo_sessions set surface='customer' returning id")).rows.length,0);
  await db.exec('reset role');
  await denied("insert into public.sensor_readings(profile_id,device_id,value,recorded_at) values(md5('novasense-demo-22')::uuid,md5('novasense-device-21')::uuid,50,now())",'23503');
  await denied("update public.customer_context set demo_bucket='invented'",'23514');
  await denied("update public.sensor_readings set value=101",'23514');
  await denied("update public.sensor_readings set is_simulated=false",'23514');
  console.log(`PASS: ${checks} checks; migrations, seed repeatability, bucket counts, RLS isolation, admin permissions, audit attribution, demo ownership, and constraints.`);
  console.log('Scope: embedded PostgreSQL with Supabase auth stubs; hosted Auth and Realtime websocket delivery remain untested.');
} finally { await db.close(); }
