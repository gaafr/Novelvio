import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import '../screens/home/home_screen.dart';
import '../providers/wallet_provider.dart';

class NovelvioApp extends StatelessWidget {
  const NovelvioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: MaterialApp(
        title: 'Novelvio',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
