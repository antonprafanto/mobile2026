// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 07: MATERIAL 3 & UI RESPONSIF
// CONTOH 08: Breakpoint Material 3 (Kelas Ukuran Jendela)
// Topik: Material 3 membagi lebar jendela menjadi lima kelas: ringkas
//        (< 600), sedang (600-839), lebar (840-1199), besar
//        (1200-1599), dan ekstra besar (>= 1600). Jumlah kolom dan
//        margin halaman dipilih berdasarkan kelasnya, dan lebar isi
//        dibatasi agar tidak terlalu melebar di layar besar.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome, lalu ubah lebar
//    jendela Chrome dan perhatikan jumlah kolomnya.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPengumuman());
}

class AplikasiPengumuman extends StatelessWidget {
  const AplikasiPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HalamanPengumuman(),
    );
  }
}

// ---------- Kelas ukuran jendela menurut Material 3 ----------
enum KelasUkuran {
  ringkas('Ringkas (compact)', kolom: 1, margin: 16),
  sedang('Sedang (medium)', kolom: 2, margin: 24),
  lebar('Lebar (expanded)', kolom: 3, margin: 24),
  besar('Besar (large)', kolom: 3, margin: 24),
  ekstraBesar('Ekstra besar (extra-large)', kolom: 4, margin: 24);

  const KelasUkuran(this.nama, {required this.kolom, required this.margin});

  final String nama;
  final int kolom; // jumlah kolom kartu
  final double margin; // jarak isi ke tepi jendela

  // Menentukan kelas dari lebar jendela (dalam piksel logis).
  static KelasUkuran dari(double lebar) {
    if (lebar < 600) {
      return KelasUkuran.ringkas;
    }
    if (lebar < 840) {
      return KelasUkuran.sedang;
    }
    if (lebar < 1200) {
      return KelasUkuran.lebar;
    }
    if (lebar < 1600) {
      return KelasUkuran.besar;
    }
    return KelasUkuran.ekstraBesar;
  }
}

// ---------- Data ----------
class Pengumuman {
  const Pengumuman(this.judul, this.isi, this.tanggal, this.ikon);

  final String judul;
  final String isi;
  final String tanggal;
  final IconData ikon;
}

const List<Pengumuman> daftarPengumuman = [
  Pengumuman(
    'Jadwal UTS terbit',
    'Jadwal ujian tengah semester sudah bisa dilihat di portal akademik.',
    '12 Okt',
    Icons.event_note,
  ),
  Pengumuman(
    'Batas pengisian KRS',
    'Pengisian KRS semester depan diperpanjang sampai hari Jumat.',
    '11 Okt',
    Icons.edit_calendar,
  ),
  Pengumuman(
    'Beasiswa prestasi',
    'Pendaftaran beasiswa prestasi dibuka untuk mahasiswa semester 3-7.',
    '10 Okt',
    Icons.school,
  ),
  Pengumuman(
    'Perbaikan Wi-Fi',
    'Jaringan Wi-Fi gedung C diperbaiki Sabtu pagi, mohon maklum.',
    '9 Okt',
    Icons.wifi_off,
  ),
  Pengumuman(
    'Kuliah tamu',
    'Kuliah tamu "Karier di Industri Aplikasi Mobile" di Aula Utama.',
    '8 Okt',
    Icons.record_voice_over,
  ),
  Pengumuman(
    'Lomba aplikasi',
    'Himpunan mengadakan lomba aplikasi antarangkatan, hadiah total 5 juta.',
    '7 Okt',
    Icons.emoji_events,
  ),
];

// ---------- Halaman ----------
class HalamanPengumuman extends StatelessWidget {
  const HalamanPengumuman({super.key});

  // Lebar isi paling besar. Di layar yang lebih lebar dari ini, isi
  // diletakkan di tengah supaya baris tulisan tidak terlalu panjang.
  static const double lebarIsiMaksimum = 1200;

  @override
  Widget build(BuildContext context) {
    // widthOf: hanya membangun ulang jika LEBAR jendela berubah.
    final double lebar = MediaQuery.widthOf(context);
    final KelasUkuran kelas = KelasUkuran.dari(lebar);

    return Scaffold(
      appBar: AppBar(title: const Text('Pengumuman Kampus')),
      body: Center(
        // Center + ConstrainedBox: isi tidak pernah lebih lebar dari 1200.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: lebarIsiMaksimum),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(kelas.margin, 16, kelas.margin, 8),
                child: InfoKelas(lebar: lebar, kelas: kelas),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(
                    kelas.margin,
                    8,
                    kelas.margin,
                    16,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kelas.kolom, // dari kelas ukuran
                    mainAxisExtent: 136, // tinggi tetap setiap kartu
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: daftarPengumuman.length,
                  itemBuilder: (BuildContext context, int index) {
                    return KartuPengumuman(pengumuman: daftarPengumuman[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoKelas extends StatelessWidget {
  const InfoKelas({super.key, required this.lebar, required this.kelas});

  final double lebar;
  final KelasUkuran kelas;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warna.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Lebar jendela ${lebar.toStringAsFixed(0)} → ${kelas.nama}\n'
        '${kelas.kolom} kolom · margin ${kelas.margin.toStringAsFixed(0)}',
        style: gayaTeks.titleSmall?.copyWith(color: warna.onTertiaryContainer),
      ),
    );
  }
}

class KartuPengumuman extends StatelessWidget {
  const KartuPengumuman({super.key, required this.pengumuman});

  final Pengumuman pengumuman;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero, // jarak antarkartu sudah diatur grid
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: warna.primaryContainer,
              child: Icon(pengumuman.ikon, color: warna.onPrimaryContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengumuman.judul,
                    style: gayaTeks.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pengumuman.isi,
                    style: gayaTeks.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pengumuman.tanggal,
                    style: gayaTeks.labelSmall?.copyWith(
                      color: warna.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
