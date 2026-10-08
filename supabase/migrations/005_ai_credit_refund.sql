create or replace function public.refund_ai_credits(p_user_id uuid,p_credits bigint) returns boolean language plpgsql security definer set search_path=public as $$
begin
 if p_credits<=0 then return false; end if;
 update ai_credits set credits=credits+p_credits,updated_at=now() where user_id=p_user_id;
 return found;
end $$;
revoke all on function public.refund_ai_credits(uuid,bigint) from public;
grant execute on function public.refund_ai_credits(uuid,bigint) to service_role;