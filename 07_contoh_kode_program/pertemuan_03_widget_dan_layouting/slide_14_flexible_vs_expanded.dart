// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 14: FLEXIBLE VS EXPANDED
// TOPIK: Perbedaan FlexFit.loose (Flexible) vs FlexFit.tight (Expanded)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanFlexibleExpanded(),
    ),
  );
}

class HalamanFlexibleExpanded extends StatelessWidget {
  const HalamanFlexibleExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible vs Expanded')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flexible: Mengizinkan anak berukuran lebih kecil dari jatah ruang
            const Text(
              '1. Flexible (Menyesuaikan Ukuran Teks):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: Container(
                    color: Colors.green[200],
                    padding: const EdgeInsets.all(8),
                    child: const Text('Teks Pendek'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Expanded: Memaksa anak melebar penuh mengisi seluruh ruang
            const Text(
              '2. Expanded (Dipaksa Melebar Penuh):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.amber[200],
                    padding: const EdgeInsets.all(8),
                    child: const Text('Teks Pendek (Melebar Penuh)'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
