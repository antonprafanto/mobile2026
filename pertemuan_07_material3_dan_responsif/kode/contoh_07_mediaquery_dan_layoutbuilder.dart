// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 07: MediaQuery vs LayoutBuilder
// Topik: MediaQuery.sizeOf(context) memberi ukuran JENDELA aplikasi.
//        LayoutBuilder memberi RUANG yang tersedia untuk satu widget.
//        Kartu yang sama disusun mendatar saat ruangnya lega dan disusun
//        tegak saat ruangnya sempit, walaupun ukuran jendelanya sama.
//        Ubah lebar jendela/panel, lalu perhatikan angka-angkanya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiUkuran());
}

class AplikasiUkuran extends StatelessWidget {
  const AplikasiUkuran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanUkuran(),
    );
  }
}

class HalamanUkuran extends StatelessWidget {
  const HalamanUkuran({super.key});

  @override
  Widget build(BuildContext context) {
    // Ukuran JENDELA aplikasi. Widget ini dibangun ulang otomatis
    // setiap kali ukuran jendela berubah.
    final Size ukuran = MediaQuery.sizeOf(context);
    final Orientation orientasi = MediaQuery.orientationOf(context);
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Ukuran Layar dan Ruang')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: warna.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MediaQuery: jendela', style: gayaTeks.titleMedium),
                  const SizedBox(height: 8),
                  Text('Lebar: ${ukuran.width.toStringAsFixed(0)}'),
                  Text('Tinggi: ${ukuran.height.toStringAsFixed(0)}'),
                  Text(
                    orientasi == Orientation.portrait
                        ? 'Orientasi: potret (tegak)'
                        : 'Orientasi: lanskap (mendatar)',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('LayoutBuilder: ruang widget', style: gayaTeks.titleMedium),
          const SizedBox(height: 8),
          // Kartu ini mendapat hampir seluruh lebar jendela.
          const KartuAdaptif(judul: 'Kartu lebar'),
          const SizedBox(height: 8),
          // Dua kartu berbagi satu baris: masing-masing mendapat separuh.
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: KartuAdaptif(judul: 'Kiri')),
              SizedBox(width: 8),
              Expanded(child: KartuAdaptif(judul: 'Kanan')),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget yang menyusun dirinya sendiri berdasarkan RUANG yang diberikan
// induknya, bukan berdasarkan ukuran jendela.
class KartuAdaptif extends StatelessWidget {
  const KartuAdaptif({super.key, required this.judul});

  final String judul;

  // Di bawah lebar ini, isi kartu disusun tegak.
  static const double batasSempit = 240;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints batasan) {
            // batasan.maxWidth = lebar paling besar yang BOLEH dipakai.
            final double ruang = batasan.maxWidth;
            final bool sempit = ruang < batasSempit;

            final Widget ikon = CircleAvatar(
              backgroundColor: warna.primaryContainer,
              child: Icon(Icons.aspect_ratio, color: warna.onPrimaryContainer),
            );
            final Widget keterangan = Column(
              crossAxisAlignment: sempit
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(judul, style: Theme.of(context).textTheme.titleSmall),
                Text('Ruang: ${ruang.toStringAsFixed(0)}'),
                Text(sempit ? 'Susunan: tegak' : 'Susunan: mendatar'),
              ],
            );

            if (sempit) {
              return Column(
                children: [ikon, const SizedBox(height: 8), keterangan],
              );
            }
            return Row(
              children: [
                ikon,
                const SizedBox(width: 12),
                Expanded(child: keterangan),
              ],
            );
          },
        ),
      ),
    );
  }
}
