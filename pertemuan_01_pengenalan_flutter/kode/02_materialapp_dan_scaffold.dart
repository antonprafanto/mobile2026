// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 02: MaterialApp dan Scaffold
// Topik: Kerangka standar aplikasi: tema, AppBar, dan isi halaman.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSaya());
}

// Widget paling atas (akar). "Stateless" = tampilannya tidak berubah
// sendiri; ia hanya menyusun widget lain.
class AplikasiSaya extends StatelessWidget {
  const AplikasiSaya({super.key});

  // build() dipanggil Flutter untuk "menggambar" widget ini.
  @override
  Widget build(BuildContext context) {
    // MaterialApp menyiapkan fondasi: tema, arah teks, navigasi, dll.
    return const MaterialApp(
      title: 'Aplikasi Pertama', // judul di tab browser / daftar aplikasi
      debugShowCheckedModeBanner: false, // sembunyikan pita "DEBUG"
      home: HalamanUtama(), // halaman pertama yang ditampilkan
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = "kerangka rumah" satu halaman: atap (appBar) + isi (body).
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Pertama Saya')),
      body: const Center(child: Text('Halo! Ini halaman utama.')),
    );
  }
}
