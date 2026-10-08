alter table public.withdrawals add column if not exists destination text;
create table if not exists public.ai_credits(user_id uuid primary key references public.profiles(id) on delete cascade,credits bigint not null default 100 check(credits>=0),updated_at timestamptz default now());
create table if not exists public.ai_video_jobs(id bigint generated always as identity primary key,user_id uuid not null references public.profiles(id) on delete cascade,prompt text not null,duration_seconds integer not null check(duration_seconds between 5 and 60),quality text not null check(quality in('standard','pro')),credits_charged bigint not null,status text not null default 'queued',provider_job_id text,output_url text,error_message text,created_at timestamptz default now(),updated_at timestamptz default now());
alter table public.ai_credits enable row level security;alter table public.ai_video_jobs enable row level security;
drop policy if exists "Users can view own ai credits" on public.ai_credits;
create policy "Users can view own ai credits" on public.ai_credits for select using(auth.uid()=user_id);
drop policy if exists "Users can view own video jobs" on public.ai_video_jobs;
create policy "Users can view own video jobs" on public.ai_video_jobs for select using(auth.uid()=user_id);
create or replace function public.request_withdrawal(p_user_id uuid,p_amount_usd numeric,p_method text,p_destination text default null) returns bigint language plpgsql security definer set search_path=public as $$
declare v_points bigint;v_need bigint;v_min numeric;v_id bigint;
begin
if auth.uid() is null or auth.uid()<>p_user_id then raise exception 'Unauthorized';end if;
select coalesce((value->>'minimum_withdrawal_usd')::numeric,1) into v_min from app_settings where key='economy';
if p_amount_usd<v_min then raise exception 'Minimum withdrawal is $1';end if;
if p_method not in('paypal','usdt') then raise exception 'Invalid method';end if;
if coalesce(trim(p_destination),'')='' then raise exception 'Destination is required';end if;
v_need=round(p_amount_usd*1000)::bigint;
select points into v_points from wallets where user_id=p_user_id for update;
if coalesce(v_points,0)<v_need then raise exception 'Insufficient balance';end if;
update wallets set points=points-v_need,updated_at=now() where user_id=p_user_id;
insert into transactions(user_id,points,type) values(p_user_id,-v_need,'spend');
insert into withdrawals(user_id,amount_usd,method,destination,status) values(p_user_id,p_amount_usd,p_method,trim(p_destination),'pending') returning id into v_id;
return v_id;
end $$;
revoke all on function public.request_withdrawal(uuid,numeric,text,text) from public;
grant execute on function public.request_withdrawal(uuid,numeric,text,text) to authenticated;
create or replace function public.consume_ai_credits(p_user_id uuid,p_credits bigint) returns boolean language plpgsql security definer set search_path=public as $$
begin
if auth.uid() is null or auth.uid()<>p_user_id then raise exception 'Unauthorized';end if;
if p_credits<=0 then raise exception 'Invalid credit amount';end if;
update ai_credits set credits=credits-p_credits,updated_at=now() where user_id=p_user_id and credits>=p_credits;
return found;
end $$;
revoke all on function public.consume_ai_credits(uuid,bigint) from public;
grant execute on function public.consume_ai_credits(uuid,bigint) to authenticated;
create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path=public as $$
begin
insert into profiles(id,display_name,referral_code) values(new.id,coalesce(new.raw_user_meta_data->>'display_name',split_part(coalesce(new.email,''),'@',1)),upper(substr(replace(new.id::text,'-',''),1,8))) on conflict(id) do nothing;
insert into wallets(user_id) values(new.id) on conflict do nothing;
insert into ai_credits(user_id) values(new.id) on conflict do nothing;
return new;
end $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();