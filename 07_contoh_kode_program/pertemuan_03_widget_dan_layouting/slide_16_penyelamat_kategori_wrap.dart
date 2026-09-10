// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 16: WIDGET WRAP
// TOPIK: Menyusun Deretan Chip Otomatis Pindah Baris ke Bawah
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HalamanWrap()),
  );
}

class HalamanWrap extends StatelessWidget {
  const HalamanWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Wrap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Tag (Otomatis Pindah Baris Jika Penuh):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            // Wrap menggantikan Row agar tidak terjadi overflow garis kuning-hitam
            Wrap(
              spacing: 8.0, // Jarak horizontal antar chip
              runSpacing: 8.0, // Jarak vertikal antar baris
              children: const [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('Widget Tree')),
                Chip(label: Text('Row & Column')),
                Chip(label: Text('Layout Anti-Overflow')),
                Chip(label: Text('Mobile 2026')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
