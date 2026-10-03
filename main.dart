import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const NovelvioApp());

class NovelvioApp extends StatelessWidget {
  const NovelvioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Novelvio',
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ar'), Locale('en'), Locale('de'), Locale('fr'), Locale('es'),
      Locale('it'), Locale('tr'), Locale('ru'), Locale('pt'), Locale('hi'),
      Locale('id'), Locale('zh'), Locale('ja'), Locale('ko'), Locale('nl'),
      Locale('pl'), Locale('uk'),
    ],
    home: const Home(),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int tab = 0, points = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [_home(), _tasks(), _wallet(), _account()];
    return Scaffold(
      appBar: AppBar(title: const Text('Novelvio'), centerTitle: true),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab=i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.task_alt), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
  Widget _home() => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Earn rewards', style: TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
    const SizedBox(height:8),
    const Text('Watch ads, complete tasks, invite friends and shop through offers.'),
    const SizedBox(height:20),
    Card(child: ListTile(leading: const Icon(Icons.stars), title: Text('$points points'), subtitle: Text('\$${(points/1000).toStringAsFixed(2)}'))),
    _action(Icons.play_circle_outline,'Watch & Earn',10),
    _action(Icons.assignment_outlined,'Complete a Task',25),
    _action(Icons.people_outline,'Invite Friends',100),
    _action(Icons.shopping_bag_outlined,'Shop & Earn',50),
  ]);
  Widget _tasks() => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Tasks', style: TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
    _action(Icons.play_circle,'Watch an ad',10),
    _action(Icons.assignment,'Daily task',25),
    _action(Icons.share,'Invite a friend',100),
  ]);
  Widget _action(IconData icon,String title,int reward) => Card(
    child: ListTile(
      leading: Icon(icon), title: Text(title), trailing: Text('+$reward'),
      onTap: () => setState(() => points += reward),
    ),
  );
  Widget _wallet() => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Wallet', style: TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
    Card(child: ListTile(title: const Text('Balance'), subtitle: Text('$points points = \$${(points/1000).toStringAsFixed(2)}'))),
    const Card(child: ListTile(title: Text('Minimum withdrawal'), subtitle: Text('\$1.00'))),
    const Card(child: ListTile(title: Text('PayPal'), subtitle: Text('After verification'))),
    const Card(child: ListTile(title: Text('USDT'), subtitle: Text('After verification'))),
    ElevatedButton(onPressed: points>=1000 ? (){} : null, child: const Text('Request withdrawal')),
  ]);
  Widget _account() => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Account', style: TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
    ListTile(leading: Icon(Icons.language), title: Text('Language')),
    ListTile(leading: Icon(Icons.security), title: Text('Security')),
    ListTile(leading: Icon(Icons.help_outline), title: Text('Help & Support')),
  ]);
}
