// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 06: DAFTAR DATA & NAVIGASI
// CONTOH 05: Geser untuk Menghapus (Dismissible) dan Tombol Urungkan
// Topik: Item daftar dihapus dengan menggesernya ke kiri. Setiap item
//        wajib punya Key unik agar Flutter tidak tertukar baris.
//        Barang yang terhapus dan posisinya dicatat lebih dulu,
//        supaya bisa dikembalikan lewat tombol "Urungkan".
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// 4. Di browser, geser item dengan menahan klik kiri lalu menarik
//    mouse ke kiri.
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTugas());
}

class Tugas {
  const Tugas(this.id, this.judul, this.mataKuliah);

  // id: nomor unik yang TIDAK pernah berubah, dipakai sebagai Key.
  final int id;
  final String judul;
  final String mataKuliah;
}

class AplikasiTugas extends StatelessWidget {
  const AplikasiTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanTugas(),
    );
  }
}

class HalamanTugas extends StatefulWidget {
  const HalamanTugas({super.key});

  @override
  State<HalamanTugas> createState() => _HalamanTugasState();
}

class _HalamanTugasState extends State<HalamanTugas> {
  // Daftar ini bisa berubah (dihapus/dikembalikan), jadi disimpan di
  // State dan TIDAK ditulis const.
  final List<Tugas> _daftar = [
    const Tugas(1, 'Laporan praktikum 5', 'Pemrograman Piranti Bergerak'),
    const Tugas(2, 'Rancangan ERD', 'Basis Data'),
    const Tugas(3, 'Ringkasan bab 3', 'Jaringan Komputer'),
    const Tugas(4, 'Latihan soal regresi', 'Statistika'),
    const Tugas(5, 'Proposal usaha', 'Kewirausahaan'),
  ];

  void _hapus(int indeks) {
    // Catat DULU barang dan posisinya, baru dihapus.
    final Tugas terhapus = _daftar[indeks];
    setState(() {
      _daftar.removeAt(indeks);
    });

    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(
        content: Text('"${terhapus.judul}" dihapus.'),
        action: SnackBarAction(
          label: 'Urungkan',
          onPressed: () {
            // Kembalikan ke posisi semula, bukan ke ujung daftar.
            setState(() {
              _daftar.insert(indeks, terhapus);
            });
          },
        ),
        // Tanpa ini, SnackBar bertombol tidak hilang sendiri.
        persist: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Tugas Saya (${_daftar.length})')),
      // Daftar kosong? Tampilkan pesan yang ramah, bukan layar kosong.
      body: _daftar.isEmpty
          ? const TampilanKosong()
          : ListView.builder(
              itemCount: _daftar.length,
              itemBuilder: (BuildContext context, int index) {
                final Tugas tugas = _daftar[index];
                return Dismissible(
                  // Key unik dari data, BUKAN dari index. Index berubah
                  // setiap kali ada item yang dihapus, sedangkan id tidak.
                  key: ValueKey<int>(tugas.id),
                  direction: DismissDirection.endToStart, // geser ke kiri
                  // Latar yang tampak di belakang item saat digeser.
                  background: Container(
                    color: warna.errorContainer,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(Icons.delete, color: warna.onErrorContainer),
                  ),
                  onDismissed: (DismissDirection arah) {
                    _hapus(index);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.assignment),
                    title: Text(tugas.judul),
                    subtitle: Text(tugas.mataKuliah),
                  ),
                );
              },
            ),
    );
  }
}

class TampilanKosong extends StatelessWidget {
  const TampilanKosong({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.celebration, size: 64, color: warna.primary),
            const SizedBox(height: 12),
            const Text(
              'Semua tugas beres!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tidak ada tugas yang tersisa.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
