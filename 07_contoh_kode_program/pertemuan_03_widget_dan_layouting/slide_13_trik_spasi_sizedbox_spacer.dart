// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 13: TRIK SPASI LAYOUT
// TOPIK: Menguasai Jarak Antar Elemen: SizedBox vs Spacer vs Expanded
// =====================================================================
// CARA MENJALANKAN: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const Slide13SpacingApp());

class Slide13SpacingApp extends StatelessWidget {
  const Slide13SpacingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAF8F5)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SLIDE 13 • SIZEDBOX VS SPACER',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFFFFE600),
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
              // 1. SizedBox (Jarak Tetap / Pasti)
              _buildCard(
                title: '1. SizedBox (Jarak Pasti / Tetap)',
                desc:
                    'Memberi celah tepat sejumlah piksel tertentu (misal: 16px).',
                color: const Color(0xFFE0F2FE),
                child: Row(
                  children: [
                    _itemBox('A', Colors.amber),
                    const SizedBox(width: 24), // Jarak pasti 24px
                    _itemBox('B (SizedBox 24px)', Colors.cyan),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Spacer (Mendorong ke Ujung)
              _buildCard(
                title: '2. Spacer() (Pendorong Otomatis)',
                desc:
                    'Menghabiskan seluruh ruang kosong untuk mendorong elemen ke tepi kiri dan kanan.',
                color: const Color(0xFFFEF08A),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text(
                      'Judul Halaman',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(), // Dorong tombol bookmark ke pojok paling kanan!
                    const Icon(Icons.bookmark_border, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Expanded (Mengisi Sisa Ruang)
              _buildCard(
                title: '3. Expanded (Membagi Ruang Proporsional)',
                desc:
                    'Memaksa widget anak melebar mengisi sisa ruang yang ada (flex: 1 dan flex: 2).',
                color: const Color(0xFFDCFCE7),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: const Color(0xFFFB7185),
                        child: const Text(
                          'Flex 1 (33%)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: const Color(0xFF4ADE80),
                        child: const Text(
                          'Flex 2 (66%)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String desc,
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
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
          Text(
            desc,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _itemBox(String text, Color col) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: col,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
