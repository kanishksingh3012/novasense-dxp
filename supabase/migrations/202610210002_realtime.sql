begin;
-- Supabase supplies this publication. Only publish tables needed by the first demo.
do $$ declare t text; begin
  if not exists(select 1 from pg_publication where pubname='supabase_realtime') then
    raise exception 'Supabase Realtime publication is missing. Enable Realtime before applying this migration.';
  end if;
  foreach t in array array['customer_context','devices','demo_sessions','check_ins'] loop
    if not exists(select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename=t) then
      execute format('alter publication supabase_realtime add table public.%I',t);
    end if;
  end loop;
end $$;
commit;
