// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 03: Container dan Dekorasi
// Topik: Container, BoxDecoration (sudut bulat, garis tepi, bayangan),
//        serta Card bawaan Material 3.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiDekorasi());
}

class AplikasiDekorasi extends StatelessWidget {
  const AplikasiDekorasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HalamanDekorasi(),
    );
  }
}

class HalamanDekorasi extends StatelessWidget {
  const HalamanDekorasi({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Container dan Dekorasi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1) Container: "kotak serbaguna" dengan ukuran, jarak, dan hiasan.
            Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 16), // jarak DI LUAR kotak
              padding: const EdgeInsets.all(16), // jarak DI DALAM kotak
              decoration: BoxDecoration(
                color: warna.primaryContainer,
                borderRadius: BorderRadius.circular(16), // sudut membulat
                border: Border.all(color: warna.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: warna.shadow.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4), // bayangan turun 4 piksel
                  ),
                ],
              ),
              child: Text(
                'Container dengan margin, padding, warna, sudut bulat, '
                'garis tepi, dan bayangan.',
                style: gayaTeks.titleMedium,
              ),
            ),

            // 2) Bentuk lingkaran dengan BoxShape.circle.
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: warna.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant,
                  color: warna.onSecondary,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3) Card: kartu bawaan Material 3, sudah lengkap dengan bentuk
            //    dan bayangan. Biasanya lebih tepat daripada menghias sendiri.
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card biasa (elevated)'),
              ),
            ),
            const Card.filled(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card.filled: berlatar warna, tanpa bayangan'),
              ),
            ),
            const Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card.outlined: hanya garis tepi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
