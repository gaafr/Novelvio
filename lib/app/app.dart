import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/video/video_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/settings/settings_screen.dart';
import 'theme.dart';

class NovelvioApp extends StatelessWidget {
  const NovelvioApp({super.key});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => WalletProvider()..load(),
    child: MaterialApp(
      title: 'Novelvio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShell(),
      routes: {'/auth': (_) => const AuthScreen(), '/settings': (_) => const SettingsScreen()},
    ),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 1;
  final pages = const [ProfileScreen(), HomeScreen(), VideoScreen()];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: pages[index],
    bottomNavigationBar: NavigationBar(
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFE4F8EC),
      selectedIndex: index,
      onDestinationSelected: (v) => setState(() => index = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.account_circle_outlined), selectedIcon: Icon(Icons.account_circle), label: 'أنا'),
        NavigationDestination(icon: Icon(Icons.card_giftcard_outlined), selectedIcon: Icon(Icons.card_giftcard), label: 'مكافآت'),
        NavigationDestination(icon: Icon(Icons.ondemand_video_outlined), selectedIcon: Icon(Icons.ondemand_video), label: 'فيديو'),
      ],
    ),
  );
}