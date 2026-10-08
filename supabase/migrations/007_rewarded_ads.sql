create table if not exists public.reward_events (
  id bigint generated always as identity primary key,
  user_id uuid not null references public.profiles(id) on delete cascade,
  event_id text not null unique,
  reward_points bigint not null check (reward_points > 0),
  source text not null default 'rewarded_ad',
  created_at timestamptz not null default now()
);
create index if not exists reward_events_user_day_idx on public.reward_events(user_id, created_at);
alter table public.reward_events enable row level security;
drop policy if exists "Users can view own reward events" on public.reward_events;
create policy "Users can view own reward events" on public.reward_events
for select using (auth.uid() = user_id);

create or replace function public.claim_rewarded_ad(
  p_user_id uuid,
  p_event_id text,
  p_reward_points bigint
) returns bigint
language plpgsql
security definer
set search_path = public
as $$
declare
  v_total integer;
  v_points bigint;
begin
  if auth.uid() is null or auth.uid() <> p_user_id then
    raise exception 'Unauthorized';
  end if;
  if coalesce(trim(p_event_id), '') = '' or p_reward_points <= 0 then
    raise exception 'Invalid reward';
  end if;
  if exists (select 1 from reward_events where event_id = p_event_id) then
    return 0;
  end if;

  select count(*) into v_total
  from reward_events
  where user_id = p_user_id
    and source = 'rewarded_ad'
    and created_at >= date_trunc('day', now());

  if v_total >= 20 then
    raise exception 'Daily rewarded-ad limit reached';
  end if;

  insert into reward_events(user_id, event_id, reward_points)
  values (p_user_id, p_event_id, least(p_reward_points, 500));

  update wallets
  set points = points + least(p_reward_points, 500), updated_at = now()
  where user_id = p_user_id
  returning points into v_points;

  insert into transactions(user_id, points, type)
  values (p_user_id, least(p_reward_points, 500), 'rewarded_ad');

  return coalesce(v_points, 0);
end;
$$;

revoke all on function public.claim_rewarded_ad(uuid,text,bigint) from public;
grant execute on function public.claim_rewarded_ad(uuid,text,bigint) to authenticated;
