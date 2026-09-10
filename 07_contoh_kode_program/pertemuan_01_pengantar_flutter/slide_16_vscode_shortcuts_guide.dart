// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 16: CHEATSHEET PINTASAN VS CODE
// TOPIK: Shortcut Wajib, Refactor Otomatis, & Ekstensi Produktif Lab
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke: lib/main.dart
// 2. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const Slide16ShortcutsApp());
}

class Slide16ShortcutsApp extends StatelessWidget {
  const Slide16ShortcutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - VS Code Shortcuts',
      theme: ThemeData(useMaterial3: true),
      home: const ShortcutsScreen(),
    );
  }
}

class ShortcutsScreen extends StatelessWidget {
  const ShortcutsScreen({super.key});

  final List<Map<String, String>> _shortcuts = const [
    {
      'keys': 'Ctrl + ~',
      'action': 'Membuka / Menutup Terminal internal VS Code',
    },
    {
      'keys': 'Ctrl + S',
      'action': 'Simpan Berkas & Otomatis Memicu Hot Reload',
    },
    {
      'keys': 'Alt + Enter',
      'action': 'Menu Sakti Refactor (Wrap with Widget, Column, Padding)',
    },
    {'keys': 'Ctrl + P', 'action': 'Pencarian Berkas Kilat (Quick Open File)'},
    {
      'keys': 'Ctrl + /',
      'action': 'Memberi komentar / Uncomment baris kode terpilih',
    },
    {
      'keys': 'Shift + Alt + F',
      'action': 'Memformat & merapikan struktur kode otomatis',
    },
    {'keys': 'r (di terminal)', 'action': 'Hot Reload instan (<1 detik)'},
    {'keys': 'R (di terminal)', 'action': 'Hot Restart aplikasi (reset state)'},
    {
      'keys': 'q (di terminal)',
      'action': 'Menghentikan proses flutter run (Quit)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('SLIDE 16: Cheatsheet Shortcut Sakti VS Code'),
        backgroundColor: const Color(0xFFFFE600),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _shortcuts.length,
        itemBuilder: (context, index) {
          final s = _shortcuts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(3, 3)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE600),
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Text(
                    s['keys']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    s['action']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
