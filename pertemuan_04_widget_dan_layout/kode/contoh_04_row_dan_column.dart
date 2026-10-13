// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 04: Row dan Column
// Topik: Sumbu utama (main axis) dan sumbu silang (cross axis),
//        MainAxisAlignment, CrossAxisAlignment, dan spacing.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRowColumn());
}

class AplikasiRowColumn extends StatelessWidget {
  const AplikasiRowColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HalamanRowColumn(),
    );
  }
}

class HalamanRowColumn extends StatelessWidget {
  const HalamanRowColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row dan Column')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8, // jarak 8 piksel di antara setiap anak Column
          children: [
            const Text('MainAxisAlignment pada Row (sumbu utama = mendatar):'),
            // Enum dari Pertemuan 3: values berisi semua pilihan yang ada.
            for (MainAxisAlignment pilihan in MainAxisAlignment.values)
              BingkaiContoh(
                label: pilihan.name,
                child: Row(
                  mainAxisAlignment: pilihan,
                  children: const [
                    KotakKecil(tinggi: 32),
                    KotakKecil(tinggi: 32),
                    KotakKecil(tinggi: 32),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            const Text('CrossAxisAlignment pada Row (sumbu silang = tegak):'),
            for (CrossAxisAlignment pilihan in [
              CrossAxisAlignment.start,
              CrossAxisAlignment.center,
              CrossAxisAlignment.end,
              CrossAxisAlignment.stretch,
            ])
              BingkaiContoh(
                label: pilihan.name,
                child: SizedBox(
                  height: 64,
                  child: Row(
                    crossAxisAlignment: pilihan,
                    spacing: 8,
                    children: const [
                      KotakKecil(tinggi: 24),
                      KotakKecil(tinggi: 40),
                      KotakKecil(tinggi: 56),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Bingkai berlabel agar setiap contoh mudah dibedakan.
class BingkaiContoh extends StatelessWidget {
  const BingkaiContoh({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: warna.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          child,
        ],
      ),
    );
  }
}

// Kotak berwarna kecil sebagai "barang" yang disusun.
class KotakKecil extends StatelessWidget {
  const KotakKecil({super.key, required this.tinggi});

  final double tinggi;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: tinggi,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
