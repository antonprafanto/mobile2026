// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 01: StatefulWidget dan setState
// Topik: Dua class pembentuk StatefulWidget, mengubah state dengan
//        setState(), membaca properti widget lewat widget.xxx, dan
//        menonaktifkan tombol dengan onPressed: null.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiMinumAir());
}

class AplikasiMinumAir extends StatelessWidget {
  const AplikasiMinumAir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      // Target 8 gelas dikirim dari luar, seperti parameter fungsi.
      home: const HalamanMinumAir(target: 8),
    );
  }
}

// ---------------------------------------------------------------------
// BAGIAN 1: class widget. Isinya hanya "pengaturan" yang TIDAK berubah
// selama halaman tampil. Semua propertinya final.
// ---------------------------------------------------------------------
class HalamanMinumAir extends StatefulWidget {
  const HalamanMinumAir({super.key, required this.target});

  final int target;

  // Flutter memanggil createState() untuk membuat "buku catatan" halaman.
  @override
  State<HalamanMinumAir> createState() => _HalamanMinumAirState();
}

// ---------------------------------------------------------------------
// BAGIAN 2: class State. Di sinilah data yang BERUBAH disimpan.
// Objek State tetap hidup walaupun build() dijalankan berkali-kali.
// ---------------------------------------------------------------------
class _HalamanMinumAirState extends State<HalamanMinumAir> {
  // State: jumlah gelas yang sudah diminum hari ini.
  int _gelas = 0;

  void _tambahGelas() {
    // setState() = "Flutter, datanya berubah. Tolong gambar ulang."
    setState(() {
      _gelas++;
    });
  }

  void _kurangiGelas() {
    setState(() {
      _gelas--;
    });
  }

  void _ulangiDariNol() {
    setState(() {
      _gelas = 0;
    });
  }

  // build() dijalankan ulang setiap kali setState() dipanggil.
  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // widget.target = cara State membaca properti milik class widget-nya.
    final bool tercapai = _gelas >= widget.target;
    // Progres bermakna 0 (kosong) sampai 1 (penuh).
    final double progres = tercapai ? 1 : _gelas / widget.target;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengingat Minum Air')),
      // Center + SingleChildScrollView: isi berada di tengah layar, dan
      // tetap bisa digulir jika layar pendek (misalnya ponsel dimiringkan).
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Icon(
                tercapai ? Icons.emoji_events : Icons.local_drink,
                size: 72,
                color: warna.primary,
              ),
              Text(
                '$_gelas / ${widget.target} gelas',
                style: gayaTeks.headlineMedium,
              ),
              LinearProgressIndicator(
                value: progres,
                minHeight: 12,
                borderRadius: BorderRadius.circular(6),
              ),
              Text(
                tercapai
                    ? 'Hebat! Target hari ini tercapai.'
                    : 'Ayo, ${widget.target - _gelas} gelas lagi.',
                textAlign: TextAlign.center,
              ),
              FilledButton.icon(
                onPressed: _tambahGelas, // nama fungsi, TANPA tanda ()
                icon: const Icon(Icons.add),
                label: const Text('Minum 1 gelas'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  // onPressed: null membuat tombol nonaktif (abu-abu).
                  OutlinedButton.icon(
                    onPressed: _gelas > 0 ? _kurangiGelas : null,
                    icon: const Icon(Icons.remove),
                    label: const Text('Batal 1'),
                  ),
                  TextButton(
                    onPressed: _gelas > 0 ? _ulangiDariNol : null,
                    child: const Text('Mulai dari nol'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
