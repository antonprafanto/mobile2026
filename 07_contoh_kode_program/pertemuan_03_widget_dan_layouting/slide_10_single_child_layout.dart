// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 10: SINGLE-CHILD LAYOUT
// TOPIK: Memilih Wadah Tepat: Container vs Padding vs Center
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide10SingleChildApp());

class Slide10SingleChildApp extends StatelessWidget {
  const Slide10SingleChildApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 10 • SINGLE-CHILD LAYOUT',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF4ADE80),
          elevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.5),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Center Widget
              _buildDemoBox(
                label: '1. Center Widget',
                sublabel: 'Menaruh anak tepat di sumbu tengah ruang yang ada.',
                color: const Color(0xFFE0F2FE),
                child: const Center(
                  child: Text(
                    'Tepat di Tengah!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Padding Widget
              _buildDemoBox(
                label: '2. Padding Widget',
                sublabel:
                    'Hanya menyisipkan rongga jarak tepi (hemat komputasi).',
                color: const Color(0xFFFEF08A),
                child: Container(
                  color: Colors.black12,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      'Diberi Padding 24px Horizontal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Container Multifungsi
              _buildDemoBox(
                label: '3. Container Widget (Swiss Army Knife)',
                sublabel: 'Bisa dekorasi warna, margin, border, dan bayangan.',
                color: const Color(0xFFFECDD3),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE600),
                    border: Border.all(color: Colors.black, width: 2.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                    ],
                  ),
                  child: const Text(
                    'Container dengan Border & Hard Shadow',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoBox({
    required String label,
    required String sublabel,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          Text(
            sublabel,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
