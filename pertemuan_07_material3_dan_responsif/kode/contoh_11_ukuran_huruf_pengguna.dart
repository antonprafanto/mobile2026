// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 11: Ukuran Huruf Pilihan Pengguna (TextScaler)
// Topik: Pengguna bisa memperbesar huruf di pengaturan ponselnya.
//        Penggeser di atas MENIRU pengaturan itu (1x sampai 2x) untuk
//        dua kartu jadwal. Kartu yang tingginya dipatok mulai rusak
//        (garis kuning-hitam), sedangkan kartu yang lentur ikut membesar.
//        Garis kuning-hitam di sini memang disengaja sebagai contoh.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiUkuranHuruf());
}

class AplikasiUkuranHuruf extends StatelessWidget {
  const AplikasiUkuranHuruf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HalamanUjiHuruf(),
    );
  }
}

class HalamanUjiHuruf extends StatefulWidget {
  const HalamanUjiHuruf({super.key});

  @override
  State<HalamanUjiHuruf> createState() => _HalamanUjiHurufState();
}

class _HalamanUjiHurufState extends State<HalamanUjiHuruf> {
  double _skala = 1.0;

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Salinan data MediaQuery yang sekarang, tetapi textScaler-nya diganti.
    // MediaQuery.of dipakai karena kita butuh SELURUH datanya untuk disalin.
    final MediaQueryData dataAsli = MediaQuery.of(context);
    final MediaQueryData dataTiruan = dataAsli.copyWith(
      textScaler: TextScaler.linear(_skala),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Uji Ukuran Huruf')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Ukuran huruf: ${_skala.toStringAsFixed(2)}x',
            style: gayaTeks.titleMedium,
          ),
          Slider(
            value: _skala,
            min: 1.0,
            max: 2.0,
            divisions: 4, // 1.00, 1.25, 1.50, 1.75, 2.00
            label: '${_skala.toStringAsFixed(2)}x',
            onChanged: (double nilaiBaru) {
              setState(() {
                _skala = nilaiBaru;
              });
            },
          ),
          const SizedBox(height: 8),
          // Hanya bagian di dalam MediaQuery ini yang hurufnya diperbesar.
          // Di aplikasi sungguhan, nilai ini datang dari pengaturan ponsel.
          MediaQuery(
            data: dataTiruan,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('❌ Tinggi dipatok 64'),
                SizedBox(height: 4),
                KartuJadwalKaku(),
                SizedBox(height: 24),
                Text('✅ Tinggi mengikuti isi'),
                SizedBox(height: 4),
                KartuJadwalLentur(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ❌ Tinggi dipatok dan teks tidak diberi ruang yang lentur.
class KartuJadwalKaku extends StatelessWidget {
  const KartuJadwalKaku({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: warna.surfaceContainerHighest,
      child: const Row(
        children: [
          Text('08.00', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pemrograman Piranti Bergerak'),
              Text('Lab Komputer 2 · Gedung C'),
            ],
          ),
        ],
      ),
    );
  }
}

// ✅ Tanpa tinggi tetap; teks berada di dalam Expanded sehingga bisa
//    turun ke baris berikutnya.
class KartuJadwalLentur extends StatelessWidget {
  const KartuJadwalLentur({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      color: warna.surfaceContainerHighest,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('08.00', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pemrograman Piranti Bergerak'),
                Text('Lab Komputer 2 · Gedung C'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
