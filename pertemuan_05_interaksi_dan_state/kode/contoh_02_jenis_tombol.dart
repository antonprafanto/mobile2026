// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 02: Jenis-Jenis Tombol
// Topik: Lima tombol Material 3 sesuai tingkat kepentingannya, tombol
//        ikon, tombol nonaktif, dan tombol yang bisa menyala-padam
//        (toggle).
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTombol());
}

class AplikasiTombol extends StatelessWidget {
  const AplikasiTombol({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanTombol(),
    );
  }
}

class HalamanTombol extends StatefulWidget {
  const HalamanTombol({super.key});

  @override
  State<HalamanTombol> createState() => _HalamanTombolState();
}

class _HalamanTombolState extends State<HalamanTombol> {
  // Nama tombol yang terakhir ditekan.
  String _terakhirDitekan = 'Belum ada';
  // Status tombol favorit: menyala (true) atau padam (false).
  bool _favorit = false;

  void _catat(String namaTombol) {
    setState(() {
      _terakhirDitekan = namaTombol;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Jenis-Jenis Tombol')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Card.filled(
              child: ListTile(
                leading: const Icon(Icons.touch_app),
                title: const Text('Terakhir ditekan'),
                subtitle: Text(_terakhirDitekan),
              ),
            ),

            // 1) Dari yang paling menonjol sampai yang paling ringan.
            Text('1) Lima tombol Material 3', style: gayaTeks.titleMedium),
            FilledButton(
              // Aksi UTAMA di halaman, misalnya membayar.
              onPressed: () => _catat('FilledButton'),
              child: const Text('Bayar Sekarang'),
            ),
            FilledButton.tonal(
              // Aksi penting, tetapi bukan yang paling utama.
              onPressed: () => _catat('FilledButton.tonal'),
              child: const Text('Tambah ke Keranjang'),
            ),
            ElevatedButton(
              // Punya bayangan; cocok di atas latar bergambar.
              onPressed: () => _catat('ElevatedButton'),
              child: const Text('Lihat Detail'),
            ),
            OutlinedButton(
              // Aksi kedua, misalnya pendamping tombol utama.
              onPressed: () => _catat('OutlinedButton'),
              child: const Text('Batal'),
            ),
            TextButton(
              // Aksi paling ringan, misalnya "Lewati" atau "Lupa sandi?".
              onPressed: () => _catat('TextButton'),
              child: const Text('Lewati'),
            ),

            // 2) Tombol yang memakai ikon.
            Text('2) Tombol dengan ikon', style: gayaTeks.titleMedium),
            FilledButton.icon(
              onPressed: () => _catat('FilledButton.icon'),
              icon: const Icon(Icons.send),
              label: const Text('Kirim Tugas'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // tooltip = keterangan saat ditekan lama atau disorot mouse.
                IconButton(
                  onPressed: () => _catat('IconButton'),
                  tooltip: 'Cari',
                  icon: const Icon(Icons.search),
                ),
                IconButton.filled(
                  onPressed: () => _catat('IconButton.filled'),
                  tooltip: 'Tambah',
                  icon: const Icon(Icons.add),
                ),
                IconButton.filledTonal(
                  onPressed: () => _catat('IconButton.filledTonal'),
                  tooltip: 'Bagikan',
                  icon: const Icon(Icons.share),
                ),
                IconButton.outlined(
                  onPressed: () => _catat('IconButton.outlined'),
                  tooltip: 'Ubah',
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),

            // 3) onPressed: null = tombol nonaktif.
            Text('3) Tombol nonaktif', style: gayaTeks.titleMedium),
            const FilledButton(
              onPressed: null,
              child: Text('Belum bisa ditekan'),
            ),

            // 4) Tombol yang menyimpan status menyala/padam.
            Text('4) Tombol toggle', style: gayaTeks.titleMedium),
            Row(
              children: [
                IconButton(
                  isSelected: _favorit,
                  tooltip: 'Favorit',
                  icon: const Icon(Icons.favorite_border), // saat padam
                  selectedIcon: const Icon(Icons.favorite), // saat menyala
                  onPressed: () {
                    setState(() {
                      _favorit = !_favorit; // balik: true <-> false
                    });
                  },
                ),
                Text(_favorit ? 'Disimpan ke favorit' : 'Belum jadi favorit'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
