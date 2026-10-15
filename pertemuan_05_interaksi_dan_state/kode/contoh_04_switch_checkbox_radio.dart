// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 05: INTERAKSI & STATE LOKAL
// CONTOH 04: Switch, Checkbox, dan Radio
// Topik: Pola "value + onChanged" pada SwitchListTile, CheckboxListTile,
//        dan RadioListTile di dalam RadioGroup, serta kontrol yang
//        nonaktif bergantung pada pilihan lain.
// =====================================================================
// CARA MENJALANKAN:
// 1. Salin seluruh isi berkas ini.
// 2. Tempelkan ke lib/main.dart (atau buka di https://dartpad.dev).
// 3. Jalankan di terminal: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPengaturan());
}

// Pilihan ukuran teks. Enum berproperti (Pertemuan 3).
enum UkuranTeks {
  kecil('Kecil', 0.85),
  sedang('Sedang', 1.0),
  besar('Besar', 1.25);

  const UkuranTeks(this.label, this.skala);

  final String label;
  final double skala;
}

class AplikasiPengaturan extends StatelessWidget {
  const AplikasiPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanPengaturan(),
    );
  }
}

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  bool _notifikasi = true;
  bool _hematData = false;
  bool _infoTugas = true;
  bool _infoNilai = true;
  bool _infoPengumuman = false;
  UkuranTeks _ukuran = UkuranTeks.sedang;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    // Daftar jenis pemberitahuan yang sedang dicentang.
    final List<String> jenisAktif = [
      if (_infoTugas) 'tugas',
      if (_infoNilai) 'nilai',
      if (_infoPengumuman) 'pengumuman',
    ];

    // Kalimat ringkasan yang disusun dari semua pilihan.
    final String ringkasan;
    if (!_notifikasi) {
      ringkasan = 'Notifikasi dimatikan.';
    } else if (jenisAktif.isEmpty) {
      ringkasan = 'Notifikasi aktif, tetapi belum ada jenis yang dipilih.';
    } else {
      ringkasan = 'Notifikasi aktif untuk: ${jenisAktif.join(', ')}.';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- 1) Switch: nyala/mati ----------
            SwitchListTile(
              secondary: const Icon(Icons.notifications_outlined),
              title: const Text('Notifikasi'),
              subtitle: const Text('Terima pemberitahuan dari kampus'),
              value: _notifikasi, // nilai yang SEDANG ditampilkan
              onChanged: (bool nilaiBaru) {
                // Flutter memberi tahu nilai baru; kita yang menyimpannya.
                setState(() {
                  _notifikasi = nilaiBaru;
                });
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.data_saver_on),
              title: const Text('Hemat data'),
              subtitle: const Text('Gambar dimuat dengan kualitas rendah'),
              value: _hematData,
              onChanged: (bool nilaiBaru) {
                setState(() {
                  _hematData = nilaiBaru;
                });
              },
            ),
            const Divider(),

            // ---------- 2) Checkbox: boleh pilih lebih dari satu ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text('Jenis pemberitahuan', style: gayaTeks.titleSmall),
            ),
            CheckboxListTile(
              title: const Text('Tugas baru'),
              value: _infoTugas,
              // Jika notifikasi mati, centang ikut nonaktif (onChanged: null).
              onChanged: _notifikasi
                  ? (bool? nilaiBaru) {
                      setState(() {
                        _infoTugas = nilaiBaru ?? false;
                      });
                    }
                  : null,
            ),
            CheckboxListTile(
              title: const Text('Nilai keluar'),
              value: _infoNilai,
              onChanged: _notifikasi
                  ? (bool? nilaiBaru) {
                      setState(() {
                        _infoNilai = nilaiBaru ?? false;
                      });
                    }
                  : null,
            ),
            CheckboxListTile(
              title: const Text('Pengumuman kampus'),
              value: _infoPengumuman,
              onChanged: _notifikasi
                  ? (bool? nilaiBaru) {
                      setState(() {
                        _infoPengumuman = nilaiBaru ?? false;
                      });
                    }
                  : null,
            ),
            const Divider(),

            // ---------- 3) Radio: hanya satu yang boleh dipilih ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text('Ukuran teks', style: gayaTeks.titleSmall),
            ),
            // RadioGroup membagikan nilai terpilih ke SEMUA Radio di bawahnya.
            RadioGroup<UkuranTeks>(
              groupValue: _ukuran,
              onChanged: (UkuranTeks? pilihan) {
                if (pilihan == null) return;
                setState(() {
                  _ukuran = pilihan;
                });
              },
              child: Column(
                children: [
                  for (UkuranTeks ukuran in UkuranTeks.values)
                    RadioListTile<UkuranTeks>(
                      value: ukuran, // nilai milik pilihan ini
                      title: Text(ukuran.label),
                    ),
                ],
              ),
            ),

            // ---------- Ringkasan: hasil semua pilihan ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card.filled(
                color: warna.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    ringkasan,
                    // Ukuran huruf mengikuti pilihan Radio di atas
                    // (16 = ukuran bawaan gaya bodyLarge).
                    style: gayaTeks.bodyLarge?.copyWith(
                      fontSize: 16 * _ukuran.skala,
                      color: warna.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
