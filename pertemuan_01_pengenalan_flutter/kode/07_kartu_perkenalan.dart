// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 07: Kartu Perkenalan (Hasil Akhir Langkah Terbimbing Jobsheet)
// Topik: Menyusun beberapa widget siap pakai menjadi satu halaman profil.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiProfil());
}

class AplikasiProfil extends StatelessWidget {
  const AplikasiProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanProfil(),
    );
  }
}

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Kartu Perkenalan')),
      // ListView = daftar yang bisa digulir, aman untuk layar HP yang kecil.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 12),
          Text(
            'Nama Lengkap Anda',
            textAlign: TextAlign.center,
            style: gayaTeks.headlineSmall,
          ),
          const Text('NIM 2026000000', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          // Card = kartu bawaan Material 3; ListTile = satu baris info rapi.
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Program Studi'),
                  subtitle: Text('Informatika'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text('nama@mahasiswa.kampus.ac.id'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Hobi'),
                  subtitle: Text('Membuat aplikasi mobile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
