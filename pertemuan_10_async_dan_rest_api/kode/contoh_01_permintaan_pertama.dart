// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 01: Permintaan HTTP Pertama: Kutipan Acak dari Internet
// Topik: Aplikasi meminta data ke REST API https://dummyjson.com dengan
//        paket http. Alurnya:
//        1. http.get(...) mengirim permintaan dan MENUNGGU jawaban
//           (await), tanpa membuat aplikasi membeku;
//        2. jawaban server berisi KODE STATUS (200 = berhasil) dan BODY
//           berupa teks JSON;
//        3. jsonDecode() mengubah teks JSON menjadi Map;
//        4. setState() menampilkan hasilnya.
//        Selama menunggu, tampil lingkaran memuat. Buka konsol untuk
//        melihat teks JSON mentah yang dikirim server.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http` sekali.
//    (DartPad sudah menyediakan paket http.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AplikasiKutipan());
}

class AplikasiKutipan extends StatelessWidget {
  const AplikasiKutipan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kutipan Acak',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanKutipan(),
    );
  }
}

class HalamanKutipan extends StatefulWidget {
  const HalamanKutipan({super.key});

  @override
  State<HalamanKutipan> createState() => _HalamanKutipanState();
}

class _HalamanKutipanState extends State<HalamanKutipan> {
  bool _memuat = false;
  String? _kutipan;
  String? _penulis;
  String? _galat;

  @override
  void initState() {
    super.initState();
    _ambilKutipan(); // langsung mengambil satu kutipan saat halaman dibuka
  }

  Future<void> _ambilKutipan() async {
    setState(() {
      _memuat = true;
      _galat = null;
    });

    try {
      // 1. Kirim permintaan GET, lalu TUNGGU jawabannya.
      final http.Response respons = await http.get(
        Uri.parse('https://dummyjson.com/quotes/random'),
        headers: {'Accept': 'application/json'},
      );

      // Selama menunggu, halaman bisa saja sudah ditutup (Pertemuan 5).
      if (!mounted) return;

      // 2. Lihat isi jawaban di konsol.
      debugPrint('Kode status: ${respons.statusCode}');
      debugPrint('Body mentah: ${respons.body}');

      if (respons.statusCode == 200) {
        // 3. Teks JSON -> Map.
        final Map<String, dynamic> json =
            jsonDecode(respons.body) as Map<String, dynamic>;
        // 4. Tampilkan.
        setState(() {
          _kutipan = json['quote'] as String;
          _penulis = json['author'] as String;
          _memuat = false;
        });
      } else {
        setState(() {
          _galat = 'Server menjawab dengan kode ${respons.statusCode}.';
          _memuat = false;
        });
      }
    } catch (galat) {
      // Masuk ke sini jika tidak ada jawaban sama sekali, misalnya
      // karena tidak ada koneksi internet.
      debugPrint('Galat: $galat');
      if (!mounted) return;
      setState(() {
        _galat = 'Tidak dapat terhubung ke server. Periksa koneksi Anda.';
        _memuat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kutipan Acak')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IsiKutipan(
                memuat: _memuat,
                kutipan: _kutipan,
                penulis: _penulis,
                galat: _galat,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                // Nonaktif selama memuat, agar tidak mengirim dua permintaan
                // sekaligus.
                onPressed: _memuat ? null : _ambilKutipan,
                icon: const Icon(Icons.refresh),
                label: const Text('Kutipan lain'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IsiKutipan extends StatelessWidget {
  const _IsiKutipan({
    required this.memuat,
    required this.kutipan,
    required this.penulis,
    required this.galat,
  });

  final bool memuat;
  final String? kutipan;
  final String? penulis;
  final String? galat;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    if (memuat) {
      return const Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Mengambil kutipan dari internet...'),
        ],
      );
    }
    if (galat != null) {
      return Column(
        children: [
          Icon(Icons.wifi_off, size: 48, color: warna.error),
          const SizedBox(height: 12),
          Text(galat!, textAlign: TextAlign.center),
        ],
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote, size: 36, color: warna.primary),
            const SizedBox(height: 8),
            Text(kutipan ?? '', style: gayaTeks.titleMedium),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— ${penulis ?? ''}',
                style: gayaTeks.labelLarge?.copyWith(color: warna.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
