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
    if (c == null) { setState(() => status = 'Configure Supabase and the video provider first.'); return; }
    setState(() => busy = true);
    try {
      final r = await c.functions.invoke('generate-video', body: {
        'prompt': prompt.text.trim(), 'duration_seconds': seconds, 'quality': quality,
      });
      if (mounted) setState(() => status = 'Request created: ${r.data}');
    } catch (e) {
      if (mounted) setState(() => status = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('AI Video Studio')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Create a professional video', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      TextField(controller: prompt, maxLines: 5, decoration: const InputDecoration(labelText: 'Video description')),
      const SizedBox(height: 12),
      DropdownButtonFormField<int>(
        initialValue: seconds,
        items: const [5, 10, 15, 30, 60].map((v) => DropdownMenuItem(value: v, child: Text('$v seconds'))).toList(),
        onChanged: (v) => setState(() => seconds = v!),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        initialValue: quality,
        items: const [
          DropdownMenuItem(value: 'standard', child: Text('Standard')),
          DropdownMenuItem(value: 'pro', child: Text('Professional')),
        ],
        onChanged: (v) => setState(() => quality = v!),
      ),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: busy ? null : create, icon: const Icon(Icons.auto_awesome), label: Text(busy ? 'Creating…' : 'Create video')),
      if (status != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(status!)),
    ]),
  );
}
