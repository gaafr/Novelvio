import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) {
    final w = context.watch<WalletProvider>();
    return SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Novelvio', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('Earn rewards. Create AI videos. Get paid.'),
      const SizedBox(height: 24),
      Card(child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.stars)),
        title: const Text('Balance'),
        subtitle: Text('${w.points} points  •  \$${w.usd.toStringAsFixed(2)}'),
      )),
      const SizedBox(height: 12),
      Card(child: ListTile(
        leading: const Icon(Icons.movie_creation),
        title: const Text('AI Video Studio'),
        subtitle: Text('${w.credits} Credits available'),
      )),
      const SizedBox(height: 12),
      const Card(child: ListTile(
        leading: Icon(Icons.play_circle_outline),
        title: Text('Earn points'),
        subtitle: Text('Complete eligible tasks and rewards'),
      )),
      const Card(child: ListTile(
        leading: Icon(Icons.account_balance_wallet),
        title: Text('Withdraw'),
        subtitle: Text('Minimum withdrawal: \$1'),
      )),
    ]));
  }
}
