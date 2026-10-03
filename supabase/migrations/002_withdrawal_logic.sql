-- Withdrawal Business Logic for Novelvio
-- This file documents the withdrawal process to be handled SERVER-SIDE ONLY

/* 
  WITHDRAWAL ECONOMICS:
  - 1000 points = 1 USD
  - Minimum withdrawal: 1 USD (1000 points)
  - Maximum withdrawal per request: 10,000 USD (10,000,000 points) [configurable]
  
  WITHDRAWAL STATUS FLOW:
  pending -> approved -> processing -> completed/failed -> (manual review if needed)
  
  SERVER-SIDE PAYOUT PROCESS:
  1. User requests withdrawal via app
  2. Server validates:
     - User has sufficient balance
     - Amount >= 1 USD
     - User is verified (fraud checks passed)
  3. Server checks payment method:
     - PayPal: Requires PayPal business API integration
     - USDT: Requires blockchain/wallet integration (Ethereum, Polygon, etc.)
  4. Server initiates actual transfer (OAuth, API calls to PayPal, blockchain RPC, etc.)
  5. Server updates withdrawal.status and stores transaction_id
  6. User notified of status changes
  
  SECURITY NOTES:
  - Never send real money via client app
  - All payment API credentials stored in server environment variables only
  - Use HTTPS + server-side validation
  - Implement rate limiting on withdrawal requests
  - Log all transactions for audit trail
  - Implement fraud detection (velocity checks, account age, etc.)
  - Use 2FA or additional verification for large withdrawals
*/

CREATE OR REPLACE FUNCTION public.request_withdrawal(
  p_user_id UUID,
  p_amount_usd NUMERIC,
  p_method TEXT
)
RETURNS BIGINT AS $$
DECLARE
  v_user_points BIGINT;
  v_points_needed BIGINT;
  v_withdrawal_id BIGINT;
  v_min_usd NUMERIC;
BEGIN
  -- Get minimum withdrawal from app_settings
  SELECT (value->>'minimum_withdrawal_usd')::NUMERIC INTO v_min_usd
  FROM public.app_settings WHERE key = 'economy';
  v_min_usd := COALESCE(v_min_usd, 1.0);

  -- Validate amount
  IF p_amount_usd < v_min_usd THEN
    RAISE EXCEPTION 'Withdrawal amount must be at least %.2f USD', v_min_usd;
  END IF;

  IF p_method NOT IN ('paypal', 'usdt') THEN
    RAISE EXCEPTION 'Invalid withdrawal method: %', p_method;
  END IF;

  -- Get user's current points
  SELECT points INTO v_user_points FROM public.wallets WHERE user_id = p_user_id;
  IF v_user_points IS NULL THEN
    RAISE EXCEPTION 'User wallet not found';
  END IF;

  -- Calculate points needed
  v_points_needed := (p_amount_usd * 1000)::BIGINT;

  -- Check balance
  IF v_user_points < v_points_needed THEN
    RAISE EXCEPTION 'Insufficient balance. Required: %, Available: %', v_points_needed, v_user_points;
  END IF;

  -- Create withdrawal request (DO NOT PROCESS PAYMENT HERE)
  INSERT INTO public.withdrawals (
    user_id,
    amount_usd,
    method,
    status
  ) VALUES (
    p_user_id,
    p_amount_usd,
    p_method,
    'pending'
  ) RETURNING id INTO v_withdrawal_id;

  RETURN v_withdrawal_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.request_withdrawal(UUID, NUMERIC, TEXT) TO authenticated;
