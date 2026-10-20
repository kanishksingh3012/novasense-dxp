begin;
-- Deterministic IDs and ON CONFLICT DO NOTHING make reseeding non-destructive.
insert into public.profiles(id,full_name,email,is_demo)
select md5('novasense-demo-'||n)::uuid,'Demo member '||lpad(n::text,2,'0'),
       'member'||n||'@example.test',true
from generate_series(1,50) n on conflict do nothing;

insert into public.customer_context(profile_id,lifecycle_stage,demo_bucket,biological_phase,data_status,engagement_status,detail_preference,last_seen_at)
select md5('novasense-demo-'||n)::uuid,
 case when n<=10 then 'browsing' when n<=20 then 'preparing' else 'active' end,
 case when n<=10 then 'prospect' when n<=20 then 'pre_arrival' when n<=35 then 'stable_baseline' when n<=45 then 'peak_phase' else 'churn_risk' end,
 case when n<=20 then 'unknown' else 'baseline' end,
 case when n<=20 then 'absent' else 'usable' end,
 case when n>45 then 'returning' else 'ordinary' end,
 case when n between 36 and 45 then 'detail' else 'overview' end,
 now() - case when n>45 then interval '8 days' else interval '2 hours' end
from generate_series(1,50) n on conflict do nothing;

insert into public.devices(id,profile_id,serial_number,status,activated_at,last_sync_at)
select md5('novasense-device-'||n)::uuid,md5('novasense-demo-'||n)::uuid,'NS-DEMO-'||lpad(n::text,3,'0'),
 case when n<=20 then 'shipping' else 'connected' end,
 case when n>20 then now()-interval '20 days' end,
 case when n>20 then now() end
from generate_series(11,50) n on conflict do nothing;

insert into public.orders(id,profile_id,order_number,status,expected_delivery_at,delivered_at)
select md5('novasense-order-'||n)::uuid,md5('novasense-demo-'||n)::uuid,'NS-ORDER-'||lpad(n::text,3,'0'),
 case when n<=20 then 'shipped' else 'delivered' end,
 case when n<=20 then now()+interval '3 days' else now()-interval '20 days' end,
 case when n>20 then now()-interval '20 days' end
from generate_series(11,50) n on conflict do nothing;

insert into public.sensor_readings(id,profile_id,device_id,value,recorded_at)
select md5('novasense-reading-'||n||'-'||d)::uuid,md5('novasense-demo-'||n)::uuid,md5('novasense-device-'||n)::uuid,
 round((50+18*sin((n+d)::numeric/3))::numeric,2),
 date_trunc('day',now()) - d*interval '1 day' + interval '8 hours'
from generate_series(21,50) n cross join generate_series(1,14) d on conflict do nothing;

insert into public.check_ins(id,profile_id,entry_date,mood,energy,note)
select md5('novasense-checkin-'||n)::uuid,md5('novasense-demo-'||n)::uuid,current_date-1,'content','steady','Synthetic journal entry for the NovaSense demo.'
from generate_series(21,50) n on conflict do nothing;
commit;
