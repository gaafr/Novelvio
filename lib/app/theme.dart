import 'package:flutter/material.dart';

class AppTheme {
  static const green = Color(0xFF00C853);
  static const orange = Color(0xFFFF9D12);
  static const purple = Color(0xFFB52CFF);

  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(seedColor: green);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(primary: green, secondary: orange),
      scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
      cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
    );
  }
}