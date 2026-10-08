import 'package:flutter/material.dart';
class AppTheme{
 static ThemeData get lightTheme{final s=ColorScheme.fromSeed(seedColor:const Color(0xFF6C4DFF));return ThemeData(useMaterial3:true,colorScheme:s,scaffoldBackgroundColor:const Color(0xFFF7F7FB));}
}