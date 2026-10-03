-- RLS Policy Additions for strict data protection
-- Prevent users from modifying other users' data

-- Prevent updates to user_id in transactions
CREATE POLICY "Users cannot modify transaction user_id" ON public.transactions
  FOR UPDATE USING (false);

-- Prevent updates to wallets (only server-side functions should modify)
CREATE POLICY "Users cannot modify wallets" ON public.wallets
  FOR UPDATE USING (false);

-- Prevent direct DELETE on transactions
CREATE POLICY "Users cannot delete transactions" ON public.transactions
  FOR DELETE USING (false);

-- Prevent direct DELETE on wallets
CREATE POLICY "Users cannot delete wallets" ON public.wallets
  FOR DELETE USING (false);

-- Allow users to read tasks (no INSERT/UPDATE/DELETE)
CREATE POLICY "Users can view tasks" ON public.tasks
  FOR SELECT USING (true);

CREATE POLICY "Users cannot modify tasks" ON public.tasks
  FOR UPDATE USING (false);

CREATE POLICY "Users cannot delete tasks" ON public.tasks
  FOR DELETE USING (false);

CREATE POLICY "Users cannot insert tasks" ON public.tasks
  FOR INSERT WITH CHECK (false);

-- Prevent unauthorized withdrawal modifications
CREATE POLICY "Users cannot modify withdrawal status" ON public.withdrawals
  FOR UPDATE USING (false);

CREATE POLICY "Users cannot delete withdrawals" ON public.withdrawals
  FOR DELETE USING (false);
