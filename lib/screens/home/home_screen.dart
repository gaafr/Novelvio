import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/number_formatter_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    
    final pages = [
      _buildHomePage(context, loc, walletProvider),
      _buildTasksPage(context, loc, walletProvider),
      _buildWalletPage(context, loc, walletProvider),
      _buildAccountPage(context, loc),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        centerTitle: true,
      ),
      body: pages[_currentTab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        onDestinationSelected: (index) => setState(() => _currentTab = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: loc.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.task_alt),
            label: loc.tasks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            label: loc.wallet,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            label: loc.account,
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage(BuildContext context, AppLocalizations loc, WalletProvider walletProvider) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.earnRewards,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(loc.description),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.stars),
            title: Text('${walletProvider.points} ${loc.points}'),
            subtitle: Text(NumberFormatterUtils.formatMoney(walletProvider.points)),
          ),
        ),
        _buildActionCard(
          context,
          Icons.play_circle_outline,
          loc.watchAndEarn,
          10,
          walletProvider,
        ),
        _buildActionCard(
          context,
          Icons.assignment_outlined,
          loc.completeTask,
          25,
          walletProvider,
        ),
        _buildActionCard(
          context,
          Icons.people_outline,
          loc.inviteFriends,
          100,
          walletProvider,
        ),
        _buildActionCard(
          context,
          Icons.shopping_bag_outlined,
          loc.shopAndEarn,
          50,
          walletProvider,
        ),
      ],
    );
  }

  Widget _buildTasksPage(BuildContext context, AppLocalizations loc, WalletProvider walletProvider) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.tasks,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        _buildActionCard(
          context,
          Icons.play_circle,
          loc.watchAd,
          10,
          walletProvider,
        ),
        _buildActionCard(
          context,
          Icons.assignment,
          loc.dailyTask,
          25,
          walletProvider,
        ),
        _buildActionCard(
          context,
          Icons.share,
          loc.inviteAFriend,
          100,
          walletProvider,
        ),
      ],
    );
  }

  Widget _buildWalletPage(BuildContext context, AppLocalizations loc, WalletProvider walletProvider) {
    final points = walletProvider.points;
    final canWithdraw = points >= AppConstants.minWithdrawalPoints;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.wallet,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Card(
          child: ListTile(
            title: Text(loc.balance),
            subtitle: Text(
              '$points ${loc.points} = ${NumberFormatterUtils.formatMoney(points)}',
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(loc.minimumWithdrawal),
            subtitle: Text('${AppConstants.minWithdrawalUSD} ${loc.usd}'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(loc.paypal),
            subtitle: Text(loc.afterVerification),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(loc.usdt),
            subtitle: Text(loc.afterVerification),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: canWithdraw ? () => _showWithdrawalDialog(context, loc) : null,
          child: Text(loc.requestWithdrawal),
        ),
      ],
    );
  }

  Widget _buildAccountPage(BuildContext context, AppLocalizations loc) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.account,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(loc.language),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${loc.language} - ${loc.afterVerification}')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: Text(loc.security),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.security)),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: Text(loc.helpSupport),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.helpSupport)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    int reward,
    WalletProvider walletProvider,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text('+$reward'),
        onTap: () {
          walletProvider.addPoints(reward);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('+ $reward ${AppLocalizations.of(context)!.points}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  void _showWithdrawalDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.requestWithdrawal),
        content: Text(
          '${loc.minimumWithdrawal}: ${AppConstants.minWithdrawalUSD} ${loc.usd}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${loc.requestWithdrawal} - ${loc.afterVerification}'),
                ),
              );
            },
            child: Text(loc.requestWithdrawal),
          ),
        ],
      ),
    );
  }
}
