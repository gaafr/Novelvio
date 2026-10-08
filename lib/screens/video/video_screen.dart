import 'package:flutter/material.dart';
import '../../core/services/supabase_service.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});
  @override State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final prompt = TextEditingController();
  int seconds = 10;
  String quality = 'standard';
  bool busy = false;
  String? status;

  Future<void> create() async {
    final c = SupabaseService.client;
    if (c == null) {
      setState(() => status = 'قم بإعداد Supabase ومزود الفيديو أولاً.');
      return;
    }
    setState(() => busy = true);
    try {
      final r = await c.functions.invoke('generate-video', body: {'prompt': prompt.text.trim(), 'duration_seconds': seconds, 'quality': quality});
      if (mounted) setState(() => status = 'تم إنشاء الطلب: ${r.data}');
    } catch (e) {
      if (mounted) setState(() => status = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF8A6A61), Color(0xFF171717)]),
        ),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Row(children: [
                const Text('Novelvio', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
              ]),
            ),
            const Spacer(),
            const Align(alignment: Alignment.center, child: Icon(Icons.play_circle_outline, color: Colors.white70, size: 78)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 78, 18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('AI Video Studio', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
                SizedBox(height: 6),
                Text('أنشئ فيديو احترافيًا من وصف واحد ثم شاركه مع المجتمع.', style: TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(height: 10),
                Text('#Novelvio #AIvideo #rewards', style: TextStyle(color: Colors.white70)),
              ]),
            ),
          ]),
        ),
      ),
      Positioned(
        right: 10,
        bottom: 130,
        child: Column(children: const [
          _Action(icon: Icons.favorite_border, label: '9.0K'),
          _Action(icon: Icons.star_border, label: '2.4W'),
          _Action(icon: Icons.share_outlined, label: ''),
          _Action(icon: Icons.more_horiz, label: ''),
        ]),
      ),
      Positioned(
        left: 16, right: 16, bottom: 16,
        child: SafeArea(
          top: false,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00C853), padding: const EdgeInsets.symmetric(vertical: 15)),
            onPressed: () => _studio(context),
            icon: const Icon(Icons.auto_awesome),
            label: const Text('إنشاء فيديو بالذكاء الاصطناعي', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    ]),
  );

  void _studio(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, MediaQuery.of(context).viewInsets.bottom + 18),
          child: ListView(shrinkWrap: true, children: [
            const Text('AI Video Studio', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            TextField(controller: prompt, maxLines: 4, decoration: const InputDecoration(labelText: 'وصف الفيديو', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(initialValue: seconds, decoration: const InputDecoration(labelText: 'المدة'), items: const [5, 10, 15, 30, 60].map((x) => DropdownMenuItem(value: x, child: Text('$x ثانية'))).toList(), onChanged: (x) => setState(() => seconds = x!)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(initialValue: quality, decoration: const InputDecoration(labelText: 'الجودة'), items: const [DropdownMenuItem(value: 'standard', child: Text('Standard')), DropdownMenuItem(value: 'pro', child: Text('Professional'))], onChanged: (x) => setState(() => quality = x!)),
            const SizedBox(height: 16),
            FilledButton(onPressed: busy ? null : create, child: Text(busy ? 'جارٍ الإنشاء...' : 'إنشاء الفيديو')),
            if (status != null) Padding(padding: const EdgeInsets.only(top: 10), child: Text(status!)),
          ]),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Action({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Column(children: [Icon(icon, color: Colors.white, size: 34), if (label.isNotEmpty) Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
  );
}