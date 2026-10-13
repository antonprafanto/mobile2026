// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 04: WIDGET & TATA LETAK
// CONTOH 09: Card dan ListTile
// Topik: Baris informasi siap pakai (leading, title, subtitle, trailing)
//        yang sangat sering dipakai di aplikasi sungguhan.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiListTile());
}

class AplikasiListTile extends StatelessWidget {
  const AplikasiListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const HalamanListTile(),
    );
  }
}

class HalamanListTile extends StatelessWidget {
  const HalamanListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Card dan ListTile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            // ListTile punya empat "slot": leading (kiri), title (judul),
            // subtitle (keterangan), dan trailing (kanan).
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.menu_book)),
                title: const Text('Pemrograman Piranti Bergerak'),
                subtitle: const Text('Senin, 08.00-10.30 · Lab 2'),
                trailing: Icon(Icons.chevron_right, color: warna.outline),
              ),
            ),
            const Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.storage)),
                title: Text('Basis Data Lanjut'),
                subtitle: Text('Selasa, 10.30-13.00 · Ruang 304'),
                trailing: Text('3 SKS'),
              ),
            ),
            // Beberapa ListTile dalam satu Card, dipisah Divider.
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('rina@mahasiswa.kampus.ac.id'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Telepon'),
                    subtitle: Text('0812-0000-0000'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Alamat'),
                    subtitle: Text('Jl. Kampus Hijau No. 1, Samarinda'),
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
