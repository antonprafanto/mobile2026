// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 06: Lapisan Data: Layanan (Service) + Repository + ViewModel
// Topik: Lanjutan Contoh 08 Pertemuan 9. Kini pengumuman benar-benar
//        diambil dari internet (https://dummyjson.com/posts). Kodenya
//        dibagi menurut tugas:
//        - LayananDummyJson : HANYA mengurus HTTP dan JSON (service);
//        - RepositoriPengumumanApi : mengubah JSON menjadi Model;
//        - PengumumanViewModel dan View : SAMA dengan Pertemuan 9.
//        Ubah satu baris `create` di main() untuk berpindah antara
//        repository palsu dan repository API. ViewModel dan View tidak
//        perlu disentuh sama sekali.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http provider` sekali.
//    (DartPad sudah menyediakan kedua paket ini.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Layanan dibuat sekali dan ditutup (dispose) saat aplikasi selesai.
        Provider<LayananDummyJson>(
          create: (BuildContext context) => LayananDummyJson(),
          dispose: (BuildContext context, LayananDummyJson layanan) =>
              layanan.tutup(),
        ),
        // Ganti baris create di bawah ini untuk memakai repository palsu:
        //   create: (BuildContext context) => RepositoriPengumumanPalsu(),
        Provider<RepositoriPengumuman>(
          create: (BuildContext context) => RepositoriPengumumanApi(
            layanan: context.read<LayananDummyJson>(),
          ),
        ),
      ],
      child: const AplikasiPengumuman(),
    ),
  );
}

// =========================== MODEL ===========================

class Pengumuman {
  const Pengumuman({
    required this.judul,
    required this.isi,
    required this.dibaca,
  });

  final String judul;
  final String isi;
  final int dibaca; // berapa kali pengumuman ini dibaca
}

// ===================== SERVICE (LAYANAN) =====================

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

// Service hanya tahu cara berbicara dengan server: membuat alamat,
// mengirim permintaan, memeriksa kode status, dan membaca JSON.
// Service tidak menyimpan state dan tidak mengenal Model.
class LayananDummyJson {
  // http.Client diterima dari luar (bisa diganti saat pengujian, lihat
  // Contoh 10). Jika tidak diberikan, dibuat Client biasa.
  LayananDummyJson({http.Client? klien}) : _klien = klien ?? http.Client();

  static const String _host = 'dummyjson.com';
  static const Duration _batasWaktu = Duration(seconds: 10);

  final http.Client _klien;

  Future<Map<String, dynamic>> ambilJson(
    String jalur, {
    Map<String, String>? query,
  }) async {
    final Uri alamat = Uri.https(_host, jalur, query);
    final http.Response respons = await _klien
        .get(alamat, headers: {'Accept': 'application/json'})
        .timeout(_batasWaktu);

    if (respons.statusCode != 200) {
      throw ApiException(respons.statusCode);
    }
    // bodyBytes + utf8.decode: huruf seperti é atau ° tetap terbaca benar,
    // walaupun server lupa menyebutkan charset di Content-Type.
    return switch (jsonDecode(utf8.decode(respons.bodyBytes))) {
      final Map<String, dynamic> data => data,
      _ => throw const FormatException('Bentuk JSON tidak dikenal'),
    };
  }

  void tutup() => _klien.close();
}

// ========================= REPOSITORY =========================

// Kontrak yang SAMA dengan Pertemuan 9.
abstract class RepositoriPengumuman {
  Future<List<Pengumuman>> ambilSemua();
}

// Repository mengubah data mentah dari service menjadi Model.
class RepositoriPengumumanApi implements RepositoriPengumuman {
  RepositoriPengumumanApi({required this._layanan});

  final LayananDummyJson _layanan;

  @override
  Future<List<Pengumuman>> ambilSemua() async {
    final Map<String, dynamic> json = await _layanan.ambilJson(
      '/posts',
      query: {'limit': '10', 'select': 'title,body,views'},
    );
    return switch (json) {
      {'posts': final List<dynamic> isi} => isi.map(_dariJson).toList(),
      _ => throw const FormatException('Kunci "posts" tidak ditemukan'),
    };
  }

  Pengumuman _dariJson(dynamic item) {
    return switch (item) {
      {
        'title': final String judul,
        'body': final String isi,
        'views': final int dibaca,
      } =>
        Pengumuman(judul: judul, isi: isi, dibaca: dibaca),
      _ => throw const FormatException('Bentuk data pengumuman tidak sesuai'),
    };
  }
}

// Repository palsu dari Pertemuan 9 (disesuaikan dengan Model ini).
class RepositoriPengumumanPalsu implements RepositoriPengumuman {
  @override
  Future<List<Pengumuman>> ambilSemua() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return const [
      Pengumuman(
        judul: 'Jadwal UTS diumumkan',
        isi: 'Jadwal ujian dapat dilihat di portal akademik.',
        dibaca: 120,
      ),
      Pengumuman(
        judul: 'Pendaftaran asisten praktikum',
        isi: 'Dibuka untuk mahasiswa semester 5 ke atas.',
        dibaca: 87,
      ),
    ];
  }
}

// ========================= VIEWMODEL =========================
// (sama dengan Contoh 08 Pertemuan 9)

enum StatusMuat { memuat, berhasil, gagal }

class PengumumanViewModel extends ChangeNotifier {
  PengumumanViewModel({required this._repositori});

  final RepositoriPengumuman _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Pengumuman> _daftar = [];
  String _pesanGalat = '';
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Pengumuman> get daftar => _daftar;
  String get pesanGalat => _pesanGalat;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    notifyListeners();

    try {
      _daftar = await _repositori.ambilSemua();
      _status = StatusMuat.berhasil;
    } catch (galat) {
      debugPrint('Galat saat memuat: $galat');
      _pesanGalat = 'Pengumuman gagal dimuat. Periksa koneksi, lalu coba lagi.';
      _status = StatusMuat.gagal;
    }

    if (_sudahDibuang) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

class AplikasiPengumuman extends StatelessWidget {
  const AplikasiPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengumuman Prodi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => PengumumanViewModel(
          repositori: context.read<RepositoriPengumuman>(),
        )..muat(),
        child: const HalamanPengumuman(),
      ),
    );
  }
}

class HalamanPengumuman extends StatelessWidget {
  const HalamanPengumuman({super.key});

  @override
  Widget build(BuildContext context) {
    final PengumumanViewModel vm = context.watch<PengumumanViewModel>();

    final Widget isi = switch (vm.status) {
      StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
      StatusMuat.gagal => TampilanGagal(
        pesan: vm.pesanGalat,
        onCobaLagi: () => context.read<PengumumanViewModel>().muat(),
      ),
      StatusMuat.berhasil => DaftarPengumuman(daftar: vm.daftar),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman Prodi'),
        actions: [
          IconButton(
            onPressed: vm.status == StatusMuat.memuat
                ? null
                : () => context.read<PengumumanViewModel>().muat(),
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isi,
    );
  }
}

class TampilanGagal extends StatelessWidget {
  const TampilanGagal({
    super.key,
    required this.pesan,
    required this.onCobaLagi,
  });

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 64, color: warna.error),
            const SizedBox(height: 12),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onCobaLagi,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class DaftarPengumuman extends StatelessWidget {
  const DaftarPengumuman({super.key, required this.daftar});

  final List<Pengumuman> daftar;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: daftar.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        final Pengumuman pengumuman = daftar[index];
        return ListTile(
          leading: const Icon(Icons.campaign_outlined),
          title: Text(pengumuman.judul),
          // Isi dibatasi dua baris agar keterangan "Dibaca" selalu terlihat.
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pengumuman.isi,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text('Dibaca ${pengumuman.dibaca} kali'),
            ],
          ),
          isThreeLine: true,
        );
      },
    );
  }
}
