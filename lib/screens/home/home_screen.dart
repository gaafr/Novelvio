import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';
import '../../services/rewarded_ad_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final w = context.watch<WalletProvider>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 28),
        children: [
          _TopBalance(points: w.points, usd: w.usd),
          const SizedBox(height: 12),
          const _Ticker(),
          const SizedBox(height: 14),
          const _SectionTitle('رصيد الكاش', Icons.account_balance_wallet),
          _CashCard(usd: w.usd),
          const SizedBox(height: 16),
          const _DailyBanner(),
          const SizedBox(height: 16),
          const _SectionTitle('المكافآت اليومية', Icons.card_giftcard),
          const _DailyRewards(),
          const SizedBox(height: 16),
          const _WatchCard(),
          const SizedBox(height: 16),
          const _Games(),
          const SizedBox(height: 18),
          const _SectionTitle('طرق أخرى للربح', Icons.auto_awesome),
          const _MiniTask(title: 'تصفح واكسب', subtitle: 'شاهد المحتوى واحصل على عملات', icon: Icons.explore),
          const _MiniTask(title: 'دعوة الأصدقاء', subtitle: 'اربح مكافآت عند دعوة أصدقائك', icon: Icons.group_add),
        ],
      ),
    );
  }
}

class _TopBalance extends StatelessWidget {
  final int points;
  final double usd;
  const _TopBalance({required this.points, required this.usd});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: const Color(0xFF3F3F42), borderRadius: BorderRadius.circular(24)),
    child: Row(children: [
      Container(
        width: 112,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(children: [
          const Text('PayPal', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF1769AA))),
          Text('$' + usd.toStringAsFixed(2), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF00A94F))),
        ]),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('In 01:36:36', style: TextStyle(color: Colors.white, fontSize: 13)),
          Text(points.toString() + ' 🪙', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            minHeight: 12,
            value: (points % 50000) / 50000,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Color(0xFFFFA323)),
          ),
        ),
      ])),
    ]),
  );
}

class _Ticker extends StatelessWidget {
  const _Ticker();
  @override
  Widget build(BuildContext context) => Container(
    height: 38,
    alignment: Alignment.center,
    decoration: BoxDecoration(color: const Color(0xFF19C96B), borderRadius: BorderRadius.circular(20)),
    child: const Text('• نجح سحب $4.08  • نجح سحب $4.03  • نجح سحب $2.25', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle(this.title, this.icon);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Row(children: [
      Icon(icon, color: const Color(0xFF00B956)),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _CashCard extends StatelessWidget {
  final double usd;
  const _CashCard({required this.usd});
  @override
  Widget build(BuildContext context) => Card(
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF08C65A), Color(0xFF00A948)]), borderRadius: BorderRadius.circular(22)),
      child: Column(children: [
        const Text('رصيد الكاش', style: TextStyle(color: Colors.white, fontSize: 18)),
        Text('$' + usd.toStringAsFixed(2) + ' 💵', style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Container(
          height: 66,
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFB51B), Color(0xFFFF5D2A)]), borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: const Text('↗ السحب', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 10),
        const Text('تتحول العملات تلقائياً إلى كاش كل 3 ساعات. قد يستغرق التحويل وقتاً أطول أحياناً.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ]),
    ),
  );
}

class _DailyBanner extends StatelessWidget {
  const _DailyBanner();
  @override
  Widget build(BuildContext context) => Container(
    height: 82,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFB119), Color(0xFFFF7B15)]), borderRadius: BorderRadius.circular(42)),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(color: Color(0xFFFFF27A), shape: BoxShape.circle),
        child: const Text('انطلق', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      const SizedBox(width: 10),
      const Expanded(child: Text('الإيرادات اليومية\nاعرض الأرباح اليومية ومشاهدة الفيديو للحصول على المكافآت', textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
    ]),
  );
}

class _DailyRewards extends StatelessWidget {
  const _DailyRewards();
  @override
  Widget build(BuildContext context) {
    final rewards = ['200+', '400+', '500+', '600+', '1000+', '1200+'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(children: [
          const Row(children: [
            Expanded(child: Text('تسجيل الدخول للمكافآت', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800))),
            Switch(value: false, onChanged: null),
          ]),
          const SizedBox(height: 8),
          Row(children: List.generate(rewards.length, (i) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: i == 1 ? const Color(0xFF00C853) : const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(14)),
              child: Column(children: [
                Text('Day ' + (i + 1).toString(), style: TextStyle(color: i == 1 ? Colors.white : Colors.grey.shade700, fontSize: 11)),
                const SizedBox(height: 5),
                const Text('🪙', style: TextStyle(fontSize: 22)),
                Text(rewards[i], style: TextStyle(fontWeight: FontWeight.w800, color: i == 1 ? Colors.white : Colors.black87)),
              ]),
            ),
          ))),
          const SizedBox(height: 12),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF00C853), borderRadius: BorderRadius.circular(14)),
            child: const Text('Today’s Sign-In: Earn 400 Coins', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

class _WatchCard extends StatefulWidget {
  const _WatchCard();
  @override State<_WatchCard> createState() => _WatchCardState();
}

class _WatchCardState extends State<_WatchCard> {
  bool busy = false;
  String? message;
  Future<void> watch() async {
    setState(() => busy = true);
    final result = await RewardedAdService().show();
    if (mounted) setState(() { busy = false; message = result; });
  }
  @override
  Widget build(BuildContext context) => Card(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFA719), Color(0xFFFF6D21)]), borderRadius: BorderRadius.circular(22)),
      child: Row(children: [
        const Icon(Icons.play_circle_fill, color: Colors.white, size: 52),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('شاهد واكسب العملات', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w900)),
          Text('شاهد فيديو واكسب عملة فوراً', style: TextStyle(color: Colors.white)),
        ])),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.deepOrange),
          onPressed: busy ? null : watch,
          child: Text(busy ? '...' : 'شاهد'),
        ),
      ]),
    ),
  );
}

class _Games extends StatelessWidget {
  const _Games();
  @override
  Widget build(BuildContext context) => Column(children: [
    const Align(alignment: Alignment.centerRight, child: Text('اكسب عملات من الألعاب', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
    const SizedBox(height: 10),
    Row(children: [
      const Expanded(child: _GameCard('عجلة الحظ', '🎡', [Color(0xFF8D2BFF), Color(0xFFFF4F00)])),
      const SizedBox(width: 10),
      const Expanded(child: _GameCard('مكافأة الوجبة', '🍔', [Color(0xFFFFA500), Color(0xFFFF6D00)])),
    ]),
    const SizedBox(height: 10),
    Row(children: [
      const Expanded(child: _GameCard('هز واربح', '🌳', [Color(0xFFFFC400), Color(0xFFFF8500)])),
      const SizedBox(width: 10),
      const Expanded(child: _GameCard('الفوز الفوري', '🎰', [Color(0xFFB62BFF), Color(0xFF6E37FF)])),
    ]),
  ]);
}

class _GameCard extends StatelessWidget {
  final String title;
  final String emoji;
  final List<Color> colors;
  const _GameCard(this.title, this.emoji, this.colors);
  @override
  Widget build(BuildContext context) => Container(
    height: 155,
    decoration: BoxDecoration(gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(22)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(emoji, style: const TextStyle(fontSize: 58)),
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900)),
    ]),
  );
}

class _MiniTask extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const _MiniTask({required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFFE7F9EF), child: Icon(icon, color: const Color(0xFF00B956))),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_left),
    ),
  );
}
