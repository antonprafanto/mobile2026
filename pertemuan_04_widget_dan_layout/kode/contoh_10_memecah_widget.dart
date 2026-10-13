// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 10: Memecah Tampilan Menjadi Widget Kecil
// Topik: Membuat widget sendiri (StatelessWidget) yang menerima parameter,
//        lalu memakainya berulang kali. Kode menjadi pendek dan rapi.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiRingkasan());
}

class AplikasiRingkasan extends StatelessWidget {
  const AplikasiRingkasan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanRingkasan(),
    );
  }
}

// Halaman utama cukup "merangkai" widget-widget kecil di bawahnya.
class HalamanRingkasan extends StatelessWidget {
  const HalamanRingkasan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Belajar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            const SapaanPengguna(nama: 'Rina'),
            const Row(
              spacing: 12,
              children: [
                Expanded(
                  child: KartuStatistik(
                    ikon: Icons.task_alt,
                    angka: '12',
                    label: 'Tugas',
                  ),
                ),
                Expanded(
                  child: KartuStatistik(
                    ikon: Icons.quiz,
                    angka: '4',
                    label: 'Kuis',
                  ),
                ),
                Expanded(
                  child: KartuStatistik(
                    ikon: Icons.event_available,
                    angka: '95%',
                    label: 'Hadir',
                  ),
                ),
              ],
            ),
            Text(
              'Jadwal Hari Ini',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const BarisJadwal(
              jam: '08.00',
              mataKuliah: 'Pemrograman Piranti Bergerak',
              ruang: 'Lab 2',
            ),
            const BarisJadwal(
              jam: '10.30',
              mataKuliah: 'Basis Data Lanjut',
              ruang: 'Ruang 304',
            ),
            const BarisJadwal(
              jam: '13.00',
              mataKuliah: 'Interaksi Manusia dan Komputer',
              ruang: 'Ruang 201',
            ),
          ],
        ),
      ),
    );
  }
}

class SapaanPengguna extends StatelessWidget {
  const SapaanPengguna({super.key, required this.nama});

  final String nama;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    return Row(
      spacing: 12,
      children: [
        CircleAvatar(radius: 24, child: Text(nama[0])),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selamat pagi,', style: gayaTeks.bodyMedium),
              Text(nama, style: gayaTeks.titleLarge),
            ],
          ),
        ),
      ],
    );
  }
}

// Satu kartu angka. Dipakai tiga kali dengan isi berbeda.
class KartuStatistik extends StatelessWidget {
  const KartuStatistik({
    super.key,
    required this.ikon,
    required this.angka,
    required this.label,
  });

  final IconData ikon;
  final String angka;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 4,
          children: [
            Icon(ikon, color: warna.primary),
            Text(angka, style: gayaTeks.headlineSmall),
            Text(
              label,
              textAlign: TextAlign.center,
              style: gayaTeks.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// Satu baris jadwal kuliah.
class BarisJadwal extends StatelessWidget {
  const BarisJadwal({
    super.key,
    required this.jam,
    required this.mataKuliah,
    required this.ruang,
  });

  final String jam;
  final String mataKuliah;
  final String ruang;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    return Card.outlined(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: warna.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(jam, style: gayaTeks.labelLarge),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mataKuliah,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: gayaTeks.titleSmall,
                  ),
                  Text(ruang, style: gayaTeks.bodySmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: warna.outline),
          ],
        ),
      ),
    );
  }
}
