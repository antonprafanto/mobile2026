// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 08: Mengatasi Overflow
// Topik: Tiga masalah "meluber" yang paling sering terjadi beserta
//        solusinya: Expanded, Wrap, dan SingleChildScrollView.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Untuk MELIHAT masalahnya, hapus tanda // pada baris berlabel
//    MASALAH, lalu jalankan ulang. Perhatikan garis kuning-hitam.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiOverflow());
}

class AplikasiOverflow extends StatelessWidget {
  const AplikasiOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const HalamanOverflow(),
    );
  }
}

class HalamanOverflow extends StatelessWidget {
  const HalamanOverflow({super.key});

  static const String teksPanjang =
      'Pengumuman: jadwal praktikum Pemrograman Piranti Bergerak dipindah '
      'ke Laboratorium Komputer 2 mulai minggu depan.';

  static const List<String> topik = [
    'Widget',
    'Row',
    'Column',
    'Stack',
    'Expanded',
    'Constraints',
    'Overflow',
    'Wrap',
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mengatasi Overflow')),
      // SOLUSI 3: SingleChildScrollView. Tanpanya, Column yang lebih tinggi
      // dari layar akan meluber ke bawah.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text('1) Teks panjang di dalam Row', style: gayaTeks.titleMedium),
            // MASALAH: teks di dalam Row tidak tahu batas lebarnya.
            // const Row(children: [Icon(Icons.campaign), Text(teksPanjang)]),
            //
            // SOLUSI 1: bungkus teks dengan Expanded agar memakai sisa ruang
            // saja, lalu teks otomatis turun ke baris berikutnya.
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Icon(Icons.campaign),
                Expanded(child: Text(teksPanjang)),
              ],
            ),
            // Variasi: cukup satu baris, sisanya diganti tanda elipsis (...).
            const Row(
              spacing: 8,
              children: [
                Icon(Icons.campaign),
                Expanded(
                  child: Text(
                    teksPanjang,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(),

            Text(
              '2) Banyak chip dalam satu baris',
              style: gayaTeks.titleMedium,
            ),
            // MASALAH: Row tidak pernah pindah baris.
            // Row(children: [for (String t in topik) Chip(label: Text(t))]),
            //
            // SOLUSI 2: Wrap otomatis pindah ke baris berikutnya.
            Wrap(
              spacing: 8, // jarak mendatar antar-chip
              runSpacing: 8, // jarak antarbaris
              children: [for (String t in topik) Chip(label: Text(t))],
            ),
            const Divider(),

            Text('3) Isi lebih tinggi dari layar', style: gayaTeks.titleMedium),
            const Text(
              'Kartu-kartu di bawah ini jika digabung lebih tinggi daripada '
              'layar. Halaman tetap aman karena dibungkus '
              'SingleChildScrollView: cukup gulir ke bawah.',
            ),
            for (int i = 1; i <= 6; i++)
              Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('$i')),
                  title: Text('Materi minggu ke-$i'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
