// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 07: Studi Kasus "Cuaca Kampus 1.0.0" Siap Rilis
// Topik: Aplikasi "Cuaca Kampus" dari Pertemuan 10 dirapikan menjadi
//        rilis 1.0.0. Fiturnya TIDAK bertambah. Yang bertambah adalah
//        hal-hal yang dibutuhkan aplikasi yang dipakai orang lain:
//        1. konfigurasi lewat --dart-define: LINGKUNGAN=produksi memakai
//           Open-Meteo, LINGKUNGAN=pengembangan memakai data palsu
//           (tanpa internet) dan diberi pita "BUILD UJI";
//        2. log hanya di mode debug (catatDebug), bukan print/debugPrint;
//        3. jaring pengaman galat + pengganti layar merah (Contoh 03);
//        4. halaman Tentang: versi, atribusi Open-Meteo, kebijakan
//           privasi, dan lisensi sumber terbuka (Contoh 04);
//        5. cek pembaruan dari berkas info_rilis.json di repositori
//           GitHub mata kuliah ini (Contoh 05).
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Butuh internet (data cuaca dan info rilis diambil dari server).
// B. Proyek Flutter: jalankan sekali `flutter pub add http provider`,
//    salin berkas ini ke lib/main.dart, lalu coba:
//    flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan
//    flutter run -d chrome --release
//    flutter build web
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ============================ MAIN ============================

final PelaporGalat pelapor = PelaporGalat();

void main() {
  if (kIsWeb) {
    // Di web, galat asinkron yang lolos ditangkap lewat zona (Contoh 03).
    runZonedGuarded(
      mulaiAplikasi,
      (Object galat, StackTrace jejak) =>
          pelapor.catat(galat, jejak, sumber: 'async'),
    );
  } else {
    mulaiAplikasi();
  }
}

void mulaiAplikasi() {
  WidgetsFlutterBinding.ensureInitialized();
  pasangPenangkapGalat();
  LicenseRegistry.addLicense(lisensiOpenMeteo);

  final Konfigurasi konfigurasi = Konfigurasi.dariLingkungan();
  catatDebug(
    'Mulai: $namaAplikasi ${versiAplikasi.lengkap}, '
    'lingkungan ${konfigurasi.lingkungan.name}',
  );
  runApp(
    MultiProvider(
      providers: buatPenyedia(konfigurasi),
      child: AplikasiCuaca(konfigurasi: konfigurasi),
    ),
  );
}

// ========================= KONFIGURASI =========================

// Di proyek sungguhan, nama dan versi dibaca dari pubspec.yaml dengan
// paket package_info_plus (Modul Bagian 5.4).
const String namaAplikasi = 'Cuaca Kampus';
final Versi versiAplikasi = Versi.urai('1.0.0+1');

// Berkas info rilis di repositori GitHub mata kuliah ini. Untuk proyek
// Anda sendiri: simpan berkas serupa di repositori Anda.
const String alamatInfoRilis =
    'https://raw.githubusercontent.com/antonprafanto/mobile2026/main/'
    'pertemuan_15_build_rilis_dan_finalisasi/data/info_rilis_cuaca_kampus.json';

enum Lingkungan { pengembangan, produksi }

class Konfigurasi {
  const Konfigurasi({required this.lingkungan});

  final Lingkungan lingkungan;

  // WAJIB const (Contoh 02). Bawaan = produksi, agar build rilis yang
  // lupa diberi --dart-define tetap memakai data sungguhan.
  static const String _teksLingkungan = String.fromEnvironment(
    'LINGKUNGAN',
    defaultValue: 'produksi',
  );

  static Konfigurasi dariLingkungan() {
    final Lingkungan? lingkungan = Lingkungan.values
        .asNameMap()[_teksLingkungan];
    if (lingkungan == null) {
      // Salah konfigurasi build: gagal sejak awal agar langsung ketahuan
      // saat diuji, bukan diam-diam memakai lingkungan yang salah.
      throw StateError('LINGKUNGAN "$_teksLingkungan" tidak dikenal');
    }
    return Konfigurasi(lingkungan: lingkungan);
  }
}

/// Log yang hanya ada di mode debug (dibuang compiler di build rilis).
void catatDebug(String pesan) {
  if (kDebugMode) debugPrint('[debug] $pesan');
}

/// Akar komposisi (Pertemuan 12): satu-satunya tempat yang memilih
/// implementasi menurut lingkungan.
List<SingleChildWidget> buatPenyedia(Konfigurasi konfigurasi) {
  return [
    Provider<Konfigurasi>.value(value: konfigurasi),
    ...switch (konfigurasi.lingkungan) {
      Lingkungan.produksi => [
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
        Provider<SumberInfoRilis>(
          create: (BuildContext context) =>
              LayananInfoRilis(alamat: Uri.parse(alamatInfoRilis)),
          dispose: (BuildContext context, SumberInfoRilis sumber) =>
              sumber.tutup(),
        ),
      ],
      Lingkungan.pengembangan => [
        Provider<RepositoriCuaca>(
          create: (BuildContext context) => RepositoriCuacaPalsu(),
        ),
        Provider<SumberInfoRilis>(
          create: (BuildContext context) => const TanpaInfoRilis(),
        ),
      ],
    },
  ];
}

// ======================== PELAPOR GALAT ========================

class PelaporGalat {
  final List<String> catatan = [];

  void catat(Object galat, StackTrace? jejak, {required String sumber}) {
    // Aplikasi sungguhan mengirim galat + jejak ke layanan pelaporan
    // (misalnya Crashlytics atau Sentry) di sini.
    catatan.add('$sumber: $galat');
    catatDebug('[pelapor] $sumber: $galat');
  }
}

void pasangPenangkapGalat() {
  FlutterError.onError = (FlutterErrorDetails rincian) {
    FlutterError.presentError(rincian);
    pelapor.catat(rincian.exception, rincian.stack, sumber: 'widget');
  };
  PlatformDispatcher.instance.onError = (Object galat, StackTrace jejak) {
    pelapor.catat(galat, jejak, sumber: 'async');
    return true;
  };
  ErrorWidget.builder = (FlutterErrorDetails rincian) =>
      KotakGalatRamah(rincian: rincian);
}

class KotakGalatRamah extends StatelessWidget {
  const KotakGalatRamah({super.key, required this.rincian});

  final FlutterErrorDetails rincian;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Colors.orange.shade50,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            kDebugMode
                ? 'Bagian ini gagal ditampilkan: '
                      '${rincian.exceptionAsString()}'
                : 'Bagian ini gagal ditampilkan. Laporan sudah dicatat.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }
}

Stream<LicenseEntry> lisensiOpenMeteo() async* {
  yield const LicenseEntryWithLineBreaks(
    ['Data cuaca Open-Meteo'],
    'Data cuaca disediakan oleh Open-Meteo.com dan dilisensikan dengan '
    'Creative Commons Attribution 4.0 International (CC BY 4.0).\n\n'
    'https://open-meteo.com/en/licence',
  );
}

// ======================== VERSI (Contoh 01) ========================

class Versi implements Comparable<Versi> {
  const Versi(this.mayor, this.minor, this.patch, [this.build = 1]);

  final int mayor;
  final int minor;
  final int patch;
  final int build;

  static final RegExp _pola = RegExp(r'^(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$');

  static Versi urai(String teks) {
    final RegExpMatch? cocok = _pola.firstMatch(teks.trim());
    if (cocok == null) {
      throw FormatException('format harus MAYOR.MINOR.PATCH+BUILD', teks);
    }
    return Versi(
      int.parse(cocok.group(1)!),
      int.parse(cocok.group(2)!),
      int.parse(cocok.group(3)!),
      int.parse(cocok.group(4) ?? '1'),
    );
  }

  String get nama => '$mayor.$minor.$patch';
  String get lengkap => '$nama+$build';

  @override
  int compareTo(Versi lain) {
    if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);
    if (minor != lain.minor) return minor.compareTo(lain.minor);
    return patch.compareTo(lain.patch);
  }

  bool lebihLamaDari(Versi lain) => compareTo(lain) < 0;
}

enum Keputusan { terbaru, disarankan, wajib }

Keputusan putuskanPembaruan({
  required Versi terpasang,
  required Versi terbaru,
  required Versi minimum,
}) {
  if (terpasang.lebihLamaDari(minimum)) return Keputusan.wajib;
  if (terpasang.lebihLamaDari(terbaru)) return Keputusan.disarankan;
  return Keputusan.terbaru;
}

// ===================== INFO RILIS (Contoh 05) =====================

class InfoRilis {
  const InfoRilis({
    required this.terbaru,
    required this.minimum,
    required this.catatan,
    required this.tautan,
  });

  final Versi terbaru;
  final Versi minimum;
  final String catatan;
  final Uri tautan;

  static InfoRilis dariJson(Object? json) {
    return switch (json) {
      {
        'versi_terbaru': final String terbaru,
        'versi_minimum': final String minimum,
        'catatan': final String catatan,
        'tautan': final String tautan,
      } =>
        InfoRilis(
          terbaru: Versi.urai(terbaru),
          minimum: Versi.urai(minimum),
          catatan: catatan,
          tautan: Uri.parse(tautan),
        ),
      _ => throw const FormatException('Bentuk info_rilis.json tidak dikenal'),
    };
  }
}

/// Kontrak: dari mana info rilis diambil. null = tidak bisa diperiksa.
abstract class SumberInfoRilis {
  const SumberInfoRilis();

  Future<InfoRilis?> ambil();

  void tutup() {}
}

class LayananInfoRilis extends SumberInfoRilis {
  LayananInfoRilis({http.Client? klien, required this.alamat})
    : _klien = klien ?? http.Client();

  final http.Client _klien;
  final Uri alamat;

  @override
  Future<InfoRilis?> ambil() async {
    try {
      final http.Response respons = await _klien
          .get(alamat)
          .timeout(const Duration(seconds: 5));
      if (respons.statusCode != 200) {
        throw http.ClientException('kode status ${respons.statusCode}');
      }
      return InfoRilis.dariJson(jsonDecode(respons.body));
    } on Exception catch (galat) {
      // Gagal memeriksa pembaruan bukan alasan untuk mengganggu pengguna.
      catatDebug('Cek pembaruan gagal: $galat');
      return null;
    }
  }

  @override
  void tutup() => _klien.close();
}

/// Dipakai di lingkungan pengembangan: tidak pernah memeriksa.
class TanpaInfoRilis extends SumberInfoRilis {
  const TanpaInfoRilis();

  @override
  Future<InfoRilis?> ambil() async => null;
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
      'timezone': 'auto',
      'forecast_days': '7',
    });
    catatDebug('GET $alamat'); // Pertemuan 10 memakai debugPrint di sini

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
  RepositoriCuacaOpenMeteo({required this._layanan});

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
  // weather_code[i], dan seterusnya adalah milik hari ke-i.
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

/// Data palsu untuk lingkungan pengembangan: tanpa internet, isinya
/// selalu sama, sehingga tampilan mudah diperiksa dan didemokan.
class RepositoriCuacaPalsu implements RepositoriCuaca {
  @override
  Future<Cuaca> ambil(Kota kota) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final int i = kota.index;
    final DateTime hariIni = DateTime(2026, 10, 19);
    return Cuaca(
      kota: kota,
      saatIni: CuacaSaatIni(
        suhu: 27.0 + i,
        kelembapan: 70 + i,
        angin: 5.0 + i,
        kondisi: Kondisi.values[i % 4],
      ),
      harian: [
        for (int hari = 0; hari < 7; hari++)
          PrakiraanHarian(
            tanggal: hariIni.add(Duration(days: hari)),
            kondisi: Kondisi.values[(i + hari) % 8],
            suhuMaks: 31.0 + hari % 3,
            suhuMin: 23.0 + hari % 2,
            peluangHujan: hari == 3 ? null : 10 * hari,
          ),
      ],
    );
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
  CuacaViewModel({required this._repositori});

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

  Future<void> muat({bool tampilkanMemuat = true}) async {
    final int nomor = ++_nomorPermintaan;
    if (tampilkanMemuat) {
      _status = StatusMuat.memuat;
      notifyListeners();
    }
    try {
      final Cuaca cuaca = await _repositori.ambil(_kota);
      if (_sudahDibuang || nomor != _nomorPermintaan) return;
      _cuaca = cuaca;
      _diperbarui = DateTime.now();
      _status = StatusMuat.berhasil;
    } catch (galat, jejak) {
      // Exception (internet putus, server bermasalah) memang DIDUGA:
      // cukup pesan ramah. Error (misalnya TypeError) berarti ada BUG di
      // kode kita: tetap diberi pesan ramah, tetapi juga dilaporkan.
      if (galat is Error) pelapor.catat(galat, jejak, sumber: 'muat cuaca');
      if (_sudahDibuang || nomor != _nomorPermintaan) return;
      catatDebug('Galat saat memuat cuaca: $galat');
      _pesanGalat = pesanRamah(galat);
      _status = StatusMuat.gagal;
    }
    notifyListeners();
  }

  Future<void> segarkan() => muat(tampilkanMemuat: false);

  void pilihKota(Kota kota) {
    if (kota == _kota) return;
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
  const AplikasiCuaca({super.key, required this.konfigurasi});

  final Konfigurasi konfigurasi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: namaAplikasi,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        if (konfigurasi.lingkungan == Lingkungan.pengembangan) {
          return Banner(
            message: 'BUILD UJI',
            location: BannerLocation.bottomStart,
            child: child!,
          );
        }
        return child!;
      },
      home: ChangeNotifierProvider(
        create: (BuildContext context) =>
            CuacaViewModel(repositori: context.read<RepositoriCuaca>())..muat(),
        child: const HalamanCuaca(),
      ),
    );
  }
}

class HalamanCuaca extends StatefulWidget {
  const HalamanCuaca({super.key});

  @override
  State<HalamanCuaca> createState() => _HalamanCuacaState();
}

class _HalamanCuacaState extends State<HalamanCuaca> {
  @override
  void initState() {
    super.initState();
    _periksaPembaruan(); // sekali, saat aplikasi dibuka
  }

  Future<void> _periksaPembaruan() async {
    final InfoRilis? info = await context.read<SumberInfoRilis>().ambil();
    if (info == null || !mounted) return;
    switch (putuskanPembaruan(
      terpasang: versiAplikasi,
      terbaru: info.terbaru,
      minimum: info.minimum,
    )) {
      case Keputusan.terbaru:
        break;
      case Keputusan.disarankan:
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            leading: const Icon(Icons.system_update),
            content: Text(
              'Versi ${info.terbaru.nama} tersedia. ${info.catatan}',
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('Nanti'),
              ),
              FilledButton(
                onPressed: () => _salinTautan(info.tautan),
                child: const Text('Perbarui'),
              ),
            ],
          ),
        );
      case Keputusan.wajib:
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Perbarui aplikasi'),
              content: Text(
                'Versi ${versiAplikasi.nama} sudah tidak didukung. '
                'Perbarui ke versi ${info.terbaru.nama}.',
              ),
              actions: [
                FilledButton(
                  onPressed: () => _salinTautan(info.tautan),
                  child: const Text('Salin tautan unduhan'),
                ),
              ],
            ),
          ),
        );
    }
  }

  Future<void> _salinTautan(Uri tautan) async {
    // Di proyek sungguhan: launchUrl(tautan) dari paket url_launcher
    // (Pertemuan 13). Di sini tautannya disalin agar bisa dibuka sendiri.
    await Clipboard.setData(ClipboardData(text: '$tautan'));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(const SnackBar(content: Text('Tautan unduhan disalin.')));
  }

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
      appBar: AppBar(
        title: const Text(namaAplikasi),
        actions: [
          IconButton(
            tooltip: 'Tentang aplikasi',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HalamanTentang(),
              ),
            ),
          ),
        ],
      ),
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
    return namaHariIndonesia[tanggal.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;

    return ListView(
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
        // Atribusi WAJIB di dekat data yang ditampilkan (lisensi CC BY 4.0).
        Text(
          'Data cuaca oleh Open-Meteo.com (CC BY 4.0). Tarik ke bawah '
          'untuk menyegarkan.',
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

// ======================= HALAMAN TENTANG =======================

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final Lingkungan lingkungan = context.watch<Konfigurasi>().lingkungan;
    const Widget ikon = CircleAvatar(
      radius: 28,
      child: Icon(Icons.wb_sunny_outlined, size: 32),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Center(child: ikon),
          const SizedBox(height: 8),
          Center(
            child: Text(
              namaAplikasi,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Center(
            child: Text(
              'Versi ${versiAplikasi.nama} (build ${versiAplikasi.build})',
            ),
          ),
          if (lingkungan != Lingkungan.produksi)
            Center(child: Text('Lingkungan: ${lingkungan.name}')),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.cloud_outlined),
            title: Text('Data cuaca oleh Open-Meteo.com'),
            subtitle: Text('Lisensi CC BY 4.0'),
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Kebijakan privasi'),
            subtitle: Text(
              'Aplikasi ini tidak meminta akun dan tidak mengumpulkan data '
              'pribadi. Koordinat kota kampus yang Anda pilih dikirim ke '
              'Open-Meteo.com untuk mengambil prakiraan cuaca.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Lisensi sumber terbuka'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLicensePage(
              context: context,
              applicationName: namaAplikasi,
              applicationVersion: versiAplikasi.nama,
              applicationIcon: const Padding(
                padding: EdgeInsets.all(8),
                child: ikon,
              ),
              applicationLegalese: '© 2026 Tim Cuaca Kampus',
            ),
          ),
        ],
      ),
    );
  }
}
