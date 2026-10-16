// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 01: Kode Kusut: Semua Pekerjaan di Satu Widget (JANGAN DITIRU)
// Topik: Aplikasi kecil "Pinjam Ruang" ini BERJALAN, tetapi seluruh
//        pekerjaannya ditumpuk di satu State: mengambil data dari
//        internet, membaca JSON, memeriksa aturan bisnis, menyimpan
//        peminjaman, dan menggambar layar. Komentar bertanda MASALAH 1
//        sampai MASALAH 6 menunjukkan bagian yang dirapikan sepanjang
//        modul ini. Bandingkan dengan Contoh 08 (versi yang tertata).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add http`, salin
//    seluruh isi berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome --web-port=8080
// =====================================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'Pinjam Ruang (kusut)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HalamanPinjamRuang(),
    ),
  );
}

class HalamanPinjamRuang extends StatefulWidget {
  const HalamanPinjamRuang({super.key});

  @override
  State<HalamanPinjamRuang> createState() => _HalamanPinjamRuangState();
}

class _HalamanPinjamRuangState extends State<HalamanPinjamRuang> {
  // MASALAH 5: data disimpan di State halaman ini. Halaman lain tidak
  // bisa memakainya, dan semuanya hilang begitu halaman ditutup.
  List<Map<String, dynamic>> _ruang = [];
  final List<String> _pinjamanSaya = [];
  bool _memuat = true;
  String? _galat;

  @override
  void initState() {
    super.initState();
    _ambilRuang();
  }

  Future<void> _ambilRuang() async {
    try {
      // MASALAH 1: alamat server dan urusan HTTP ditulis di widget.
      // Jika server pindah, berkas tampilan ini ikut diubah.
      final http.Response respons = await http.get(
        Uri.parse(
          'https://raw.githubusercontent.com/antonprafanto/mobile2026/main/'
          'pertemuan_12_clean_architecture/data/ruang_kampus.json',
        ),
      );
      // MASALAH 2: JSON dibaca dengan "as" di sini. Jika server
      // mengganti nama kolom, aplikasi gagal di tengah tampilan.
      final Map<String, dynamic> json =
          jsonDecode(respons.body) as Map<String, dynamic>;
      final List<dynamic> rooms = json['rooms'] as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _ruang = [
          for (final dynamic r in rooms)
            if (r['is_active'] == true) r as Map<String, dynamic>,
        ];
        _memuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        // MASALAH 6: pesan teknis langsung diperlihatkan ke pengguna.
        _galat = 'Error: $e';
        _memuat = false;
      });
    }
  }

  // MASALAH 3: aturan bisnis ditulis di dalam penanganan tombol.
  // Satu-satunya cara mengujinya adalah menekan tombol ini.
  void _pinjam(Map<String, dynamic> ruang) {
    // MASALAH 4: jam diambil langsung dari DateTime.now(). Hasilnya
    // berbeda setiap kali dijalankan, sehingga sulit diuji.
    final DateTime besok = DateTime.now().add(const Duration(days: 1));
    final String pesan;
    if (besok.weekday > DateTime.friday) {
      pesan = 'Ditolak: ruang hanya bisa dipinjam Senin sampai Jumat.';
    } else if (_pinjamanSaya.length >= 2) {
      pesan = 'Ditolak: paling banyak 2 peminjaman.';
    } else {
      _pinjamanSaya.add('${ruang['room_code']} besok 09.00-11.00');
      pesan = 'Berhasil meminjam ${ruang['room_name']}.';
    }
    setState(() {});
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjam Ruang (${_pinjamanSaya.length} dipinjam)'),
      ),
      body: _memuat
          ? const Center(child: CircularProgressIndicator())
          : _galat != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(_galat!),
              ),
            )
          : ListView(
              children: [
                for (final Map<String, dynamic> r in _ruang)
                  ListTile(
                    leading: const Icon(Icons.meeting_room_outlined),
                    title: Text(r['room_name'] as String),
                    subtitle: Text(
                      '${r['room_code']} · kapasitas ${r['capacity']}',
                    ),
                    trailing: FilledButton.tonal(
                      onPressed: () => _pinjam(r),
                      child: const Text('Pinjam'),
                    ),
                  ),
              ],
            ),
    );
  }
}
