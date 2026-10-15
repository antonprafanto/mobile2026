// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 02: Class Model dan ListView.separated
// Topik: Data disimpan sebagai List berisi objek (class model), lalu
//        setiap objek "diterjemahkan" menjadi satu ListTile.
//        ListView.separated menyisipkan garis pemisah di antara baris.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPerpustakaan());
}

// ---------- 1) Class model: cetakan untuk satu buku ----------
class Buku {
  const Buku({
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.tersedia,
  });

  final String judul;
  final String penulis;
  final int tahun;
  final bool tersedia;
}

// ---------- 2) Data: List berisi objek Buku ----------
// Nama buku dan penulis di bawah ini fiktif, hanya untuk latihan.
const List<Buku> daftarBuku = [
  Buku(
    judul: 'Belajar Flutter dari Nol',
    penulis: 'Rina Kusuma',
    tahun: 2025,
    tersedia: true,
  ),
  Buku(
    judul: 'Algoritma untuk Pemula',
    penulis: 'Bayu Pratama',
    tahun: 2021,
    tersedia: false,
  ),
  Buku(
    judul: 'Basis Data Terapan',
    penulis: 'Sari Wulandari',
    tahun: 2023,
    tersedia: true,
  ),
  Buku(
    judul: 'Jaringan Komputer Praktis',
    penulis: 'Dimas Saputra',
    tahun: 2022,
    tersedia: true,
  ),
  Buku(
    judul: 'Desain Antarmuka yang Ramah',
    penulis: 'Putri Maharani',
    tahun: 2024,
    tersedia: false,
  ),
  Buku(
    judul: 'Statistika Tanpa Takut',
    penulis: 'Agus Salim',
    tahun: 2020,
    tersedia: true,
  ),
  Buku(
    judul: 'Kecerdasan Buatan Sehari-hari',
    penulis: 'Nadia Putri',
    tahun: 2026,
    tersedia: true,
  ),
];

class AplikasiPerpustakaan extends StatelessWidget {
  const AplikasiPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HalamanRakBuku(),
    );
  }
}

class HalamanRakBuku extends StatelessWidget {
  const HalamanRakBuku({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rak Buku (${daftarBuku.length} judul)')),
      body: ListView.separated(
        itemCount: daftarBuku.length,
        // separatorBuilder: dibuat DI ANTARA dua baris. Untuk 7 buku
        // ada 6 garis pemisah.
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
        itemBuilder: (BuildContext context, int index) {
          // Ambil SATU objek sesuai nomor baris, lalu serahkan ke
          // widget kecil yang tugasnya menggambar satu buku.
          final Buku buku = daftarBuku[index];
          return BarisBuku(buku: buku);
        },
      ),
    );
  }
}

// ---------- 3) Widget kecil untuk menggambar SATU buku ----------
class BarisBuku extends StatelessWidget {
  const BarisBuku({super.key, required this.buku});

  final Buku buku;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(Icons.menu_book, color: warna.primary),
      title: Text(buku.judul),
      subtitle: Text('${buku.penulis} · ${buku.tahun}'),
      // Tampilan bergantung pada data: tersedia atau sedang dipinjam.
      trailing: Text(
        buku.tersedia ? 'Tersedia' : 'Dipinjam',
        style: TextStyle(
          color: buku.tersedia ? warna.primary : warna.error,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
