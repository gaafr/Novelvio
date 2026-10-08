import 'package:flutter/material.dart';
import '../../core/services/supabase_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final u = SupabaseService.client?.auth.currentUser;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 28),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF00A94F)]),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(children: [
              Row(children: [
                const CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 38, color: Color(0xFF00B956))),
                const SizedBox(width: 12),
                Expanded(child: Text(u?.email ?? 'زائر', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                IconButton(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon(Icons.settings, color: Colors.white)),
              ]),
              const SizedBox(height: 12),
              const Text('رصيد الكاش', style: TextStyle(color: Colors.white70)),
              const Text('\$0.02 💵', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const LinearProgressIndicator(value: .12, minHeight: 8, backgroundColor: Colors.white30, valueColor: AlwaysStoppedAnimation(Colors.orange)),
            ]),
          ),
          const SizedBox(height: 14),
          _item(context, Icons.favorite, 'الإعجابات'),
          _item(context, Icons.star, 'المفضلة'),
          _item(context, Icons.language, 'لغة التطبيق'),
          _item(context, Icons.help_outline, 'ملاحظات'),
          _item(context, Icons.volunteer_activism, 'قيمنا'),
          _item(context, Icons.settings, 'الإعدادات'),
          _item(context, Icons.privacy_tip_outlined, 'الخصوصية والأمان'),
          if (u == null)
            _item(context, Icons.login, 'تسجيل الدخول', () => Navigator.pushNamed(context, '/auth'))
          else
            _item(context, Icons.logout, 'تسجيل الخروج', () async {
              await SupabaseService.client?.auth.signOut();
              if (mounted) setState(() {});
            }),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String title, [VoidCallback? onTap]) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      leading: Icon(icon, color: const Color(0xFF4D5664), size: 30),
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF9BA3AE), size: 18),
      onTap: onTap,
    ),
  );
}