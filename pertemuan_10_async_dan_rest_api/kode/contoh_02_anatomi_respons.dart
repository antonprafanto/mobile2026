// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 02: Membedah Jawaban Server (Respons HTTP)
// Topik: Pilih salah satu percobaan, lalu lihat apa yang dikirim server:
//        kode status, jenis isi (Content-Type), lama menunggu, dan isi
//        jawabannya. Perhatikan dua hal penting:
//        - Kode 404 atau 500 tetap sebuah JAWABAN. Paket http tidak
//          melempar exception; kitalah yang harus memeriksa kodenya.
//        - Exception baru muncul jika TIDAK ADA jawaban sama sekali,
//          misalnya alamat servernya tidak ada.
//        Server latihan: https://dummyjson.com (data contoh, gratis).
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http` sekali.
//    (DartPad sudah menyediakan paket http.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AplikasiPenjelajah());
}

// Satu percobaan = satu alamat yang akan diminta.
class Percobaan {
  const Percobaan(this.label, this.alamat, this.keterangan);

  final String label;
  final String alamat;
  final String keterangan;
}

const List<Percobaan> daftarPercobaan = [
  Percobaan(
    'Berhasil',
    'https://dummyjson.com/quotes/1',
    'Data yang diminta ada: kode 200.',
  ),
  Percobaan(
    'Tidak ditemukan',
    'https://dummyjson.com/quotes/99999',
    'Kutipan nomor 99999 tidak ada: kode 404.',
  ),
  Percobaan(
    'Server bermasalah',
    'https://dummyjson.com/http/500/Server%20sedang%20sibuk',
    'Alamat khusus DummyJSON yang selalu menjawab kode 500.',
  ),
  Percobaan(
    'Lambat',
    'https://dummyjson.com/quotes/2?delay=3000',
    'Server sengaja menunda jawaban 3 detik.',
  ),
  Percobaan(
    'Alamat salah',
    'https://server-yang-tidak-ada.invalid/data',
    'Tidak ada server dengan nama ini: tidak ada jawaban sama sekali.',
  ),
];

class AplikasiPenjelajah extends StatelessWidget {
  const AplikasiPenjelajah({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penjelajah Respons',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanPenjelajah(),
    );
  }
}

class HalamanPenjelajah extends StatefulWidget {
  const HalamanPenjelajah({super.key});

  @override
  State<HalamanPenjelajah> createState() => _HalamanPenjelajahState();
}

class _HalamanPenjelajahState extends State<HalamanPenjelajah> {
  Percobaan? _terpilih;
  bool _menunggu = false;

  // Hasil percobaan terakhir.
  int? _kodeStatus;
  String? _jenisIsi;
  String? _isi;
  String? _galat;
  int _lamaMs = 0;

  Future<void> _coba(Percobaan percobaan) async {
    setState(() {
      _terpilih = percobaan;
      _menunggu = true;
      _kodeStatus = null;
      _jenisIsi = null;
      _isi = null;
      _galat = null;
    });

    // Stopwatch mengukur berapa lama kita menunggu jawaban.
    final Stopwatch stopwatch = Stopwatch()..start();
    try {
      final http.Response respons = await http.get(Uri.parse(percobaan.alamat));
      if (!mounted) return;
      setState(() {
        _kodeStatus = respons.statusCode;
        _jenisIsi = respons.headers['content-type'];
        _isi = respons.body;
      });
    } catch (galat) {
      if (!mounted) return;
      setState(() {
        _galat = galat.toString();
      });
    } finally {
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _menunggu = false;
          _lamaMs = stopwatch.elapsedMilliseconds;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Penjelajah Respons')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final Percobaan percobaan in daftarPercobaan)
                ChoiceChip(
                  label: Text(percobaan.label),
                  selected: _terpilih == percobaan,
                  // Tidak bisa memilih percobaan lain selama menunggu.
                  onSelected: _menunggu ? null : (_) => _coba(percobaan),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_terpilih == null)
            const Text('Pilih salah satu percobaan di atas.')
          else
            _KartuHasil(
              percobaan: _terpilih!,
              menunggu: _menunggu,
              kodeStatus: _kodeStatus,
              jenisIsi: _jenisIsi,
              isi: _isi,
              galat: _galat,
              lamaMs: _lamaMs,
            ),
        ],
      ),
    );
  }
}

class _KartuHasil extends StatelessWidget {
  const _KartuHasil({
    required this.percobaan,
    required this.menunggu,
    required this.kodeStatus,
    required this.jenisIsi,
    required this.isi,
    required this.galat,
    required this.lamaMs,
  });

  final Percobaan percobaan;
  final bool menunggu;
  final int? kodeStatus;
  final String? jenisIsi;
  final String? isi;
  final String? galat;
  final int lamaMs;

  // Kelompok kode status: 2xx berhasil, 4xx salah di sisi peminta,
  // 5xx salah di sisi server.
  String _artiKode(int kode) {
    if (kode >= 200 && kode < 300) return 'berhasil';
    if (kode >= 400 && kode < 500) return 'kesalahan di sisi aplikasi kita';
    if (kode >= 500) return 'kesalahan di sisi server';
    return 'lainnya';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    final String isiPendek = (isi ?? '').length > 300
        ? '${isi!.substring(0, 300)}...'
        : (isi ?? '');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(percobaan.alamat, style: gayaTeks.labelMedium),
            const SizedBox(height: 4),
            Text(percobaan.keterangan, style: gayaTeks.bodySmall),
            const Divider(height: 24),
            if (menunggu)
              const Row(
                children: [
                  SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('Menunggu jawaban server...'),
                ],
              )
            else if (galat != null) ...[
              Text(
                'Tidak ada jawaban (exception)',
                style: gayaTeks.titleMedium?.copyWith(color: warna.error),
              ),
              const SizedBox(height: 8),
              Text(galat!),
              const SizedBox(height: 8),
              Text('Lama menunggu: $lamaMs ms'),
            ] else if (kodeStatus != null) ...[
              Text(
                'Kode status: $kodeStatus (${_artiKode(kodeStatus!)})',
                style: gayaTeks.titleMedium?.copyWith(
                  color: kodeStatus! < 300 ? warna.primary : warna.error,
                ),
              ),
              const SizedBox(height: 8),
              Text('Jenis isi: ${jenisIsi ?? '-'}'),
              Text('Lama menunggu: $lamaMs ms'),
              const SizedBox(height: 12),
              Text('Isi jawaban (body):', style: gayaTeks.labelLarge),
              const SizedBox(height: 4),
              Text(isiPendek),
            ],
          ],
        ),
      ),
    );
  }
}
