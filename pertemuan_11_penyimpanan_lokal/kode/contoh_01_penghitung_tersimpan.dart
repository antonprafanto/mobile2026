// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 01: Penghitung Tamu yang Tidak Lupa (SharedPreferencesAsync)
// Topik: Penghitung tamu seminar. Setiap kali angkanya berubah, nilainya
//        disimpan ke penyimpanan perangkat dengan paket shared_preferences.
//        Saat aplikasi dibuka lagi, angka terakhir dibaca kembali.
//        - getInt / getString : membaca (hasilnya null jika kunci itu
//                               belum pernah disimpan);
//        - setInt / setString : menyimpan;
//        - remove             : menghapus satu kunci.
//        Coba tambah beberapa tamu, lalu lakukan hot restart (tekan R di
//        terminal). Angkanya tetap ada, padahal semua variabel di memori
//        sudah dibuat ulang dari awal.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add shared_preferences` sekali.
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome --web-port=8080
//    Port yang tetap (8080) membuat data tetap terbaca walaupun aplikasi
//    dihentikan lalu dijalankan lagi (penjelasan: modul Bagian 2.4).
// =====================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const AplikasiPenghitung());
}

class AplikasiPenghitung extends StatelessWidget {
  const AplikasiPenghitung({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penghitung Tamu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanPenghitung(),
    );
  }
}

class HalamanPenghitung extends StatefulWidget {
  const HalamanPenghitung({super.key});

  @override
  State<HalamanPenghitung> createState() => _HalamanPenghitungState();
}

class _HalamanPenghitungState extends State<HalamanPenghitung> {
  // Kunci = "label laci" tempat sebuah nilai disimpan. Ditulis sekali
  // sebagai konstanta agar tidak salah ketik di tempat lain.
  static const String _kunciJumlah = 'jumlah_tamu';
  static const String _kunciWaktu = 'terakhir_diubah';

  // Objek untuk membaca dan menulis. Semua metodenya asinkron
  // (mengembalikan Future), karena penyimpanan perangkat butuh waktu.
  final SharedPreferencesAsync _penyimpanan = SharedPreferencesAsync();

  int _jumlah = 0;
  DateTime? _terakhirDiubah;
  bool _memuat = true;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  // Dipanggil sekali saat halaman dibuat: baca nilai yang tersimpan.
  Future<void> _muat() async {
    final int? jumlah = await _penyimpanan.getInt(_kunciJumlah);
    final String? waktu = await _penyimpanan.getString(_kunciWaktu);
    if (!mounted) {
      return;
    }
    setState(() {
      // null artinya kunci itu belum pernah disimpan (aplikasi baru).
      _jumlah = jumlah ?? 0;
      _terakhirDiubah = waktu == null ? null : DateTime.tryParse(waktu);
      _memuat = false;
    });
  }

  Future<void> _ubah(int selisih) async {
    final DateTime sekarang = DateTime.now();
    setState(() {
      _jumlah += selisih;
      _terakhirDiubah = sekarang;
    });
    // Tampilan diubah lebih dulu agar terasa cepat, baru kemudian disimpan.
    await _penyimpanan.setInt(_kunciJumlah, _jumlah);
    // DateTime tidak bisa disimpan langsung, jadi diubah menjadi teks
    // (format ISO 8601, misalnya 2026-10-15T08:15:30.000).
    await _penyimpanan.setString(_kunciWaktu, sekarang.toIso8601String());
  }

  Future<void> _mulaiDariNol() async {
    final bool? yakin = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Mulai dari nol?'),
        content: const Text('Jumlah tamu yang tersimpan akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (yakin != true || !mounted) {
      return;
    }
    setState(() {
      _jumlah = 0;
      _terakhirDiubah = null;
    });
    // remove: kunci dihapus seluruhnya, sehingga getInt kembali null.
    await _penyimpanan.remove(_kunciJumlah);
    await _penyimpanan.remove(_kunciWaktu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penghitung Tamu Seminar'),
        actions: [
          IconButton(
            onPressed: _memuat || _jumlah == 0 ? null : _mulaiDariNol,
            tooltip: 'Mulai dari nol',
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: _memuat
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                KartuJumlah(jumlah: _jumlah, terakhirDiubah: _terakhirDiubah),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => _ubah(1),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Tamu datang (+1)'),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _jumlah == 0 ? null : () => _ubah(-1),
                  icon: const Icon(Icons.person_remove),
                  label: const Text('Salah hitung (-1)'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Coba tekan R di terminal (hot restart). Semua variabel '
                  'dibuat ulang, tetapi angkanya tetap ada karena sudah '
                  'tersimpan di perangkat.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

// Contoh hasil: 15/10/2026 08.15
String formatWaktu(DateTime waktu) {
  return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)}/${waktu.year} '
      '${duaDigit(waktu.hour)}.${duaDigit(waktu.minute)}';
}

class KartuJumlah extends StatelessWidget {
  const KartuJumlah({
    super.key,
    required this.jumlah,
    required this.terakhirDiubah,
  });

  final int jumlah;
  final DateTime? terakhirDiubah;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final DateTime? waktu = terakhirDiubah;

    return Card.filled(
      color: warna.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '$jumlah',
              style: gayaTeks.displayLarge?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            Text(
              'tamu sudah hadir',
              style: gayaTeks.titleMedium?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              waktu == null
                  ? 'Belum ada yang dicatat'
                  : 'Terakhir diubah ${formatWaktu(waktu)}',
              style: gayaTeks.bodySmall?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
