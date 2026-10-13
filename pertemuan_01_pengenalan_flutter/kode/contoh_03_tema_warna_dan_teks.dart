// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 03: Tema Warna dan Gaya Teks
// Topik: Satu warna "benih" -> palet Material 3 + gaya teks dari tema.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTema());
}

class AplikasiTema extends StatelessWidget {
  const AplikasiTema({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tema dan Teks',
      theme: ThemeData(
        // COBA: ganti Colors.indigo dengan Colors.green, lalu simpan.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanSapaan(),
    );
  }
}

class HalamanSapaan extends StatelessWidget {
  const HalamanSapaan({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil palet warna & gaya teks dari tema, BUKAN menulis warna manual.
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.primaryContainer,
        title: const Text('Halo, Flutter!'),
      ),
      body: Center(
        // Column menyusun anak-anaknya dari atas ke bawah.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 96, color: warna.primary),
            const SizedBox(height: 16), // jarak kosong 16 piksel
            Text('Aplikasi Pertamaku', style: gayaTeks.headlineMedium),
            const SizedBox(height: 8),
            Text('Dibuat dengan Flutter dan Dart', style: gayaTeks.bodyLarge),
          ],
        ),
      ),
    );
  }
}
