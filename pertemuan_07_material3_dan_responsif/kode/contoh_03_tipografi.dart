// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 03: Tipografi Material 3 (TextTheme)
// Topik: Material 3 menyediakan 15 gaya huruf siap pakai dalam lima
//        kelompok (display, headline, title, body, label). Setiap
//        kelompok punya ukuran Large, Medium, dan Small. Ambil gayanya
//        dari Theme.of(context).textTheme, bukan menulis fontSize sendiri.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTipografi());
}

class AplikasiTipografi extends StatelessWidget {
  const AplikasiTipografi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HalamanTipografi(),
    );
  }
}

class HalamanTipografi extends StatelessWidget {
  const HalamanTipografi({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tipografi Material 3')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ArtikelContoh(),
          const SizedBox(height: 24),
          const JudulKelompok(
            nama: 'Display',
            kegunaan: 'Angka atau teks pendek yang sangat besar',
          ),
          BarisGaya(nama: 'displayLarge', gaya: t.displayLarge),
          BarisGaya(nama: 'displayMedium', gaya: t.displayMedium),
          BarisGaya(nama: 'displaySmall', gaya: t.displaySmall),
          const JudulKelompok(
            nama: 'Headline',
            kegunaan: 'Judul halaman atau judul bagian penting',
          ),
          BarisGaya(nama: 'headlineLarge', gaya: t.headlineLarge),
          BarisGaya(nama: 'headlineMedium', gaya: t.headlineMedium),
          BarisGaya(nama: 'headlineSmall', gaya: t.headlineSmall),
          const JudulKelompok(
            nama: 'Title',
            kegunaan: 'Judul AppBar, judul kartu, judul baris daftar',
          ),
          BarisGaya(nama: 'titleLarge', gaya: t.titleLarge),
          BarisGaya(nama: 'titleMedium', gaya: t.titleMedium),
          BarisGaya(nama: 'titleSmall', gaya: t.titleSmall),
          const JudulKelompok(
            nama: 'Body',
            kegunaan: 'Isi bacaan (paragraf, keterangan)',
          ),
          BarisGaya(nama: 'bodyLarge', gaya: t.bodyLarge),
          BarisGaya(nama: 'bodyMedium', gaya: t.bodyMedium),
          BarisGaya(nama: 'bodySmall', gaya: t.bodySmall),
          const JudulKelompok(
            nama: 'Label',
            kegunaan: 'Tulisan pada tombol, chip, dan keterangan kecil',
          ),
          BarisGaya(nama: 'labelLarge', gaya: t.labelLarge),
          BarisGaya(nama: 'labelMedium', gaya: t.labelMedium),
          BarisGaya(nama: 'labelSmall', gaya: t.labelSmall),
        ],
      ),
    );
  }
}

// Contoh pemakaian nyata: setiap teks memakai PERAN yang sesuai.
class ArtikelContoh extends StatelessWidget {
  const ArtikelContoh({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // labelLarge + warna primary: kategori berita.
            Text(
              'BERITA PRODI',
              style: t.labelLarge?.copyWith(color: warna.primary),
            ),
            const SizedBox(height: 8),
            // headlineSmall: judul artikel.
            Text(
              'Mahasiswa Informatika Juara Lomba Aplikasi',
              style: t.headlineSmall,
            ),
            const SizedBox(height: 4),
            // labelMedium + onSurfaceVariant: keterangan yang tidak utama.
            Text(
              'Senin, 12 Oktober 2026 · 3 menit baca',
              style: t.labelMedium?.copyWith(color: warna.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            // bodyLarge: isi bacaan.
            Text(
              'Tim beranggotakan tiga mahasiswa angkatan 2024 membuat '
              'aplikasi antrean kantin yang mengurangi waktu tunggu '
              'hingga separuhnya.',
              style: t.bodyLarge,
            ),
            const SizedBox(height: 12),
            // Tulisan tombol otomatis memakai labelLarge.
            FilledButton.tonal(
              onPressed: () {},
              child: const Text('Baca selengkapnya'),
            ),
          ],
        ),
      ),
    );
  }
}

class JudulKelompok extends StatelessWidget {
  const JudulKelompok({super.key, required this.nama, required this.kegunaan});

  final String nama;
  final String kegunaan;

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nama, style: t.titleMedium?.copyWith(color: warna.primary)),
          Text(
            kegunaan,
            style: t.bodySmall?.copyWith(color: warna.onSurfaceVariant),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class BarisGaya extends StatelessWidget {
  const BarisGaya({super.key, required this.nama, required this.gaya});

  final String nama;
  final TextStyle? gaya; // gaya dari TextTheme bertipe TextStyle? (bisa null)

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    // Ukuran dan ketebalan dibaca langsung dari gayanya, bukan diketik.
    final String ukuran = (gaya?.fontSize ?? 0).toStringAsFixed(0);
    final bool tebalSedang = gaya?.fontWeight == FontWeight.w500;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kampus',
            style: gaya,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            tebalSedang ? '$nama · $ukuran · w500' : '$nama · $ukuran',
            style: t.labelSmall?.copyWith(color: warna.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
