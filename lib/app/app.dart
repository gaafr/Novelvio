import 'package:flutter/material.dart';

class NovelvioApp extends StatelessWidget {
  const NovelvioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novelvio',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('de'),
        Locale('fr'),
        Locale('es'),
        Locale('it'),
        Locale('tr'),
        Locale('ru'),
        Locale('pt'),
        Locale('hi'),
        Locale('id'),
        Locale('zh'),
        Locale('ja'),
        Locale('ko'),
        Locale('nl'),
        Locale('pl'),
        Locale('uk'),
      ],
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
