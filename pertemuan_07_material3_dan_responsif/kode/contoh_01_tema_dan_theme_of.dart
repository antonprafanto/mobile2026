// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 01: Tema Aplikasi dan Theme.of(context)
// Topik: Warna dan gaya huruf sebaiknya diambil dari TEMA, bukan ditulis
//        langsung di setiap widget. Ganti nilai warnaBenih di bawah,
//        jalankan ulang, lalu bandingkan: Kartu A ikut berubah karena
//        mengambil warna dari tema, Kartu B tidak ikut berubah karena
//        warnanya ditulis langsung.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Satu-satunya tempat untuk mengganti warna SELURUH aplikasi.
// Coba ganti dengan Colors.deepOrange, Colors.green, atau Colors.pink.
const Color warnaBenih = Colors.teal;

void main() {
  runApp(const AplikasiPengumuman());
}

class AplikasiPengumuman extends StatelessWidget {
  const AplikasiPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Tema berlaku untuk SEMUA halaman dan widget di bawah MaterialApp.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: warnaBenih),
      ),
      home: const HalamanPengumuman(),
    );
  }
}

class HalamanPengumuman extends StatelessWidget {
  const HalamanPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme.of(context) = "tema yang berlaku di tempat widget ini berada".
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengumuman Himpunan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Kartu A: mengikuti tema', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // ✅ Semua warna dan gaya huruf diambil dari tema.
          Card(
            color: warna.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Malam Keakraban 2026',
                    style: gayaTeks.titleLarge?.copyWith(
                      color: warna.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sabtu, 24 Oktober · Aula Rektorat',
                    style: gayaTeks.bodyMedium?.copyWith(
                      color: warna.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Daftar sekarang'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Kartu B: warna ditulis langsung', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // ❌ Tidak disarankan: semua warna dan ukuran huruf ditulis langsung.
          Card(
            color: const Color(0xFFE3F2FD), // biru muda
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lomba Desain Poster',
                    style: TextStyle(fontSize: 22, color: Color(0xFF0D47A1)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Batas kirim karya: 31 Oktober',
                    style: TextStyle(fontSize: 14, color: Color(0xFF0D47A1)),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('Lihat ketentuan'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Komponen tanpa pengaturan warna', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // Komponen Material otomatis memakai warna dari tema.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const Chip(label: Text('Seminar')),
              const Chip(
                avatar: Icon(Icons.emoji_events),
                label: Text('Lomba'),
              ),
              OutlinedButton(onPressed: () {}, child: const Text('Arsip')),
              TextButton(onPressed: () {}, child: const Text('Bantuan')),
            ],
          ),
          const SizedBox(height: 16),
          Text('Kuota peserta terisi 70%', style: gayaTeks.bodyMedium),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.7),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Tulis pengumuman',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
