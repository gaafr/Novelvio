drop policy if exists "Users can create their own withdrawals" on public.withdrawals;
revoke insert on public.withdrawals from authenticated;
grant select on public.withdrawals to authenticated;