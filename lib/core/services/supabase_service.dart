// Supabase service (will be implemented when Supabase credentials are available)
import 'package:logging/logging.dart';

class SupabaseService {
  static final Logger _log = Logger('SupabaseService');

  // TODO: Initialize Supabase client when environment variables are available
  // static late final SupabaseClient _supabaseClient;
  //
  // static Future<void> initialize() async {
  //   String url = String.fromEnvironment('SUPABASE_URL');
  //   String key = String.fromEnvironment('SUPABASE_ANON_KEY');
  //   _supabaseClient = SupabaseClient(url, key);
  // }

  static void logInfo(String message) {
    _log.info(message);
  }

  static void logError(String message, [Object? error]) {
    _log.severe(message, error);
  }
}
