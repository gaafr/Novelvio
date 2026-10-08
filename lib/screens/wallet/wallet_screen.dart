import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override State<WalletScreen> createState() => _WalletScreenState();
}
class _WalletScreenState extends State<WalletScreen> {
  final amount = TextEditingController(text: '1');
  final destination = TextEditingController();
  String method = 'paypal';
  String? message;
  Future<void> submit() async {
    final result = await context.read<WalletProvider>().requestWithdrawal(
      double.tryParse(amount.text) ?? 0, method, destination.text.trim());
    if (mounted) setState(() => message = result ?? 'Withdrawal request submitted.');
  }
  @override Widget build(BuildContext context) {
    final w = context.watch<WalletProvider>();
    return Scaffold(appBar: AppBar(title: const Text('Wallet')), body: ListView(padding: const EdgeInsets.all(20), children: [
      Card(child: ListTile(
        title: const Text('Available balance'),
        subtitle: Text('${w.points} points'),
        trailing: Text('\$${w.usd.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      )),
      const SizedBox(height: 16),
      TextField(controller: amount, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Amount (USD)')),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        initialValue: method,
        decoration: const InputDecoration(labelText: 'Method'),
        items: const [DropdownMenuItem(value: 'paypal', child: Text('PayPal')), DropdownMenuItem(value: 'usdt', child: Text('USDT'))],
        onChanged: (v) => setState(() => method = v!),
      ),
      const SizedBox(height: 12),
      TextField(controller: destination, decoration: InputDecoration(labelText: method == 'paypal' ? 'PayPal email' : 'USDT address')),
      const SizedBox(height: 16),
      FilledButton(onPressed: submit, child: const Text('Request withdrawal')),
      if (message != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(message!)),
    ]));
  }
}
