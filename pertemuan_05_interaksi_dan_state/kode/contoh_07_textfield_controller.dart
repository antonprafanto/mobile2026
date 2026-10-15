// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 07: TextField dan TextEditingController
// Topik: Membaca ketikan dengan onChanged dan TextEditingController,
//        menghias kolom dengan InputDecoration, mengosongkan kolom dari
//        kode, dan membuang controller di dispose().
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKartuUcapan());
}

class AplikasiKartuUcapan extends StatelessWidget {
  const AplikasiKartuUcapan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HalamanKartuUcapan(),
    );
  }
}

class HalamanKartuUcapan extends StatefulWidget {
  const HalamanKartuUcapan({super.key});

  @override
  State<HalamanKartuUcapan> createState() => _HalamanKartuUcapanState();
}

class _HalamanKartuUcapanState extends State<HalamanKartuUcapan> {
  // Controller = "remote" untuk sebuah TextField: bisa membaca, mengisi,
  // dan mengosongkan isinya dari kode.
  final TextEditingController _kontrolNama = TextEditingController();
  final TextEditingController _kontrolUcapan = TextEditingController();

  // Salinan ketikan untuk pratinjau, diperbarui lewat onChanged.
  String _nama = '';
  String _ucapan = '';

  @override
  void dispose() {
    // WAJIB: controller dibuang saat halaman ditutup agar memori tidak bocor.
    _kontrolNama.dispose();
    _kontrolUcapan.dispose();
    super.dispose();
  }

  void _kirim() {
    // Membaca isi kolom kapan saja lewat controller.text.
    final String nama = _kontrolNama.text.trim(); // trim = buang spasi tepi
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    if (nama.isEmpty) {
      pesan.showSnackBar(
        const SnackBar(content: Text('Isi nama teman dulu, ya.')),
      );
      return;
    }
    pesan.showSnackBar(SnackBar(content: Text('Kartu untuk $nama terkirim!')));

    // Mengosongkan kolom dari kode.
    _kontrolNama.clear();
    _kontrolUcapan.clear();
    // clear() TIDAK memanggil onChanged, jadi salinannya dikosongkan sendiri.
    setState(() {
      _nama = '';
      _ucapan = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Kartu Ucapan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            TextField(
              controller: _kontrolNama,
              textCapitalization: TextCapitalization.words, // Huruf Awal Besar
              textInputAction: TextInputAction.next, // tombol "lanjut"
              decoration: InputDecoration(
                labelText: 'Nama teman',
                hintText: 'misalnya Rina',
                prefixIcon: const Icon(Icons.person_outline),
                border: const OutlineInputBorder(),
                // Tombol hapus hanya muncul jika kolom berisi teks.
                // ExcludeFocus: tombol ini dilewati saat pengguna menekan
                // "lanjut" di keyboard, jadi fokus langsung pindah ke kolom
                // Ucapan.
                suffixIcon: _nama.isEmpty
                    ? null
                    : ExcludeFocus(
                        child: IconButton(
                          tooltip: 'Hapus nama',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _kontrolNama.clear();
                            setState(() {
                              _nama = '';
                            });
                          },
                        ),
                      ),
              ),
              // onChanged dipanggil setiap kali ketikan berubah.
              onChanged: (String teks) {
                setState(() {
                  _nama = teks;
                });
              },
              // Menutup keyboard saat pengguna mengetuk area lain.
              // primaryFocus = kolom yang sedang aktif (sedang diketik).
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            TextField(
              controller: _kontrolUcapan,
              maxLength: 80, // ada penghitung huruf di kanan bawah
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Ucapan',
                hintText: 'Tulis doa atau harapan',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              onChanged: (String teks) {
                setState(() {
                  _ucapan = teks;
                });
              },
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),

            // Pratinjau yang ikut berubah setiap kali Anda mengetik.
            Text('Pratinjau', style: gayaTeks.titleMedium),
            Card.filled(
              color: warna.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Icon(Icons.cake, size: 40, color: warna.onPrimaryContainer),
                    Text(
                      _nama.isEmpty ? 'Untuk: ...' : 'Untuk: $_nama',
                      style: gayaTeks.titleLarge?.copyWith(
                        color: warna.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      _ucapan.isEmpty ? 'Selamat ulang tahun!' : _ucapan,
                      style: TextStyle(color: warna.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: _kirim,
              icon: const Icon(Icons.send),
              label: const Text('Kirim Kartu'),
            ),
          ],
        ),
      ),
    );
  }
}
