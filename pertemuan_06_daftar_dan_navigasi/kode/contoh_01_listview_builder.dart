// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 01: ListView.builder, Daftar yang Dibangun Sesuai Kebutuhan
// Topik: ListView.builder hanya membangun baris yang akan terlihat di
//        layar (ditambah sedikit cadangan). Buka konsol, lalu gulir
//        pelan-pelan: catatan "membangun baris ke-N" baru muncul saat
//        baris itu mendekati layar, bukan 1000 baris sekaligus di awal.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAntrean());
}

class AplikasiAntrean extends StatelessWidget {
  const AplikasiAntrean({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanAntrean(),
    );
  }
}

class HalamanAntrean extends StatelessWidget {
  const HalamanAntrean({super.key});

  // Sengaja dibuat banyak untuk membuktikan bahwa ListView.builder
  // tetap ringan walaupun datanya ribuan.
  static const int jumlahAntrean = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrean Layanan Akademik')),
      body: ListView.builder(
        // itemCount: berapa banyak baris seluruhnya.
        itemCount: jumlahAntrean,
        // itemBuilder: "resep" untuk membuat SATU baris. Flutter
        // memanggilnya hanya untuk baris yang dibutuhkan saat itu.
        // index dimulai dari 0, jadi nomor antrean = index + 1.
        itemBuilder: (BuildContext context, int index) {
          final int nomor = index + 1;
          debugPrint('membangun baris ke-$nomor');
          return ListTile(
            leading: CircleAvatar(child: Text('$nomor')),
            title: Text('Nomor antrean $nomor'),
            subtitle: Text(nomor.isEven ? 'Loket 2' : 'Loket 1'),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
