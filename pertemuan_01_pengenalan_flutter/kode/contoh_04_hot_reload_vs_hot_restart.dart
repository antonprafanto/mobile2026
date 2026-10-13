// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 01: PENGENALAN FLUTTER
// CONTOH 04: Hot Reload vs Hot Restart
// Topik: Membuktikan hot reload MENJAGA data, hot restart MENGULANG.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini ke lib/main.dart.
// 2. Jalankan di terminal: flutter run -d chrome
// 3. Ikuti 3 langkah yang tertulis di layar aplikasi.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HalamanPenghitung()));
}

class HalamanPenghitung extends StatefulWidget {
  const HalamanPenghitung({super.key});

  @override
  State<HalamanPenghitung> createState() => _HalamanPenghitungState();
}

class _HalamanPenghitungState extends State<HalamanPenghitung> {
  // Data (state) yang sedang tersimpan di memori aplikasi.
  int _angka = 0;

  void _tambah() {
    // setState() memberi tahu Flutter: "data berubah, gambar ulang!"
    setState(() {
      _angka++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // LANGKAH 2: ganti Colors.amber menjadi Colors.lightGreen, lalu
        // SIMPAN (Ctrl+S). Jika dijalankan dari terminal, tekan juga r.
        backgroundColor: Colors.amber,
        title: const Text('Hot Reload vs Hot Restart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Langkah 1: tekan tombol + sampai angka 5'),
            Text('$_angka', style: Theme.of(context).textTheme.displayLarge),
            const Text('Langkah 3: tekan R (huruf besar) di terminal'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambah,
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// HASIL YANG DIHARAPKAN:
// - Setelah langkah 2 (hot reload): warna AppBar berubah, angka TETAP 5.
// - Setelah langkah 3 (hot restart): aplikasi mulai ulang, angka jadi 0.
