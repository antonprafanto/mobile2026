// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 07: Navigator, Tumpukan Halaman (push dan pop)
// Topik: Navigator menyimpan halaman seperti tumpukan piring.
//        push = menaruh halaman baru di atas, pop = mengambil halaman
//        teratas. Tombol panah kembali di AppBar muncul otomatis
//        selama masih ada halaman di bawahnya.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTumpukan());
}

class AplikasiTumpukan extends StatelessWidget {
  const AplikasiTumpukan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      // Halaman pertama = piring paling bawah.
      home: const HalamanTumpukan(nomor: 1),
    );
  }
}

class HalamanTumpukan extends StatelessWidget {
  const HalamanTumpukan({super.key, required this.nomor});

  // Posisi halaman ini di dalam tumpukan (1 = paling bawah).
  final int nomor;

  void _tumpukHalamanBaru(BuildContext context) {
    // push: taruh halaman baru di ATAS halaman ini.
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => HalamanTumpukan(nomor: nomor + 1),
      ),
    );
  }

  void _kembaliSatu(BuildContext context) {
    // pop: ambil halaman teratas (halaman ini) dari tumpukan.
    Navigator.pop(context);
  }

  void _kembaliKePertama(BuildContext context) {
    // popUntil: terus mengambil halaman sampai tersisa yang pertama.
    Navigator.popUntil(context, (Route<dynamic> rute) => rute.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final bool adaDiBawah = nomor > 1;

    return Scaffold(
      appBar: AppBar(title: Text('Halaman $nomor')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Isi tumpukan saat ini (teratas di atas):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Gambar tumpukan: dari halaman ini turun sampai Halaman 1.
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: nomor,
              itemBuilder: (BuildContext context, int index) {
                final int nomorPiring = nomor - index;
                return PiringHalaman(
                  nomor: nomorPiring,
                  teratas: nomorPiring == nomor,
                );
              },
            ),
          ),
          // Tombol-tombol aksi di bagian bawah.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _tumpukHalamanBaru(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Tumpuk halaman baru'),
                ),
                OutlinedButton.icon(
                  // Halaman 1 tidak boleh di-pop: tombol dinonaktifkan.
                  onPressed: adaDiBawah ? () => _kembaliSatu(context) : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali satu halaman'),
                ),
                TextButton(
                  onPressed: adaDiBawah
                      ? () => _kembaliKePertama(context)
                      : null,
                  child: const Text('Kembali ke Halaman 1'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Satu "piring" di dalam gambar tumpukan.
class PiringHalaman extends StatelessWidget {
  const PiringHalaman({super.key, required this.nomor, required this.teratas});

  final int nomor;
  final bool teratas;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      color: teratas ? warna.primaryContainer : warna.surfaceContainerHighest,
      child: ListTile(
        leading: Icon(teratas ? Icons.visibility : Icons.layers),
        title: Text('Halaman $nomor'),
        subtitle: Text(
          teratas ? 'Sedang tampil di layar' : 'Menunggu di bawah',
        ),
      ),
    );
  }
}
