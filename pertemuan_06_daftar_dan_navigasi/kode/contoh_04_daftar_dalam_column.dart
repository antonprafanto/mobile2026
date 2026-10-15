// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 04: Daftar di Dalam Column (Wajib Dibungkus Expanded)
// Topik: Kartu ringkasan di atas DIAM di tempat, hanya daftar di
//        bawahnya yang bisa digulir. ListView di dalam Column harus
//        dibungkus Expanded agar tahu tinggi yang boleh dipakainya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Eksperimen: hapus Expanded (sisakan ListView-nya saja), jalankan
//    ulang, lalu baca pesan error di konsol.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiJadwal());
}

class JadwalKuliah {
  const JadwalKuliah(this.jam, this.mataKuliah, this.ruang);

  final String jam;
  final String mataKuliah;
  final String ruang;
}

const List<JadwalKuliah> jadwalSenin = [
  JadwalKuliah('07.30', 'Pemrograman Piranti Bergerak', 'Lab. Komputer 2'),
  JadwalKuliah('10.00', 'Basis Data', 'Ruang B.204'),
  JadwalKuliah('13.00', 'Jaringan Komputer', 'Ruang C.101'),
  JadwalKuliah('15.30', 'Statistika', 'Ruang B.105'),
  JadwalKuliah('16.30', 'Kewirausahaan', 'Aula Utama'),
  JadwalKuliah('18.30', 'Bahasa Inggris', 'Ruang A.301'),
  JadwalKuliah('19.30', 'Etika Profesi', 'Ruang A.302'),
  JadwalKuliah('20.30', 'Mentoring Proyek', 'Daring (Zoom)'),
];

class AplikasiJadwal extends StatelessWidget {
  const AplikasiJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HalamanJadwal(),
    );
  }
}

class HalamanJadwal extends StatelessWidget {
  const HalamanJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Hari Ini')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian 1: kartu ringkasan. Tingginya secukupnya.
          KartuRingkasan(
            hari: 'Senin',
            jumlah: jadwalSenin.length,
            jamMulai: jadwalSenin.first.jam,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Urutan kuliah',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Bagian 2: daftar. Expanded berkata, "Pakai SEMUA sisa tinggi
          // layar." Tanpa Expanded, Column tidak memberi batas tinggi
          // dan ListView (yang panjangnya bisa tak terbatas) kebingungan.
          Expanded(
            child: ListView.builder(
              itemCount: jadwalSenin.length,
              itemBuilder: (BuildContext context, int index) {
                final JadwalKuliah jadwal = jadwalSenin[index];
                return ListTile(
                  leading: Text(
                    jadwal.jam,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(jadwal.mataKuliah),
                  subtitle: Text(jadwal.ruang),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KartuRingkasan extends StatelessWidget {
  const KartuRingkasan({
    super.key,
    required this.hari,
    required this.jumlah,
    required this.jamMulai,
  });

  final String hari;
  final int jumlah;
  final String jamMulai;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      color: warna.primaryContainer,
      child: ListTile(
        leading: Icon(Icons.event, color: warna.onPrimaryContainer),
        title: Text(
          hari,
          style: TextStyle(
            color: warna.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '$jumlah mata kuliah · mulai pukul $jamMulai',
          style: TextStyle(color: warna.onPrimaryContainer),
        ),
      ),
    );
  }
}
