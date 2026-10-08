import 'package:supabase_flutter/supabase_flutter.dart';
class SupabaseService{
 static bool get configured{try{Supabase.instance.client;return true;}catch(_){return false;}}
 static SupabaseClient? get client=>configured?Supabase.instance.client:null;
}