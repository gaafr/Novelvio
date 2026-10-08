import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/app.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const url=String.fromEnvironment('SUPABASE_URL');
  const key=String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  if(url.isNotEmpty&&key.isNotEmpty){await Supabase.initialize(url:url,publishableKey:key);}
  runApp(const NovelvioApp());
}