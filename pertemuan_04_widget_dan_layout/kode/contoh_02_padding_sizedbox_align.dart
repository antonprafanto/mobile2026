// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 02: Jarak, Ukuran, dan Posisi
// Topik: Padding, SizedBox, Center, dan Align.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiJarak());
}

class AplikasiJarak extends StatelessWidget {
  const AplikasiJarak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanJarak(),
    );
  }
}

class HalamanJarak extends StatelessWidget {
  const HalamanJarak({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Padding, SizedBox, Align')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Padding: memberi jarak DI SEKELILING satu widget.
            //    Pita berwarna = area padding, kotak putih = anaknya.
            const KotakPadding(
              jarak: EdgeInsets.all(16), // 16 di keempat sisi
              label: 'Semua sisi 16',
            ),
            const SizedBox(height: 8),
            const KotakPadding(
              // symmetric: kiri-kanan (horizontal) dan atas-bawah (vertical)
              jarak: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
              label: 'Kiri-kanan 48, atas-bawah 8',
            ),
            const SizedBox(height: 8),
            const KotakPadding(
              jarak: EdgeInsets.only(left: 96, top: 8), // sisi tertentu saja
              label: 'Kiri 96, atas 8',
            ),

            // 2) SizedBox kosong: jarak antarwidget.
            const SizedBox(height: 24),

            // 3) SizedBox berisi: memaksa ukuran anaknya.
            SizedBox(
              width: 200,
              height: 48,
              child: FilledButton(
                onPressed: () {}, // aksi tombol dibahas di Pertemuan 5
                child: const Text('Lebar 200, tinggi 48'),
              ),
            ),
            const SizedBox(height: 24),

            // 4) Align mengatur posisi anak di dalam ruangnya. Center sama
            //    dengan Align(alignment: Alignment.center).
            //    "for" di dalam children: tiap putaran = satu widget.
            for (Alignment posisi in [
              Alignment.topLeft,
              Alignment.center,
              Alignment.bottomRight,
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  height: 80,
                  child: ColoredBox(
                    color: warna.surfaceContainerHighest,
                    child: Align(
                      alignment: posisi,
                      child: Chip(label: Text('Align: $posisi')),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Menampilkan Padding dengan dua warna: pita luar menunjukkan area padding,
// kotak dalam menunjukkan widget anak yang "didorong" ke dalam.
class KotakPadding extends StatelessWidget {
  const KotakPadding({super.key, required this.jarak, required this.label});

  final EdgeInsets jarak;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return ColoredBox(
      color: warna.primaryContainer,
      child: Padding(
        padding: jarak,
        child: ColoredBox(color: warna.surface, child: Text(label)),
      ),
    );
  }
}
