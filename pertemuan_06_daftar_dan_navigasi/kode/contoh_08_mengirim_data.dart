// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 08: Mengirim Data ke Halaman Tujuan
// Topik: Item yang diketuk di halaman daftar dikirim ke halaman detail
//        lewat constructor, persis seperti mengirim parameter ke widget
//        biasa. Halaman detail cukup StatelessWidget karena hanya
//        menampilkan data yang diterimanya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPetaKampus());
}

class Gedung {
  const Gedung({
    required this.nama,
    required this.kode,
    required this.jamBuka,
    required this.fasilitas,
    required this.ikon,
  });

  final String nama;
  final String kode;
  final String jamBuka;
  final List<String> fasilitas;
  final IconData ikon;
}

const List<Gedung> daftarGedung = [
  Gedung(
    nama: 'Perpustakaan Pusat',
    kode: 'Gedung A',
    jamBuka: '07.30–21.00',
    fasilitas: ['Ruang baca', 'Wi-Fi', 'Loker', 'Ruang diskusi'],
    ikon: Icons.local_library,
  ),
  Gedung(
    nama: 'Laboratorium Komputer',
    kode: 'Gedung B',
    jamBuka: '08.00–17.00',
    fasilitas: ['60 komputer', 'Proyektor', 'Pendingin ruangan'],
    ikon: Icons.computer,
  ),
  Gedung(
    nama: 'Kantin Utama',
    kode: 'Gedung C',
    jamBuka: '06.30–19.00',
    fasilitas: ['12 kedai', 'Musala', 'Tempat cuci tangan'],
    ikon: Icons.restaurant,
  ),
  Gedung(
    nama: 'Pusat Layanan Mahasiswa',
    kode: 'Gedung D',
    jamBuka: '08.00–15.00',
    fasilitas: ['Loket akademik', 'Konseling', 'Informasi beasiswa'],
    ikon: Icons.support_agent,
  ),
  Gedung(
    nama: 'Gelanggang Olahraga',
    kode: 'Gedung E',
    jamBuka: '06.00–22.00',
    fasilitas: ['Lapangan futsal', 'Lapangan bulu tangkis', 'Ruang ganti'],
    ikon: Icons.sports_basketball,
  ),
];

class AplikasiPetaKampus extends StatelessWidget {
  const AplikasiPetaKampus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanDaftarGedung(),
    );
  }
}

// ---------- Halaman 1: daftar gedung ----------
class HalamanDaftarGedung extends StatelessWidget {
  const HalamanDaftarGedung({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gedung di Kampus')),
      body: ListView.builder(
        itemCount: daftarGedung.length,
        itemBuilder: (BuildContext context, int index) {
          final Gedung gedung = daftarGedung[index];
          return ListTile(
            leading: Icon(gedung.ikon),
            title: Text(gedung.nama),
            subtitle: Text(gedung.kode),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Kirim objek gedung yang diketuk lewat constructor.
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return HalamanDetailGedung(gedung: gedung);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ---------- Halaman 2: detail SATU gedung ----------
class HalamanDetailGedung extends StatelessWidget {
  const HalamanDetailGedung({super.key, required this.gedung});

  // Data yang dikirim dari halaman daftar.
  final Gedung gedung;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(gedung.nama)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: warna.primaryContainer,
            child: Icon(gedung.ikon, size: 40, color: warna.onPrimaryContainer),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.place),
                  title: const Text('Lokasi'),
                  subtitle: Text(gedung.kode),
                ),
                ListTile(
                  leading: const Icon(Icons.schedule),
                  title: const Text('Jam buka'),
                  subtitle: Text(gedung.jamBuka),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Fasilitas',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final String fasilitas in gedung.fasilitas)
                Chip(label: Text(fasilitas)),
            ],
          ),
        ],
      ),
    );
  }
}
