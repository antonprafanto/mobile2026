// =====================================================================
// SLIDE 17: RANGKUMAN CHECKLIST UI RESPONSIF STANDAR 2026
// Topik: 5 Aturan Emas Desain Aplikasi Mobile Lintas Platform
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ChecklistUiApp());
}

class ChecklistUiApp extends StatelessWidget {
  const ChecklistUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 17 - Checklist Responsif',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ChecklistScreen(),
    );
  }
}

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  final List<Map<String, String>> _rules = const [
    {
      'title': '1. Hindari Hardcode Lebar Layar',
      'desc': 'Jangan tulis width: 360, gunakan MediaQuery atau Expanded.',
    },
    {
      'title': '2. Gunakan Standar Breakpoints',
      'desc':
          'Pisahkan tata letak pada ambang 600dp (ponsel) dan 840dp (tablet).',
    },
    {
      'title': '3. Manfaatkan LayoutBuilder',
      'desc':
          'Bungkus komponen modular agar dapat beradaptasi di dalam split-pane.',
    },
    {
      'title': '4. Navigasi Adaptif',
      'desc':
          'Gunakan NavigationBar di bawah untuk ponsel, NavigationRail di samping untuk tablet.',
    },
    {
      'title': '5. Dukung Dynamic Theming',
      'desc':
          'Pastikan teks dan kontras terbaca jelas pada Light Mode maupun Dark Mode.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide 17: 5 Aturan Emas Responsif'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _rules.length,
        itemBuilder: (context, index) {
          final r = _rules[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                r['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(r['desc']!),
            ),
          );
        },
      ),
    );
  }
}
