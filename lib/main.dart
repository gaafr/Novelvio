import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Supabase with environment variables
  // String supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  // String supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
  // if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty) {
  //   await Supabase.initialize(
  //     url: supabaseUrl,
  //     anonKey: supabaseKey,
  //   );
  // }
  runApp(const NovelvioApp());
}
