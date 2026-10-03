import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Supabase with proper environment configuration
  // await Supabase.initialize(
  //   url: String.fromEnvironment('SUPABASE_URL'),
  //   anonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
  // );
  runApp(const NovelvioApp());
}
