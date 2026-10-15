// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 05: Menangani Galat Jaringan dengan Pesan yang Ramah
// Topik: Permintaan ke internet bisa gagal dengan banyak cara. Fungsi
//        ambilJson() mengubah setiap kegagalan menjadi exception yang
//        jelas jenisnya:
//        - TimeoutException  : server terlalu lama menjawab;
//        - ApiException      : server menjawab, tetapi kodenya bukan 200;
//        - FormatException   : jawabannya bukan JSON yang bisa dibaca;
//        - ClientException   : tidak ada jawaban sama sekali.
//        Lalu pesanRamah() memilih kalimat yang dimengerti pengguna.
//        Detail teknisnya tetap ditampilkan kecil untuk pengembang.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http` sekali.
//    (DartPad sudah menyediakan paket http.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AplikasiGalat());
}

// ===================== LAPISAN PENGAMBIL DATA =====================

// Exception buatan sendiri (Pertemuan 3): server menjawab, tetapi
// kodenya menandakan kegagalan.
class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

const Duration batasWaktu = Duration(seconds: 3);

Future<Map<String, dynamic>> ambilJson(Uri alamat) async {
  final http.Response respons = await http
      .get(alamat, headers: {'Accept': 'application/json'})
      // Jika lebih dari 3 detik tidak ada jawaban: TimeoutException.
      .timeout(batasWaktu);

  if (respons.statusCode != 200) {
    throw ApiException(respons.statusCode);
  }

  // jsonDecode melempar FormatException jika teksnya bukan JSON.
  final Object? data = jsonDecode(respons.body);
  if (data is! Map<String, dynamic>) {
    throw const FormatException('Bentuk JSON tidak dikenal');
  }
  return data;
}

// Satu tempat untuk menerjemahkan exception menjadi kalimat untuk
// pengguna. switch dengan pola objek (Dart 3) mencocokkan JENIS-nya.
String pesanRamah(Object galat) {
  return switch (galat) {
    TimeoutException() =>
      'Server terlalu lama menjawab. Coba lagi beberapa saat lagi.',
    ApiException(kodeStatus: 404) => 'Data yang dicari tidak ditemukan.',
    ApiException(kodeStatus: >= 500) =>
      'Server sedang bermasalah. Coba lagi nanti.',
    ApiException() => 'Permintaan ditolak oleh server.',
    FormatException() => 'Data dari server tidak bisa dibaca.',
    http.ClientException() =>
      'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    _ => 'Terjadi kesalahan yang tidak terduga.',
  };
}

// ============================ VIEW ============================

class Skenario {
  const Skenario(this.label, this.alamat);

  final String label;
  final String alamat;
}

const List<Skenario> daftarSkenario = [
  Skenario('Normal', 'https://dummyjson.com/quotes/3'),
  Skenario('Lambat 5 detik', 'https://dummyjson.com/quotes/3?delay=5000'),
  Skenario('Tidak ditemukan', 'https://dummyjson.com/quotes/99999'),
  Skenario('Server error', 'https://dummyjson.com/http/503/Sedang%20perawatan'),
  Skenario('Bukan JSON', 'https://dummyjson.com/image/150'),
  Skenario('Tanpa koneksi', 'https://server-yang-tidak-ada.invalid/data'),
];

class AplikasiGalat extends StatelessWidget {
  const AplikasiGalat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uji Ketahanan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HalamanGalat(),
    );
  }
}

class HalamanGalat extends StatefulWidget {
  const HalamanGalat({super.key});

  @override
  State<HalamanGalat> createState() => _HalamanGalatState();
}

class _HalamanGalatState extends State<HalamanGalat> {
  Skenario? _skenario;
  bool _memuat = false;
  String? _kutipan;
  Object? _galat;

  Future<void> _jalankan(Skenario skenario) async {
    setState(() {
      _skenario = skenario;
      _memuat = true;
      _kutipan = null;
      _galat = null;
    });
    try {
      final Map<String, dynamic> json = await ambilJson(
        Uri.parse(skenario.alamat),
      );
      if (!mounted) return;
      setState(() => _kutipan = json['quote'] as String?);
    } catch (galat) {
      debugPrint('Galat teknis: $galat');
      if (!mounted) return;
      setState(() => _galat = galat);
    } finally {
      if (mounted) {
        setState(() => _memuat = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Uji Ketahanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Batas waktu menunggu: ${batasWaktu.inSeconds} detik',
            style: gayaTeks.bodySmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final Skenario skenario in daftarSkenario)
                ChoiceChip(
                  label: Text(skenario.label),
                  selected: _skenario == skenario,
                  onSelected: _memuat ? null : (_) => _jalankan(skenario),
                ),
            ],
          ),
          const SizedBox(height: 24),
          if (_memuat)
            const Center(child: CircularProgressIndicator())
          else if (_galat != null)
            Card(
              color: warna.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pesanRamah(_galat!),
                      style: gayaTeks.titleMedium?.copyWith(
                        color: warna.onErrorContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Detail teknis: berguna untuk pengembang, bukan
                    // untuk pengguna. Di aplikasi sungguhan cukup dicatat.
                    Text(
                      'Detail teknis: ${_galat.runtimeType}\n$_galat',
                      style: gayaTeks.bodySmall?.copyWith(
                        color: warna.onErrorContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: () => _jalankan(_skenario!),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            )
          else if (_kutipan != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_kutipan!, style: gayaTeks.titleMedium),
              ),
            ),
        ],
      ),
    );
  }
}
