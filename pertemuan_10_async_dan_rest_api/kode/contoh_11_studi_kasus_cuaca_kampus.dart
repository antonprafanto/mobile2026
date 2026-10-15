// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 10: ASINKRON & REST API
// CONTOH 11: Studi Kasus "Cuaca Kampus"
// Topik: Prakiraan cuaca delapan kota kampus dari REST API Open-Meteo
//        (https://open-meteo.com, gratis, tanpa kunci API). Semua materi
//        hari ini dirangkai dengan pola MVVM:
//        - LayananOpenMeteo   : membuat alamat + parameter query, HTTP,
//                               kode status, batas waktu, dan JSON;
//        - RepositoriCuaca... : JSON -> Model, termasuk data harian yang
//                               berbentuk "array sejajar";
//        - CuacaViewModel     : status memuat/berhasil/gagal, kota
//                               terpilih, pesan galat yang ramah, dan
//                               nomor permintaan untuk jawaban terlambat;
//        - View               : pilihan kota, kartu cuaca saat ini,
//                               prakiraan 7 hari, tarik untuk menyegarkan.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa repository dan
//        ViewModel dengan MockClient (tanpa internet). Lihat konsol.
// =====================================================================
// CARA MENJALANKAN:
// 1. Proyek Flutter: jalankan `flutter pub add http provider` sekali.
//    (DartPad sudah menyediakan kedua paket ini.)
// 2. Salin seluruh isi berkas ini ke lib/main.dart.
// 3. Jalankan di terminal: flutter run -d chrome
//    Butuh koneksi internet.
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: [
        Provider<LayananOpenMeteo>(
          create: (BuildContext context) => LayananOpenMeteo(),
          dispose: (BuildContext context, LayananOpenMeteo layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriCuaca>(
          create: (BuildContext context) => RepositoriCuacaOpenMeteo(
            layanan: context.read<LayananOpenMeteo>(),
          ),
        ),
      ],
      child: const AplikasiCuaca(),
    ),
  );
}

// ============================ MODEL ============================

enum Kota {
  jakarta('Jakarta', -6.20, 106.85),
  bandung('Bandung', -6.91, 107.61),
  yogyakarta('Yogyakarta', -7.80, 110.37),
  surabaya('Surabaya', -7.25, 112.75),
  denpasar('Denpasar', -8.65, 115.22),
  samarinda('Samarinda', -0.50, 117.15),
  makassar('Makassar', -5.15, 119.43),
  medan('Medan', 3.59, 98.67);

  const Kota(this.nama, this.lintang, this.bujur);

  final String nama;
  final double lintang; // latitude
  final double bujur; // longitude
}

enum Kondisi {
  cerah('Cerah', Icons.wb_sunny),
  cerahBerawan('Cerah berawan', Icons.wb_cloudy),
  berawan('Berawan', Icons.cloud),
  berkabut('Berkabut', Icons.foggy),
  gerimis('Gerimis', Icons.grain),
  hujanRingan('Hujan ringan', Icons.water_drop_outlined),
  hujan('Hujan', Icons.water_drop),
  hujanLebat('Hujan lebat', Icons.umbrella),
  salju('Salju', Icons.ac_unit),
  badaiPetir('Badai petir', Icons.thunderstorm),
  tidakDiketahui('Tidak diketahui', Icons.help_outline);

  const Kondisi(this.label, this.ikon);

  final String label;
  final IconData ikon;

  // Kode cuaca WMO (dipakai Open-Meteo) -> kondisi yang mudah dibaca.
  static Kondisi dariKode(int kode) {
    return switch (kode) {
      0 => Kondisi.cerah,
      1 || 2 => Kondisi.cerahBerawan,
      3 => Kondisi.berawan,
      45 || 48 => Kondisi.berkabut,
      >= 51 && <= 57 => Kondisi.gerimis,
      61 || 80 => Kondisi.hujanRingan,
      63 || 66 || 81 => Kondisi.hujan,
      65 || 67 || 82 => Kondisi.hujanLebat,
      >= 71 && <= 77 || 85 || 86 => Kondisi.salju,
      >= 95 && <= 99 => Kondisi.badaiPetir,
      _ => Kondisi.tidakDiketahui,
    };
  }
}

class CuacaSaatIni {
  const CuacaSaatIni({
    required this.suhu,
    required this.kelembapan,
    required this.angin,
    required this.kondisi,
  });

  final double suhu; // °C
  final int kelembapan; // %
  final double angin; // km/jam
  final Kondisi kondisi;
}

class PrakiraanHarian {
  const PrakiraanHarian({
    required this.tanggal,
    required this.kondisi,
    required this.suhuMaks,
    required this.suhuMin,
    required this.peluangHujan,
  });

  final DateTime tanggal;
  final Kondisi kondisi;
  final double suhuMaks;
  final double suhuMin;
  final int? peluangHujan; // % ; bisa kosong (null) dari server
}

class Cuaca {
  const Cuaca({
    required this.kota,
    required this.saatIni,
    required this.harian,
  });

  final Kota kota;
  final CuacaSaatIni saatIni;
  final List<PrakiraanHarian> harian;
}

// ===================== SERVICE (LAYANAN) =====================

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

class LayananOpenMeteo {
  LayananOpenMeteo({
    http.Client? klien,
    this.batasWaktu = const Duration(seconds: 10),
  }) : _klien = klien ?? http.Client();

  final http.Client _klien;
  final Duration batasWaktu;

  Future<Map<String, dynamic>> ambilPrakiraan({
    required double lintang,
    required double bujur,
  }) async {
    final Uri alamat = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$lintang',
      'longitude': '$bujur',
      'current':
          'temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m',
      'daily':
          'weather_code,temperature_2m_max,temperature_2m_min,'
          'precipitation_probability_max',
      'timezone': 'auto', // tanggal mengikuti zona waktu kota itu
      'forecast_days': '7',
    });
    debugPrint('GET $alamat');

    final http.Response respons = await _klien
        .get(alamat, headers: {'Accept': 'application/json'})
        .timeout(batasWaktu);
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

// ========================= REPOSITORY =========================

abstract class RepositoriCuaca {
  Future<Cuaca> ambil(Kota kota);
}

class RepositoriCuacaOpenMeteo implements RepositoriCuaca {
  RepositoriCuacaOpenMeteo({required LayananOpenMeteo layanan})
    : _layanan = layanan;

  final LayananOpenMeteo _layanan;

  @override
  Future<Cuaca> ambil(Kota kota) async {
    final Map<String, dynamic> json = await _layanan.ambilPrakiraan(
      lintang: kota.lintang,
      bujur: kota.bujur,
    );
    return switch (json) {
      {
        'current': final Map<String, dynamic> saatIni,
        'daily': final Map<String, dynamic> harian,
      } =>
        Cuaca(kota: kota, saatIni: _saatIni(saatIni), harian: _harian(harian)),
      _ => throw const FormatException('Bentuk data cuaca tidak sesuai'),
    };
  }

  CuacaSaatIni _saatIni(Map<String, dynamic> json) {
    return switch (json) {
      {
        'temperature_2m': final num suhu,
        'relative_humidity_2m': final num kelembapan,
        'weather_code': final num kode,
        'wind_speed_10m': final num angin,
      } =>
        CuacaSaatIni(
          suhu: suhu.toDouble(),
          kelembapan: kelembapan.round(),
          angin: angin.toDouble(),
          kondisi: Kondisi.dariKode(kode.toInt()),
        ),
      _ => throw const FormatException('Bentuk data cuaca saat ini salah'),
    };
  }

  // Data harian Open-Meteo berbentuk "array sejajar": time[i],
  // weather_code[i], temperature_2m_max[i], dan seterusnya adalah milik
  // hari ke-i. Panjang semua array harus sama.
  List<PrakiraanHarian> _harian(Map<String, dynamic> json) {
    if (json case {
      'time': final List<dynamic> tanggal,
      'weather_code': final List<dynamic> kode,
      'temperature_2m_max': final List<dynamic> maks,
      'temperature_2m_min': final List<dynamic> min,
      'precipitation_probability_max': final List<dynamic> peluang,
    }) {
      final int n = tanggal.length;
      if (kode.length != n ||
          maks.length != n ||
          min.length != n ||
          peluang.length != n) {
        throw const FormatException('Panjang data harian tidak sama');
      }
      return [
        for (int i = 0; i < n; i++)
          PrakiraanHarian(
            tanggal: DateTime.parse(tanggal[i] as String),
            kondisi: Kondisi.dariKode((kode[i] as num).toInt()),
            suhuMaks: (maks[i] as num).toDouble(),
            suhuMin: (min[i] as num).toDouble(),
            peluangHujan: (peluang[i] as num?)?.round(),
          ),
      ];
    }
    throw const FormatException('Bentuk data harian tidak sesuai');
  }
}

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

String pesanRamah(Object galat) {
  return switch (galat) {
    TimeoutException() => 'Server cuaca terlalu lama menjawab. Coba lagi.',
    ApiException(kodeStatus: >= 500) =>
      'Server cuaca sedang bermasalah. Coba lagi nanti.',
    ApiException() => 'Permintaan data cuaca ditolak server.',
    FormatException() => 'Data cuaca dari server tidak bisa dibaca.',
    http.ClientException() =>
      'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    _ => 'Terjadi kesalahan yang tidak terduga.',
  };
}

class CuacaViewModel extends ChangeNotifier {
  CuacaViewModel({required RepositoriCuaca repositori})
    : _repositori = repositori;

  final RepositoriCuaca _repositori;

  Kota _kota = Kota.jakarta;
  StatusMuat _status = StatusMuat.memuat;
  Cuaca? _cuaca;
  DateTime? _diperbarui;
  String _pesanGalat = '';
  int _nomorPermintaan = 0;
  bool _sudahDibuang = false;

  Kota get kota => _kota;
  StatusMuat get status => _status;
  Cuaca? get cuaca => _cuaca;
  DateTime? get diperbarui => _diperbarui;
  String get pesanGalat => _pesanGalat;

  // tampilkanMemuat: false saat ditarik untuk menyegarkan, karena
  // RefreshIndicator sudah menampilkan lingkarannya sendiri dan data
  // lama tetap terlihat selama menunggu.
  Future<void> muat({bool tampilkanMemuat = true}) async {
    final int nomor = ++_nomorPermintaan;
    if (tampilkanMemuat) {
      _status = StatusMuat.memuat;
      notifyListeners();
    }
    try {
      final Cuaca cuaca = await _repositori.ambil(_kota);
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return; // jawaban terlambat (kota sudah diganti)
      }
      _cuaca = cuaca;
      _diperbarui = DateTime.now();
      _status = StatusMuat.berhasil;
    } catch (galat) {
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat saat memuat cuaca: $galat');
      _pesanGalat = pesanRamah(galat);
      _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  Future<void> segarkan() => muat(tampilkanMemuat: false);

  void pilihKota(Kota kota) {
    if (kota == _kota) {
      return;
    }
    _kota = kota;
    muat();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ============================ VIEW ============================

class AplikasiCuaca extends StatelessWidget {
  const AplikasiCuaca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuaca Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) =>
            CuacaViewModel(repositori: context.read<RepositoriCuaca>())..muat(),
        child: const HalamanCuaca(),
      ),
    );
  }
}

class HalamanCuaca extends StatelessWidget {
  const HalamanCuaca({super.key});

  @override
  Widget build(BuildContext context) {
    final CuacaViewModel vm = context.watch<CuacaViewModel>();

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
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.read<CuacaViewModel>().muat(),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
      StatusMuat.berhasil => RefreshIndicator(
        onRefresh: () => context.read<CuacaViewModel>().segarkan(),
        child: IsiCuaca(cuaca: vm.cuaca!, diperbarui: vm.diperbarui!),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Cuaca Kampus')),
      body: Column(
        children: [
          const PilihanKota(),
          Expanded(child: isi),
        ],
      ),
    );
  }
}

class PilihanKota extends StatelessWidget {
  const PilihanKota({super.key});

  @override
  Widget build(BuildContext context) {
    // select: hanya dibangun ulang saat kota terpilih berubah.
    final Kota terpilih = context.select((CuacaViewModel vm) => vm.kota);

    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          for (final Kota kota in Kota.values)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(kota.nama),
                selected: kota == terpilih,
                onSelected: (_) =>
                    context.read<CuacaViewModel>().pilihKota(kota),
              ),
            ),
        ],
      ),
    );
  }
}

const List<String> namaHariIndonesia = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

class IsiCuaca extends StatelessWidget {
  const IsiCuaca({super.key, required this.cuaca, required this.diperbarui});

  final Cuaca cuaca;
  final DateTime diperbarui;

  String _namaHari(int urutan, DateTime tanggal) {
    if (urutan == 0) return 'Hari ini';
    if (urutan == 1) return 'Besok';
    return namaHariIndonesia[tanggal.weekday - 1]; // weekday: 1 = Senin
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return ListView(
      // Selalu bisa digulir, agar "tarik untuk menyegarkan" tetap
      // berfungsi walaupun isinya pendek.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        KartuSaatIni(cuaca: cuaca, diperbarui: diperbarui),
        const SizedBox(height: 16),
        Text('Prakiraan 7 hari', style: gayaTeks.titleMedium),
        const SizedBox(height: 4),
        for (int i = 0; i < cuaca.harian.length; i++)
          BarisHarian(
            namaHari: _namaHari(i, cuaca.harian[i].tanggal),
            prakiraan: cuaca.harian[i],
          ),
        const SizedBox(height: 16),
        Text(
          'Sumber data: Open-Meteo.com (CC BY 4.0). Tarik ke bawah untuk '
          'menyegarkan.',
          style: gayaTeks.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class KartuSaatIni extends StatelessWidget {
  const KartuSaatIni({
    super.key,
    required this.cuaca,
    required this.diperbarui,
  });

  final Cuaca cuaca;
  final DateTime diperbarui;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final CuacaSaatIni saatIni = cuaca.saatIni;

    return Card.filled(
      color: warna.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cuaca.kota.nama,
              style: gayaTeks.titleLarge?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  saatIni.kondisi.ikon,
                  size: 56,
                  color: warna.onPrimaryContainer,
                  semanticLabel: saatIni.kondisi.label,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${saatIni.suhu.round()}°C',
                        style: gayaTeks.displaySmall?.copyWith(
                          color: warna.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        saatIni.kondisi.label,
                        style: gayaTeks.titleMedium?.copyWith(
                          color: warna.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Kelembapan ${saatIni.kelembapan}% · '
              'Angin ${saatIni.angin.round()} km/jam',
              style: gayaTeks.bodyMedium?.copyWith(
                color: warna.onPrimaryContainer,
              ),
            ),
            Text(
              'Diperbarui pukul ${duaDigit(diperbarui.hour)}.'
              '${duaDigit(diperbarui.minute)}',
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

class BarisHarian extends StatelessWidget {
  const BarisHarian({
    super.key,
    required this.namaHari,
    required this.prakiraan,
  });

  final String namaHari;
  final PrakiraanHarian prakiraan;

  @override
  Widget build(BuildContext context) {
    final int? peluang = prakiraan.peluangHujan;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(prakiraan.kondisi.ikon),
      title: Text(namaHari),
      subtitle: Text(
        peluang == null
            ? prakiraan.kondisi.label
            : '${prakiraan.kondisi.label} · peluang hujan $peluang%',
      ),
      trailing: Text(
        '${prakiraan.suhuMaks.round()}° / ${prakiraan.suhuMin.round()}°',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

// ======================= PEMERIKSAAN =======================
// Dijalankan sebelum aplikasi tampil. Tidak butuh internet: "server"
// diganti MockClient yang jawabannya ditulis di bawah ini.

const String contohJsonCuaca = '''
{
  "latitude": -0.5,
  "longitude": 117.125,
  "timezone": "Asia/Makassar",
  "current": {
    "time": "2026-10-15T14:00",
    "interval": 900,
    "temperature_2m": 31.4,
    "relative_humidity_2m": 66,
    "weather_code": 3,
    "wind_speed_10m": 7.2
  },
  "daily": {
    "time": ["2026-10-15", "2026-10-16", "2026-10-17"],
    "weather_code": [3, 95, 61],
    "temperature_2m_max": [32.1, 30.5, 31],
    "temperature_2m_min": [24.3, 23.8, 24],
    "precipitation_probability_max": [20, 85, null]
  }
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
  http.Request? terakhir;
  final RepositoriCuaca repo = RepositoriCuacaOpenMeteo(
    layanan: LayananOpenMeteo(
      klien: MockClient((http.Request permintaan) async {
        terakhir = permintaan;
        return http.Response(contohJsonCuaca, 200);
      }),
    ),
  );

  final Cuaca cuaca = await repo.ambil(Kota.samarinda);
  periksa(
    'Alamat memakai lintang kota',
    terakhir!.url.queryParameters['latitude'],
    '${Kota.samarinda.lintang}',
  );
  periksa('Kode 3 = Berawan', cuaca.saatIni.kondisi, Kondisi.berawan);
  periksa('Suhu saat ini', cuaca.saatIni.suhu, 31.4);
  periksa('Tiga hari prakiraan', cuaca.harian.length, 3);
  periksa(
    'Hari kedua badai petir',
    cuaca.harian[1].kondisi,
    Kondisi.badaiPetir,
  );
  periksa('Suhu maks 31 terbaca', cuaca.harian[2].suhuMaks, 31.0);
  periksa('Peluang hujan kosong', cuaca.harian[2].peluangHujan, null);
  periksa(
    'Kode 42 tidak dikenal',
    Kondisi.dariKode(42),
    Kondisi.tidakDiketahui,
  );

  // ViewModel: server menjawab 500 -> status gagal + pesan ramah.
  final CuacaViewModel vm = CuacaViewModel(
    repositori: RepositoriCuacaOpenMeteo(
      layanan: LayananOpenMeteo(
        klien: MockClient(
          (http.Request permintaan) async => http.Response('{}', 500),
        ),
      ),
    ),
  );
  await vm.muat();
  periksa('Kode 500: status gagal', vm.status, StatusMuat.gagal);
  periksa(
    'Kode 500: pesan ramah',
    vm.pesanGalat,
    'Server cuaca sedang bermasalah. Coba lagi nanti.',
  );
  vm.dispose();
}
