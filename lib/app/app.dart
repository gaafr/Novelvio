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
class NovelvioApp extends StatelessWidget{
 const NovelvioApp({super.key});
 @override Widget build(BuildContext context)=>ChangeNotifierProvider(create:(_)=>WalletProvider()..load(),child:MaterialApp(
  title:'Novelvio',debugShowCheckedModeBanner:false,theme:AppTheme.lightTheme,home:const MainShell(),
  routes:{'/auth':(_)=>const AuthScreen(),'/settings':(_)=>const SettingsScreen()},
 ));
}
class MainShell extends StatefulWidget{const MainShell({super.key});@override State<MainShell> createState()=>_MainShellState();}
class _MainShellState extends State<MainShell>{
 int index=0;final pages=const[HomeScreen(),VideoScreen(),WalletScreen(),ProfileScreen()];
 @override Widget build(BuildContext context)=>Scaffold(body:pages[index],bottomNavigationBar:NavigationBar(
  selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),
  destinations:const[
   NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Home'),
   NavigationDestination(icon:Icon(Icons.movie_creation_outlined),selectedIcon:Icon(Icons.movie_creation),label:'AI Video'),
   NavigationDestination(icon:Icon(Icons.account_balance_wallet_outlined),selectedIcon:Icon(Icons.account_balance_wallet),label:'Wallet'),
   NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Profile'),
 ]));
}