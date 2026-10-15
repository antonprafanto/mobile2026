// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 08: Pengumuman yang Tetap Terbaca Saat Luring (cache)
// Topik: Lanjutan Contoh 06 Pertemuan 10. Setiap kali pengumuman berhasil
//        diambil dari internet, salinannya disimpan di perangkat (cache).
//        Jika kelak server tidak bisa dihubungi, aplikasi menampilkan
//        salinan terakhir itu, lengkap dengan keterangan waktunya.
//        Strategi ini disebut "data lokal sebagai cadangan":
//          1. coba ambil dari server;
//          2. berhasil -> simpan salinannya, tampilkan;
//          3. gagal    -> pakai salinan tersimpan (jika ada).
//        Cache disimpan sebagai SATU teks JSON (isi + waktu) dengan
//        shared_preferences, karena ukurannya kecil dan boleh hilang.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa ketiga langkah
//        itu dengan MockClient (tanpa internet). Lihat konsol.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan sekali
//      flutter pub add http provider shared_preferences
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan: flutter run -d chrome --web-port=8080
//    Buka sekali saat ada internet. Lalu matikan internet (atau ganti
//    _host menjadi 'dummyjson.invalid') dan tekan tombol muat ulang.
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: [
        Provider<LayananDummyJson>(
          create: (BuildContext context) => LayananDummyJson(),
          dispose: (BuildContext context, LayananDummyJson layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriPengumuman>(
          create: (BuildContext context) => RepositoriPengumumanLuring(
            layanan: context.read<LayananDummyJson>(),
            cache: CachePengumuman(PenyimpananTeksPrefs()),
          ),
        ),
      ],
      child: const AplikasiPengumuman(),
    ),
  );
}

// ============================ MODEL ============================

class Pengumuman {
  const Pengumuman({
    required this.judul,
    required this.isi,
    required this.dibaca,
  });

  final String judul;
  final String isi;
  final int dibaca;

  // Format SIMPANAN milik aplikasi sendiri (bukan format server), supaya
  // cache tidak ikut rusak jika bentuk JSON server berubah.
  Map<String, Object?> keJson() {
    return {'judul': judul, 'isi': isi, 'dibaca': dibaca};
  }

  factory Pengumuman.dariJson(Object? json) {
    return switch (json) {
      {
        'judul': final String judul,
        'isi': final String isi,
        'dibaca': final int dibaca,
      } =>
        Pengumuman(judul: judul, isi: isi, dibaca: dibaca),
      _ => throw const FormatException('Bentuk pengumuman tersimpan salah'),
    };
  }
}

// Hasil yang diterima ViewModel: datanya, kapan diambil dari server, dan
// apakah ini salinan tersimpan.
class HasilPengumuman {
  const HasilPengumuman({
    required this.daftar,
    required this.waktu,
    required this.dariCache,
  });

  final List<Pengumuman> daftar;
  final DateTime waktu;
  final bool dariCache;
}

// ===================== SERVICE (LAYANAN) =====================

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

// Sama dengan Pertemuan 10.
class LayananDummyJson {
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
    return switch (jsonDecode(utf8.decode(respons.bodyBytes))) {
      final Map<String, dynamic> data => data,
      _ => throw const FormatException('Bentuk JSON tidak dikenal'),
    };
  }

  void tutup() => _klien.close();
}

// Penyimpanan teks sederhana. Dibuat sebagai kontrak agar saat pengujian
// bisa diganti versi memori (data asli di perangkat tidak tersentuh).
abstract class PenyimpananTeks {
  Future<String?> baca(String kunci);

  Future<void> tulis(String kunci, String teks);
}

class PenyimpananTeksPrefs implements PenyimpananTeks {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  @override
  Future<String?> baca(String kunci) => _prefs.getString(kunci);

  @override
  Future<void> tulis(String kunci, String teks) =>
      _prefs.setString(kunci, teks);
}

class PenyimpananTeksMemori implements PenyimpananTeks {
  final Map<String, String> _isi = {};

  @override
  Future<String?> baca(String kunci) async => _isi[kunci];

  @override
  Future<void> tulis(String kunci, String teks) async {
    _isi[kunci] = teks;
  }
}

// ============================ CACHE ============================

class CachePengumuman {
  CachePengumuman(this._penyimpanan);

  static const String _kunci = 'cache_pengumuman';

  final PenyimpananTeks _penyimpanan;

  // Isi dan waktu disimpan dalam SATU teks, jadi selalu cocok satu sama
  // lain (tidak mungkin isi baru tersimpan tetapi waktunya masih lama).
  Future<void> simpan(List<Pengumuman> daftar, DateTime waktu) {
    final String teks = jsonEncode({
      'waktu': waktu.millisecondsSinceEpoch,
      'daftar': [for (final Pengumuman p in daftar) p.keJson()],
    });
    return _penyimpanan.tulis(_kunci, teks);
  }

  // null = belum ada salinan (atau salinannya rusak).
  Future<HasilPengumuman?> baca() async {
    final String? teks = await _penyimpanan.baca(_kunci);
    if (teks == null) {
      return null;
    }
    try {
      return switch (jsonDecode(teks)) {
        {'waktu': final int waktu, 'daftar': final List<dynamic> daftar} =>
          HasilPengumuman(
            daftar: daftar.map(Pengumuman.dariJson).toList(),
            waktu: DateTime.fromMillisecondsSinceEpoch(waktu),
            dariCache: true,
          ),
        _ => null,
      };
    } on FormatException catch (galat) {
      debugPrint('Cache rusak, diabaikan: $galat');
      return null;
    }
  }
}

// ========================= REPOSITORY =========================

abstract class RepositoriPengumuman {
  Future<HasilPengumuman> ambilSemua();
}

class RepositoriPengumumanLuring implements RepositoriPengumuman {
  RepositoriPengumumanLuring({required this._layanan, required this._cache});

  final LayananDummyJson _layanan;
  final CachePengumuman _cache;

  @override
  Future<HasilPengumuman> ambilSemua() async {
    try {
      // 1. Coba ambil dari server.
      final List<Pengumuman> daftar = await _ambilDariServer();
      // 2. Berhasil: simpan salinannya untuk nanti.
      final DateTime sekarang = DateTime.now();
      await _cache.simpan(daftar, sekarang);
      return HasilPengumuman(daftar: daftar, waktu: sekarang, dariCache: false);
    } catch (galat) {
      // 3. Gagal: pakai salinan tersimpan, jika ada.
      final HasilPengumuman? tersimpan = await _cache.baca();
      if (tersimpan == null) {
        rethrow; // belum pernah tersimpan: tetap gagal
      }
      debugPrint('Server gagal ($galat). Memakai data tersimpan.');
      return tersimpan;
    }
  }

  Future<List<Pengumuman>> _ambilDariServer() async {
    final Map<String, dynamic> json = await _layanan.ambilJson(
      '/posts',
      query: {'limit': '10', 'select': 'title,body,views'},
    );
    return switch (json) {
      {'posts': final List<dynamic> isi} => isi.map(_dariJsonServer).toList(),
      _ => throw const FormatException('Kunci "posts" tidak ditemukan'),
    };
  }

  Pengumuman _dariJsonServer(dynamic item) {
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

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

String pesanRamah(Object galat) {
  return switch (galat) {
    TimeoutException() => 'Server terlalu lama menjawab. Coba lagi.',
    ApiException(kodeStatus: >= 500) =>
      'Server sedang bermasalah. Coba lagi nanti.',
    ApiException() => 'Permintaan ditolak oleh server.',
    FormatException() => 'Data dari server tidak bisa dibaca.',
    http.ClientException() =>
      'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    _ => 'Terjadi kesalahan yang tidak terduga.',
  };
}

class PengumumanViewModel extends ChangeNotifier {
  PengumumanViewModel({required this._repositori});

  final RepositoriPengumuman _repositori;

  StatusMuat _status = StatusMuat.memuat;
  HasilPengumuman? _hasil;
  String _pesanGalat = '';
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  HasilPengumuman? get hasil => _hasil;
  String get pesanGalat => _pesanGalat;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    notifyListeners();
    try {
      final HasilPengumuman hasil = await _repositori.ambilSemua();
      if (_sudahDibuang) {
        return;
      }
      _hasil = hasil;
      _status = StatusMuat.berhasil;
    } catch (galat) {
      if (_sudahDibuang) {
        return;
      }
      debugPrint('Galat saat memuat: $galat');
      _pesanGalat = pesanRamah(galat);
      _status = StatusMuat.gagal;
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

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

String formatWaktu(DateTime waktu) {
  return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)} pukul '
      '${duaDigit(waktu.hour)}.${duaDigit(waktu.minute)}';
}

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
      StatusMuat.gagal => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(vm.pesanGalat, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              const Text(
                'Belum ada data tersimpan di perangkat ini.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.read<PengumumanViewModel>().muat(),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
      StatusMuat.berhasil => IsiPengumuman(hasil: vm.hasil!),
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

class IsiPengumuman extends StatelessWidget {
  const IsiPengumuman({super.key, required this.hasil});

  final HasilPengumuman hasil;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasil.dariCache)
          SpandukLuring(waktu: hasil.waktu)
        else
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Diperbarui ${formatWaktu(hasil.waktu)}'),
          ),
        Expanded(child: DaftarPengumuman(daftar: hasil.daftar)),
      ],
    );
  }
}

// Spanduk yang memberi tahu pengguna bahwa data yang tampil adalah salinan.
class SpandukLuring extends StatelessWidget {
  const SpandukLuring({super.key, required this.waktu});

  final DateTime waktu;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Material(
      color: warna.tertiaryContainer,
      child: ListTile(
        leading: Icon(Icons.cloud_off, color: warna.onTertiaryContainer),
        title: Text(
          'Mode luring',
          style: TextStyle(color: warna.onTertiaryContainer),
        ),
        subtitle: Text(
          'Menampilkan data tersimpan dari ${formatWaktu(waktu)}.',
          style: TextStyle(color: warna.onTertiaryContainer),
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
          subtitle: Text(
            '${pengumuman.isi}\nDibaca ${pengumuman.dibaca} kali',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: true,
        );
      },
    );
  }
}

// ======================= PEMERIKSAAN =======================

const String contohJsonPosts = '''
{
  "posts": [
    {"id": 1, "title": "Jadwal UTS", "body": "Lihat portal akademik.", "views": 120},
    {"id": 2, "title": "Asisten praktikum", "body": "Pendaftaran dibuka.", "views": 87}
  ],
  "total": 2, "skip": 0, "limit": 10
}
''';

void periksa(String nama, Object? didapat, Object? diharapkan) {
  if (didapat == diharapkan) {
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

Future<void> jalankanUji() async {
  bool serverHidup = false;
  final CachePengumuman cache = CachePengumuman(PenyimpananTeksMemori());
  final RepositoriPengumuman repo = RepositoriPengumumanLuring(
    layanan: LayananDummyJson(
      klien: MockClient((http.Request permintaan) async {
        if (!serverHidup) {
          throw http.ClientException('Tidak ada koneksi');
        }
        return http.Response(contohJsonPosts, 200);
      }),
    ),
    cache: cache,
  );

  try {
    // 1. Belum ada salinan dan server mati: galatnya diteruskan.
    try {
      await repo.ambilSemua();
      periksa('Tanpa salinan + server mati', 'berhasil', 'ClientException');
    } on http.ClientException {
      periksa(
        'Tanpa salinan + server mati',
        'ClientException',
        'ClientException',
      );
    }

    // 2. Server hidup: data dari server, dan salinannya disimpan.
    serverHidup = true;
    final HasilPengumuman dariServer = await repo.ambilSemua();
    periksa('Server hidup: bukan salinan', dariServer.dariCache, false);
    periksa('Server hidup: 2 pengumuman', dariServer.daftar.length, 2);
    periksa('Salinan tersimpan', (await cache.baca())?.daftar.length, 2);

    // 3. Server mati lagi: salinan terakhir yang dipakai.
    serverHidup = false;
    final HasilPengumuman cadangan = await repo.ambilSemua();
    periksa('Server mati: memakai salinan', cadangan.dariCache, true);
    periksa('Isi salinan sama', cadangan.daftar.first.judul, 'Jadwal UTS');
    periksa(
      'Waktu salinan = waktu pengambilan terakhir',
      cadangan.waktu.millisecondsSinceEpoch,
      dariServer.waktu.millisecondsSinceEpoch,
    );
  } catch (galat) {
    debugPrint('GAGAL  pemeriksaan berhenti: $galat');
  }
}
