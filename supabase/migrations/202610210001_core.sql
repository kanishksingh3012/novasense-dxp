begin;

create schema if not exists private;
revoke all on schema private from public, anon;
grant usage on schema private to authenticated;

-- Only SQL administrators/service-side provisioning may grant admin access.
create table private.admin_accounts (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
alter table private.admin_accounts enable row level security;
revoke all on private.admin_accounts from public, anon, authenticated;

create function private.is_admin() returns boolean
language sql stable security definer set search_path = '' as $$
  select exists(select 1 from private.admin_accounts where user_id = (select auth.uid()));
$$;
revoke all on function private.is_admin() from public;
grant execute on function private.is_admin() to authenticated;

create table public.profiles (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid unique references auth.users(id) on delete cascade,
  full_name text not null check (length(trim(full_name)) between 1 and 120),
  email text not null unique check (email = lower(email)),
  avatar_url text,
  primary_goal text not null default 'cycle_awareness'
    check (primary_goal in ('cycle_awareness','discovery','ttc','pcos_management','biohacking')),
  is_demo boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (not is_demo or auth_user_id is null)
);

create function private.can_read_profile(target uuid) returns boolean
language sql stable security definer set search_path = '' as $$
  select private.is_admin() or exists (
    select 1 from public.profiles where id = target and auth_user_id = (select auth.uid())
  );
$$;
revoke all on function private.can_read_profile(uuid) from public;
grant execute on function private.can_read_profile(uuid) to authenticated;

create table public.customer_context (
  profile_id uuid primary key references public.profiles(id) on delete cascade,
  lifecycle_stage text not null default 'browsing'
    check (lifecycle_stage in ('browsing','evaluating','ordered','preparing','learning','active')),
  demo_bucket text not null default 'prospect'
    check (demo_bucket in ('prospect','pre_arrival','stable_baseline','peak_phase','churn_risk')),
  biological_phase text not null default 'unknown'
    check (biological_phase in ('unknown','baseline','fertile_window','luteal_wait','menstruation')),
  data_status text not null default 'absent' check (data_status in ('absent','learning','usable','stale')),
  engagement_status text not null default 'ordinary' check (engagement_status in ('ordinary','returning','help_requested')),
  detail_preference text not null default 'overview' check (detail_preference in ('overview','detail')),
  last_seen_at timestamptz,
  updated_at timestamptz not null default now()
);

create table public.devices (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  serial_number text not null unique,
  status text not null check (status in ('shipping','connected','disconnected','retired')),
  activated_at timestamptz,
  last_sync_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(id, profile_id),
  check (last_sync_at is null or (activated_at is not null and last_sync_at >= activated_at))
);
create index devices_profile_idx on public.devices(profile_id);
create unique index devices_one_current_idx on public.devices(profile_id) where status <> 'retired';

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  order_number text not null unique,
  status text not null default 'confirmed' check (status in ('confirmed','processing','shipped','delivered','cancelled')),
  product_code text not null default 'starter_kit' check (product_code = 'starter_kit'),
  is_demo boolean not null default true check (is_demo),
  expected_delivery_at timestamptz,
  delivered_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (status <> 'delivered' or delivered_at is not null)
);
create index orders_profile_idx on public.orders(profile_id, created_at desc);

-- Relative demo observations, not validated hormone readings.
create table public.sensor_readings (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  device_id uuid not null,
  metric text not null default 'pattern_index' check (metric = 'pattern_index'),
  value numeric(6,2) not null check (value between 0 and 100),
  unit text not null default 'relative' check (unit = 'relative'),
  recorded_at timestamptz not null,
  is_simulated boolean not null default true check (is_simulated),
  foreign key (device_id,profile_id) references public.devices(id,profile_id) on delete cascade,
  unique(device_id,metric,recorded_at)
);
create index readings_profile_time_idx on public.sensor_readings(profile_id,recorded_at desc);

create table public.check_ins (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  entry_date date not null,
  mood text check (mood in ('low','neutral','content','good')),
  energy text check (energy in ('low','steady','high')),
  note text check (length(note) <= 2000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(profile_id,entry_date)
);

-- Authenticated admin-owned previews, never a global active-user toggle.
create table public.demo_sessions (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  active_profile_id uuid references public.profiles(id) on delete set null,
  surface text not null default 'website' check (surface in ('website','customer')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index demo_sessions_owner_idx on public.demo_sessions(owner_id);
create index demo_sessions_profile_idx on public.demo_sessions(active_profile_id);

create table public.audit_events (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid, -- Preserve attribution even after an auth account is removed.
  entity_table text not null,
  entity_id uuid not null,
  operation text not null check (operation in ('INSERT','UPDATE','DELETE')),
  old_state jsonb,
  new_state jsonb,
  created_at timestamptz not null default now()
);
create index audit_entity_time_idx on public.audit_events(entity_table,entity_id,created_at desc);

create function private.touch_updated_at() returns trigger
language plpgsql set search_path = '' as $$
begin new.updated_at := now(); return new; end;
$$;
create function private.audit_context_change() returns trigger
language plpgsql security definer set search_path = '' as $$
declare before_row jsonb; after_row jsonb; row_id uuid;
begin
  if TG_OP <> 'INSERT' then before_row := to_jsonb(old); end if;
  if TG_OP <> 'DELETE' then after_row := to_jsonb(new); end if;
  row_id := coalesce(after_row->>'profile_id',after_row->>'id',before_row->>'profile_id',before_row->>'id')::uuid;
  insert into public.audit_events(actor_id,entity_table,entity_id,operation,old_state,new_state)
    values(auth.uid(),TG_TABLE_NAME,row_id,TG_OP,before_row,after_row);
  return coalesce(new,old);
end;
$$;
create function private.validate_demo_profile() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  if new.active_profile_id is not null and not exists (
    select 1 from public.profiles where id = new.active_profile_id and is_demo
  ) then raise exception 'Demo sessions may only select synthetic profiles'; end if;
  return new;
end;
$$;
revoke all on function private.touch_updated_at(), private.audit_context_change(), private.validate_demo_profile() from public;

do $$ declare t text; begin
  foreach t in array array['profiles','customer_context','devices','orders','check_ins','demo_sessions'] loop
    execute format('create trigger touch_updated_at before update on public.%I for each row execute function private.touch_updated_at()',t);
  end loop;
  foreach t in array array['customer_context','demo_sessions'] loop
    execute format('create trigger audit_change after insert or update or delete on public.%I for each row execute function private.audit_context_change()',t);
  end loop;
end $$;
create trigger validate_demo_profile before insert or update on public.demo_sessions
  for each row execute function private.validate_demo_profile();

-- Explicit grants plus RLS. Anonymous visitors cannot read customer/demo data.
do $$ declare t text; begin
  foreach t in array array['profiles','customer_context','devices','orders','sensor_readings','check_ins','demo_sessions','audit_events'] loop
    execute format('alter table public.%I enable row level security',t);
    execute format('revoke all on public.%I from public, anon, authenticated',t);
    execute format('grant select on public.%I to authenticated',t);
    execute format('grant all on public.%I to service_role',t);
  end loop;
  foreach t in array array['profiles','customer_context','devices','orders','sensor_readings','check_ins'] loop
    execute format('grant insert, update, delete on public.%I to authenticated',t);
    execute format('create policy admin_manage on public.%I for all to authenticated using (private.is_admin()) with check (private.is_admin())',t);
    if t = 'profiles' then
      execute 'create policy own_read on public.profiles for select to authenticated using (auth_user_id = (select auth.uid()))';
    else
      execute format('create policy own_read on public.%I for select to authenticated using (private.can_read_profile(profile_id))',t);
    end if;
  end loop;
end $$;
create policy own_checkin_insert on public.check_ins for insert to authenticated with check(private.can_read_profile(profile_id));
create policy own_checkin_update on public.check_ins for update to authenticated using(private.can_read_profile(profile_id)) with check(private.can_read_profile(profile_id));
create policy own_checkin_delete on public.check_ins for delete to authenticated using(private.can_read_profile(profile_id));
grant insert,update,delete on public.demo_sessions to authenticated;
create policy owned_demo_session on public.demo_sessions for all to authenticated
  using(owner_id = (select auth.uid()) and private.is_admin())
  with check(owner_id = (select auth.uid()) and private.is_admin());
create policy admin_audit_read on public.audit_events for select to authenticated using(private.is_admin());

commit;
