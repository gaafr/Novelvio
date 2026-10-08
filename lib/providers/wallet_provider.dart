import 'package:flutter/foundation.dart';
import '../core/services/supabase_service.dart';
class WalletProvider extends ChangeNotifier{
 int points=0,credits=100;
 double get usd=>points/1000;
 Future<void> load()async{
  final c=SupabaseService.client,uid=c?.auth.currentUser?.id;if(c==null||uid==null)return;
  final w=await c.from('wallets').select('points').eq('user_id',uid).maybeSingle();
  final a=await c.from('ai_credits').select('credits').eq('user_id',uid).maybeSingle();
  points=(w?['points'] as num?)?.toInt()??0;credits=(a?['credits'] as num?)?.toInt()??100;notifyListeners();
 }
 Future<String?> requestWithdrawal(double amount,String method,String destination)async{
  final c=SupabaseService.client,uid=c?.auth.currentUser?.id;if(c==null||uid==null)return'Please configure Supabase and sign in.';
  try{await c.rpc('request_withdrawal',params:{'p_user_id':uid,'p_amount_usd':amount,'p_method':method,'p_destination':destination});await load();return null;}catch(e){return e.toString();}
 }
}