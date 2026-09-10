// =====================================================================
// SLIDE 16: PINTASAN PRODUKTIVITAS VS CODE UNTUK FLUTTER
// Topik: Shortcut Wajib Mempercepat Coding di Laboratorium
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ShortcutsGuideApp());
}

class ShortcutsGuideApp extends StatelessWidget {
  const ShortcutsGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - VS Code Shortcuts',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const ShortcutsScreen(),
    );
  }
}

class ShortcutsScreen extends StatelessWidget {
  const ShortcutsScreen({super.key});

  final List<Map<String, String>> _shortcuts = const [
    {'key': 'Ctrl + S', 'desc': 'Simpan berkas & picu Hot Reload otomatis'},
    {
      'key': 'Alt + Enter',
      'desc': 'Buka menu Refactor (Wrap Widget, Column, Padding)',
    },
    {
      'key': 'Shift + Alt + F',
      'desc': 'Format dokumen / merapikan lekukan kode',
    },
    {'key': 'Ctrl + ~', 'desc': 'Buka / tutup Terminal internal VS Code'},
    {'key': 'Ctrl + /', 'desc': 'Komentar satu atau beberapa baris kode'},
    {'key': 'r (di Terminal)', 'desc': 'Hot Reload instan (<1 detik)'},
    {'key': 'R (di Terminal)', 'desc': 'Hot Restart aplikasi (reset state)'},
    {'key': 'q (di Terminal)', 'desc': 'Hentikan sesi debugging (Quit)'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 16: Cheat Sheet VS Code'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _shortcuts.length,
        itemBuilder: (context, index) {
          final item = _shortcuts[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(
                item['key']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['desc']!),
            ),
          );
        },
      ),
    );
  }
}
