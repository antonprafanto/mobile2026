// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 03: Sentuhan dan SnackBar
// Topik: Membuat area apa saja bisa disentuh (InkWell dan
//        GestureDetector), lalu memberi umpan balik dengan SnackBar,
//        termasuk tombol "Batalkan".
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSentuhan());
}

class AplikasiSentuhan extends StatelessWidget {
  const AplikasiSentuhan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HalamanSentuhan(),
    );
  }
}

class HalamanSentuhan extends StatefulWidget {
  const HalamanSentuhan({super.key});

  @override
  State<HalamanSentuhan> createState() => _HalamanSentuhanState();
}

class _HalamanSentuhanState extends State<HalamanSentuhan> {
  int _jumlahKetukan = 0;
  bool _disukai = false;
  bool _adaPengumuman = true;

  // Menampilkan pesan singkat di bagian bawah layar.
  void _tampilkanPesan(String teks) {
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar(); // tutup pesan lama agar tidak antre
    pesan.showSnackBar(SnackBar(content: Text(teks)));
  }

  void _hapusPengumuman() {
    setState(() {
      _adaPengumuman = false;
    });
    final ScaffoldMessengerState pesan = ScaffoldMessenger.of(context);
    pesan.hideCurrentSnackBar();
    pesan.showSnackBar(
      SnackBar(
        content: const Text('Pengumuman dihapus.'),
        // Tombol aksi di dalam SnackBar.
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () {
            setState(() {
              _adaPengumuman = true;
            });
          },
        ),
        // SnackBar yang punya tombol aksi tidak hilang sendiri.
        // persist: false membuatnya hilang otomatis setelah ±4 detik.
        persist: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sentuhan & SnackBar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            // 1) InkWell: memberi efek riak (ripple) saat disentuh.
            Text('1) InkWell', style: gayaTeks.titleMedium),
            Card(
              // Agar riak terpotong rapi mengikuti sudut kartu.
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _jumlahKetukan++;
                  });
                },
                onLongPress: () => _tampilkanPesan('Kartu ditekan lama.'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.touch_app, size: 40, color: warna.primary),
                      Expanded(
                        child: Text(
                          'Kartu ini sudah diketuk $_jumlahKetukan kali. '
                          'Tekan lama untuk memunculkan SnackBar.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2) GestureDetector: mengenali gerakan lain, tanpa efek riak.
            Text('2) GestureDetector', style: gayaTeks.titleMedium),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _disukai = !_disukai;
                });
              },
              child: Container(
                height: 140,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: warna.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _disukai ? Icons.favorite : Icons.favorite_border,
                  size: 64,
                  color: _disukai ? warna.error : warna.onSecondaryContainer,
                ),
              ),
            ),
            Text(
              _disukai
                  ? 'Anda menyukai foto ini.'
                  : 'Ketuk DUA KALI kotak di atas untuk menyukai.',
              textAlign: TextAlign.center,
            ),

            // 3) SnackBar dengan tombol "Batalkan".
            Text('3) SnackBar + Batalkan', style: gayaTeks.titleMedium),
            if (_adaPengumuman)
              Card.outlined(
                child: ListTile(
                  leading: const Icon(Icons.campaign),
                  title: const Text('Pengumuman'),
                  subtitle: const Text('Kuis minggu ini pindah ke hari Jumat.'),
                  trailing: IconButton(
                    tooltip: 'Hapus',
                    onPressed: _hapusPengumuman,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
              )
            else
              const Text(
                'Tidak ada pengumuman. Tekan "Batalkan" di SnackBar '
                'untuk mengembalikannya.',
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
