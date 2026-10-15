// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 11: PENYIMPANAN LOKAL
// CONTOH 09: Studi Kasus "Cuaca Kampus Luring"
// Topik: Lanjutan Contoh 11 Pertemuan 10. Aplikasi cuaca kini:
//        - INGAT kota terakhir dan KOTA FAVORIT (shared_preferences);
//        - MENYIMPAN prakiraan terakhir setiap kota di SQLite (sqflite),
//          sehingga tetap bisa dibaca tanpa internet;
//        - menampilkan data TERSIMPAN lebih dulu (instan), lalu
//          menggantinya dengan data TERBARU dari server. Repository
//          mengirim keduanya lewat sebuah Stream (Pertemuan 3).
//        Strategi ini disebut "lokal dulu, lalu server". Jika server tidak
//        bisa dihubungi, data tersimpan tetap tampil dengan peringatan.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa repository,
//        cache SQLite, dan ViewModel tanpa internet. Lihat konsol.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad):
// 1. Proyek Flutter: jalankan sekali
//      flutter pub add http provider shared_preferences
//      flutter pub add sqflite sqflite_common_ffi_web
// 2. Khusus Chrome, jalankan sekali juga: dart run sqflite_common_ffi_web:setup
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080
//    (di HP Android cukup: flutter run). Butuh internet saat pertama.
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  await jalankanUji();

  runApp(
    MultiProvider(
      providers: [
        Provider<LayananOpenMeteo>(
          create: (BuildContext context) => LayananOpenMeteo(),
          dispose: (BuildContext context, LayananOpenMeteo layanan) =>
              layanan.tutup(),
        ),
        Provider<LayananBasisData>(
          create: (BuildContext context) => LayananBasisData(),
          dispose: (BuildContext context, LayananBasisData layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriCuaca>(
          create: (BuildContext context) => RepositoriCuacaLuring(
            layanan: context.read<LayananOpenMeteo>(),
            cache: CacheCuacaSqlite(layanan: context.read<LayananBasisData>()),
          ),
        ),
        Provider<RepositoriPreferensi>(
          create: (BuildContext context) => RepositoriPreferensiShared(),
        ),
      ],
      child: const AplikasiCuaca(),
    ),
  );
}

// ============================ MODEL ============================
// (Kota, Kondisi, CuacaSaatIni, PrakiraanHarian, dan Cuaca sama dengan
// Pertemuan 10, ditambah Kondisi.dariNama dan HasilCuaca.)

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
  final double lintang;
  final double bujur;
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

  // Kode cuaca WMO (dipakai Open-Meteo) -> kondisi.
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

  // [BARU] Nama tersimpan di database -> kondisi, misalnya 'hujan'.
  static Kondisi dariNama(String nama) {
    return Kondisi.values.asNameMap()[nama] ?? Kondisi.tidakDiketahui;
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
  final int? peluangHujan; // boleh kosong (null)
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

// [BARU] Cuaca + kapan diambil dari server + apakah ini salinan tersimpan.
class HasilCuaca {
  const HasilCuaca({
    required this.cuaca,
    required this.diperbarui,
    required this.dariCache,
  });

  final Cuaca cuaca;
  final DateTime diperbarui;
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

// [BARU] Membuka database cache sekali saja (pola Contoh 05).
class LayananBasisData {
  LayananBasisData({this.namaBerkas = 'cuaca_kampus.db'});

  final String namaBerkas;
  Future<Database>? _database;

  Future<Database> get database => _database ??= _buka();

  Future<Database> _buka() {
    return openDatabase(
      namaBerkas,
      version: 1,
      onCreate: (Database db, int versi) async {
        await db.execute('''
          CREATE TABLE cuaca_saat_ini (
            kota       TEXT PRIMARY KEY,
            suhu       REAL NOT NULL,
            kelembapan INTEGER NOT NULL,
            angin      REAL NOT NULL,
            kondisi    TEXT NOT NULL,
            diperbarui INTEGER NOT NULL
          )
        ''');
        // Kunci gabungan: satu baris untuk setiap (kota, tanggal).
        await db.execute('''
          CREATE TABLE prakiraan_harian (
            kota          TEXT NOT NULL,
            tanggal       TEXT NOT NULL,
            kondisi       TEXT NOT NULL,
            suhu_maks     REAL NOT NULL,
            suhu_min      REAL NOT NULL,
            peluang_hujan INTEGER,
            PRIMARY KEY (kota, tanggal)
          )
        ''');
      },
    );
  }

  Future<void> tutup() async {
    final Future<Database>? database = _database;
    _database = null;
    if (database == null) {
      return;
    }
    final Database db = await database;
    await db.close();
  }
}

// ============================ CACHE ============================

String duaDigit(int angka) => angka.toString().padLeft(2, '0');

// DateTime -> '2026-10-15' (urutan teks sama dengan urutan tanggal).
String teksTanggal(DateTime t) =>
    '${t.year}-${duaDigit(t.month)}-${duaDigit(t.day)}';

abstract class CacheCuaca {
  // null = kota ini belum pernah tersimpan.
  Future<HasilCuaca?> baca(Kota kota);

  Future<void> simpan(Cuaca cuaca, DateTime diperbarui);
}

class CacheCuacaSqlite implements CacheCuaca {
  CacheCuacaSqlite({required LayananBasisData layanan}) : _layanan = layanan;

  final LayananBasisData _layanan;

  @override
  Future<HasilCuaca?> baca(Kota kota) async {
    final Database db = await _layanan.database;
    final List<Map<String, Object?>> saatIni = await db.query(
      'cuaca_saat_ini',
      where: 'kota = ?',
      whereArgs: [kota.name],
    );
    if (saatIni.isEmpty) {
      return null;
    }
    final List<Map<String, Object?>> harian = await db.query(
      'prakiraan_harian',
      where: 'kota = ?',
      whereArgs: [kota.name],
      orderBy: 'tanggal',
    );
    return switch (saatIni.first) {
      {
        'suhu': final num suhu,
        'kelembapan': final int kelembapan,
        'angin': final num angin,
        'kondisi': final String kondisi,
        'diperbarui': final int diperbarui,
      } =>
        HasilCuaca(
          cuaca: Cuaca(
            kota: kota,
            saatIni: CuacaSaatIni(
              suhu: suhu.toDouble(),
              kelembapan: kelembapan,
              angin: angin.toDouble(),
              kondisi: Kondisi.dariNama(kondisi),
            ),
            harian: harian.map(_hariDariBaris).toList(),
          ),
          diperbarui: DateTime.fromMillisecondsSinceEpoch(diperbarui),
          dariCache: true,
        ),
      _ => throw FormatException('Baris cuaca tidak sesuai: ${saatIni.first}'),
    };
  }

  PrakiraanHarian _hariDariBaris(Map<String, Object?> baris) {
    return switch (baris) {
      {
        'tanggal': final String tanggal,
        'kondisi': final String kondisi,
        'suhu_maks': final num maks,
        'suhu_min': final num min,
        'peluang_hujan': final int? peluang, // NULL di SQLite -> null
      } =>
        PrakiraanHarian(
          tanggal: DateTime.parse(tanggal),
          kondisi: Kondisi.dariNama(kondisi),
          suhuMaks: maks.toDouble(),
          suhuMin: min.toDouble(),
          peluangHujan: peluang,
        ),
      _ => throw FormatException('Baris prakiraan tidak sesuai: $baris'),
    };
  }

  @override
  Future<void> simpan(Cuaca cuaca, DateTime diperbarui) async {
    final Database db = await _layanan.database;
    final String kota = cuaca.kota.name;
    // Satu transaksi: data lama diganti data baru secara utuh.
    await db.transaction((Transaction txn) async {
      // ConflictAlgorithm.replace: jika kota ini sudah ada, barisnya
      // DITIMPA (insert atau ganti, sering disebut "upsert").
      await txn.insert('cuaca_saat_ini', {
        'kota': kota,
        'suhu': cuaca.saatIni.suhu,
        'kelembapan': cuaca.saatIni.kelembapan,
        'angin': cuaca.saatIni.angin,
        'kondisi': cuaca.saatIni.kondisi.name,
        'diperbarui': diperbarui.millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      await txn.delete(
        'prakiraan_harian',
        where: 'kota = ?',
        whereArgs: [kota],
      );
      final Batch batch = txn.batch();
      for (final PrakiraanHarian hari in cuaca.harian) {
        batch.insert('prakiraan_harian', {
          'kota': kota,
          'tanggal': teksTanggal(hari.tanggal),
          'kondisi': hari.kondisi.name,
          'suhu_maks': hari.suhuMaks,
          'suhu_min': hari.suhuMin,
          'peluang_hujan': hari.peluangHujan, // boleh null
        });
      }
      await batch.commit(noResult: true);
    });
  }
}

// Versi memori, dipakai pemeriksaan.
class CacheCuacaMemori implements CacheCuaca {
  final Map<Kota, HasilCuaca> _isi = {};

  @override
  Future<HasilCuaca?> baca(Kota kota) async => _isi[kota];

  @override
  Future<void> simpan(Cuaca cuaca, DateTime diperbarui) async {
    _isi[cuaca.kota] = HasilCuaca(
      cuaca: cuaca,
      diperbarui: diperbarui,
      dariCache: true,
    );
  }
}

// ========================= REPOSITORY =========================

abstract class RepositoriCuaca {
  // Mengirim data tersimpan lebih dulu (jika ada), lalu data terbaru
  // dari server. Jika server gagal, galatnya dikirim lewat Stream.
  Stream<HasilCuaca> pantau(Kota kota);
}

class RepositoriCuacaLuring implements RepositoriCuaca {
  RepositoriCuacaLuring({
    required LayananOpenMeteo layanan,
    required CacheCuaca cache,
  }) : _layanan = layanan,
       _cache = cache;

  final LayananOpenMeteo _layanan;
  final CacheCuaca _cache;

  @override
  Stream<HasilCuaca> pantau(Kota kota) async* {
    // 1. Data tersimpan: cepat dan tidak butuh internet.
    HasilCuaca? tersimpan;
    try {
      tersimpan = await _cache.baca(kota);
    } catch (galat) {
      debugPrint('Cache gagal dibaca: $galat'); // aplikasi tetap jalan
    }
    if (tersimpan != null) {
      yield tersimpan;
    }

    // 2. Data terbaru dari server. Jika baris ini melempar exception,
    //    Stream mengirim galat itu kepada pendengarnya, lalu selesai.
    final Cuaca cuaca = await _ambilDariServer(kota);
    final DateTime sekarang = DateTime.now();
    try {
      await _cache.simpan(cuaca, sekarang);
    } catch (galat) {
      debugPrint('Cache gagal disimpan: $galat');
    }
    yield HasilCuaca(cuaca: cuaca, diperbarui: sekarang, dariCache: false);
  }

  // ---- Sama dengan RepositoriCuacaOpenMeteo di Pertemuan 10 ----

  Future<Cuaca> _ambilDariServer(Kota kota) async {
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

// [BARU] Preferensi: kota terakhir dan kota favorit.
abstract class RepositoriPreferensi {
  Future<Kota?> kotaTerakhir();

  Future<void> simpanKotaTerakhir(Kota kota);

  Future<Set<Kota>> favorit();

  Future<void> simpanFavorit(Set<Kota> favorit);
}

class RepositoriPreferensiShared implements RepositoriPreferensi {
  static const String _kunciKota = 'kota_terakhir';
  static const String _kunciFavorit = 'kota_favorit';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  @override
  Future<Kota?> kotaTerakhir() async {
    final String? nama = await _prefs.getString(_kunciKota);
    return Kota.values.asNameMap()[nama];
  }

  @override
  Future<void> simpanKotaTerakhir(Kota kota) {
    return _prefs.setString(_kunciKota, kota.name);
  }

  @override
  Future<Set<Kota>> favorit() async {
    final List<String> nama = await _prefs.getStringList(_kunciFavorit) ?? [];
    final Map<String, Kota> peta = Kota.values.asNameMap();
    // whereType<Kota>() membuang nama yang tidak dikenal (null).
    return nama.map((String n) => peta[n]).whereType<Kota>().toSet();
  }

  @override
  Future<void> simpanFavorit(Set<Kota> favorit) {
    return _prefs.setStringList(_kunciFavorit, [
      for (final Kota kota in favorit) kota.name,
    ]);
  }
}

class RepositoriPreferensiMemori implements RepositoriPreferensi {
  Kota? _kota;
  Set<Kota> _favorit = {};

  @override
  Future<Kota?> kotaTerakhir() async => _kota;

  @override
  Future<void> simpanKotaTerakhir(Kota kota) async {
    _kota = kota;
  }

  @override
  Future<Set<Kota>> favorit() async => {..._favorit};

  @override
  Future<void> simpanFavorit(Set<Kota> favorit) async {
    _favorit = {...favorit};
  }
}

// ========================= VIEWMODEL =========================

enum StatusMuat { memuat, berhasil, gagal }

String pesanRamah(Object galat) {
  return switch (galat) {
    TimeoutException() => 'Server cuaca terlalu lama menjawab.',
    ApiException(kodeStatus: >= 500) => 'Server cuaca sedang bermasalah.',
    ApiException() => 'Permintaan data cuaca ditolak server.',
    FormatException() => 'Data cuaca tidak bisa dibaca.',
    http.ClientException() => 'Tidak dapat terhubung ke internet.',
    _ => 'Terjadi kesalahan yang tidak terduga.',
  };
}

class CuacaViewModel extends ChangeNotifier {
  CuacaViewModel({
    required RepositoriCuaca repositori,
    required RepositoriPreferensi preferensi,
  }) : _repositori = repositori,
       _preferensi = preferensi;

  final RepositoriCuaca _repositori;
  final RepositoriPreferensi _preferensi;

  bool _siap = false; // preferensi sudah dibaca?
  Kota _kota = Kota.jakarta;
  Set<Kota> _favorit = {};
  StatusMuat _status = StatusMuat.memuat;
  HasilCuaca? _hasil;
  bool _memperbarui = false; // sedang menunggu data dari server?
  String _peringatan = ''; // gagal memperbarui, tetapi masih ada data
  String _pesanGalat = ''; // gagal dan tidak ada data sama sekali
  int _nomorPermintaan = 0;
  bool _sudahDibuang = false;

  bool get siap => _siap;
  Kota get kota => _kota;
  StatusMuat get status => _status;
  HasilCuaca? get hasil => _hasil;
  bool get memperbarui => _memperbarui;
  String get peringatan => _peringatan;
  String get pesanGalat => _pesanGalat;
  bool get kotaIniFavorit => _favorit.contains(_kota);
  bool favorit(Kota kota) => _favorit.contains(kota);

  // Kota favorit di depan, sisanya mengikuti urutan biasa.
  List<Kota> get urutanKota => [
    ...Kota.values.where(_favorit.contains),
    ...Kota.values.where((Kota kota) => !_favorit.contains(kota)),
  ];

  // Dipanggil sekali saat aplikasi dibuka.
  Future<void> mulai() async {
    try {
      _kota = await _preferensi.kotaTerakhir() ?? Kota.jakarta;
      _favorit = await _preferensi.favorit();
    } catch (galat) {
      debugPrint('Preferensi gagal dibaca: $galat');
    }
    if (_sudahDibuang) {
      return;
    }
    _siap = true;
    await muat();
  }

  Future<void> muat({bool tampilkanMemuat = true}) async {
    final int nomor = ++_nomorPermintaan;
    if (tampilkanMemuat) {
      _status = StatusMuat.memuat;
      _hasil = null;
    }
    _memperbarui = true;
    _peringatan = '';
    notifyListeners();

    try {
      // await for: menerima nilai Stream satu per satu (Pertemuan 3).
      await for (final HasilCuaca hasil in _repositori.pantau(_kota)) {
        if (_sudahDibuang || nomor != _nomorPermintaan) {
          return; // keluar dari await for = berhenti mendengarkan
        }
        final HasilCuaca? tampil = _hasil;
        if (hasil.dariCache && tampil != null && !tampil.dariCache) {
          continue; // yang tampil sudah lebih baru daripada salinan
        }
        _hasil = hasil;
        _status = StatusMuat.berhasil;
        notifyListeners();
      }
    } catch (galat) {
      if (_sudahDibuang || nomor != _nomorPermintaan) {
        return;
      }
      debugPrint('Galat saat memuat cuaca: $galat');
      if (_hasil != null) {
        _peringatan = pesanRamah(galat); // data lama tetap tampil
      } else {
        _pesanGalat = pesanRamah(galat);
        _status = StatusMuat.gagal;
      }
    }
    if (_sudahDibuang || nomor != _nomorPermintaan) {
      return;
    }
    _memperbarui = false;
    notifyListeners();
  }

  Future<void> segarkan() => muat(tampilkanMemuat: false);

  void pilihKota(Kota kota) {
    if (kota == _kota) {
      return;
    }
    _kota = kota;
    unawaited(_preferensi.simpanKotaTerakhir(kota)); // diingat
    muat();
  }

  Future<void> alihkanFavorit() async {
    final Set<Kota> baru = {..._favorit};
    if (!baru.remove(_kota)) {
      baru.add(_kota); // belum favorit -> jadikan favorit
    }
    _favorit = baru;
    notifyListeners();
    await _preferensi.simpanFavorit(baru);
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
        create: (BuildContext context) => CuacaViewModel(
          repositori: context.read<RepositoriCuaca>(),
          preferensi: context.read<RepositoriPreferensi>(),
        )..mulai(),
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
              Text(
                '${vm.pesanGalat}\nBelum ada data tersimpan untuk kota ini.',
                textAlign: TextAlign.center,
              ),
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
        child: IsiCuaca(hasil: vm.hasil!),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuaca Kampus'),
        actions: [
          IconButton(
            onPressed: vm.siap
                ? () => context.read<CuacaViewModel>().alihkanFavorit()
                : null,
            tooltip: vm.kotaIniFavorit
                ? 'Hapus dari favorit'
                : 'Jadikan favorit',
            icon: Icon(vm.kotaIniFavorit ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: Column(
        children: [
          if (vm.siap) const PilihanKota(),
          // Garis tipis selama data terbaru masih ditunggu.
          if (vm.memperbarui && vm.status == StatusMuat.berhasil)
            const LinearProgressIndicator(minHeight: 2),
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
    final CuacaViewModel vm = context.watch<CuacaViewModel>();

    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          for (final Kota kota in vm.urutanKota)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                avatar: vm.favorit(kota)
                    ? const Icon(Icons.star, size: 18)
                    : null,
                label: Text(kota.nama),
                selected: kota == vm.kota,
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

String formatWaktu(DateTime waktu) {
  return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)} pukul '
      '${duaDigit(waktu.hour)}.${duaDigit(waktu.minute)}';
}

class IsiCuaca extends StatelessWidget {
  const IsiCuaca({super.key, required this.hasil});

  final HasilCuaca hasil;

  String _namaHari(int urutan, DateTime tanggal) {
    if (urutan == 0) return 'Hari ini';
    if (urutan == 1) return 'Besok';
    return namaHariIndonesia[tanggal.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final Cuaca cuaca = hasil.cuaca;
    final String peringatan = context.select(
      (CuacaViewModel vm) => vm.peringatan,
    );

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        if (hasil.dariCache || peringatan.isNotEmpty)
          SpandukLuring(hasil: hasil, peringatan: peringatan),
        KartuSaatIni(hasil: hasil),
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

class SpandukLuring extends StatelessWidget {
  const SpandukLuring({
    super.key,
    required this.hasil,
    required this.peringatan,
  });

  final HasilCuaca hasil;
  final String peringatan;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final String keterangan = peringatan.isEmpty
        ? 'Menampilkan data tersimpan. Sedang memperbarui...'
        : 'Gagal memperbarui: $peringatan Data terakhir dari '
              '${formatWaktu(hasil.diperbarui)}.';

    return Card.filled(
      color: warna.tertiaryContainer,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          peringatan.isEmpty ? Icons.history : Icons.cloud_off,
          color: warna.onTertiaryContainer,
        ),
        title: Text(
          keterangan,
          style: TextStyle(color: warna.onTertiaryContainer),
        ),
      ),
    );
  }
}

class KartuSaatIni extends StatelessWidget {
  const KartuSaatIni({super.key, required this.hasil});

  final HasilCuaca hasil;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gayaTeks = Theme.of(context).textTheme;
    final CuacaSaatIni saatIni = hasil.cuaca.saatIni;

    return Card.filled(
      color: warna.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasil.cuaca.kota.nama,
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
              'Diperbarui ${formatWaktu(hasil.diperbarui)}',
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
// Tidak butuh internet: "server" diganti MockClient, cache SQLite memakai
// database di MEMORI, dan preferensi memakai versi memori.

const String contohJsonCuaca = '''
{
  "current": {
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
  bool serverHidup = true;
  final LayananOpenMeteo layanan = LayananOpenMeteo(
    klien: MockClient((http.Request permintaan) async {
      if (!serverHidup) {
        throw http.ClientException('Tidak ada koneksi');
      }
      return http.Response(contohJsonCuaca, 200);
    }),
  );

  // ---- 1. Repository + cache memori ----
  final CacheCuacaMemori cache = CacheCuacaMemori();
  final RepositoriCuaca repo = RepositoriCuacaLuring(
    layanan: layanan,
    cache: cache,
  );
  try {
    final List<HasilCuaca> pertama = await repo.pantau(Kota.samarinda).toList();
    periksa('Belum tersimpan: 1 data (dari server)', pertama.length, 1);
    periksa('Data server bukan salinan', pertama.first.dariCache, false);
    periksa(
      'Data server ikut disimpan',
      (await cache.baca(Kota.samarinda))?.cuaca.saatIni.suhu,
      31.4,
    );

    // toList() menunggu Stream selesai dan mengumpulkan semua nilainya.
    final List<HasilCuaca> kedua = await repo.pantau(Kota.samarinda).toList();
    periksa(
      'Sudah tersimpan: salinan dulu, lalu server',
      kedua.map((HasilCuaca hasil) => hasil.dariCache).join(', '),
      'true, false',
    );

    serverHidup = false;
    final List<String> kejadian = [];
    try {
      await for (final HasilCuaca hasil in repo.pantau(Kota.samarinda)) {
        kejadian.add(hasil.dariCache ? 'salinan' : 'server');
      }
    } on http.ClientException {
      kejadian.add('galat');
    }
    periksa(
      'Server mati: salinan, lalu galat',
      kejadian.join(', '),
      'salinan, galat',
    );
  } catch (galat) {
    debugPrint('GAGAL  uji repository berhenti: $galat');
  }

  // ---- 2. ViewModel ----
  final RepositoriPreferensiMemori preferensi = RepositoriPreferensiMemori();
  await preferensi.simpanKotaTerakhir(Kota.samarinda);
  final CuacaViewModel vm = CuacaViewModel(
    repositori: repo,
    preferensi: preferensi,
  );
  try {
    await vm.mulai(); // server masih mati, tetapi Samarinda sudah tersimpan
    periksa('Kota terakhir diingat', vm.kota, Kota.samarinda);
    periksa('Luring: tetap berhasil', vm.status, StatusMuat.berhasil);
    periksa('Luring: memakai salinan', vm.hasil?.dariCache, true);
    periksa(
      'Luring: ada peringatan',
      vm.peringatan,
      'Tidak dapat terhubung ke internet.',
    );

    vm.pilihKota(Kota.medan); // Medan belum pernah tersimpan
    await Future<void>.delayed(const Duration(milliseconds: 50));
    periksa('Kota baru tanpa salinan: gagal', vm.status, StatusMuat.gagal);
    periksa(
      'Pilihan kota disimpan',
      await preferensi.kotaTerakhir(),
      Kota.medan,
    );

    await vm.alihkanFavorit();
    periksa(
      'Medan menjadi favorit',
      (await preferensi.favorit()).contains(Kota.medan),
      true,
    );
    periksa('Favorit di urutan pertama', vm.urutanKota.first, Kota.medan);
  } catch (galat) {
    debugPrint('GAGAL  uji ViewModel berhenti: $galat');
  } finally {
    vm.dispose();
  }

  // ---- 3. Cache SQLite sungguhan (database di memori) ----
  final LayananBasisData basisData = LayananBasisData(
    namaBerkas: inMemoryDatabasePath,
  );
  final CacheCuaca cacheSqlite = CacheCuacaSqlite(layanan: basisData);
  try {
    serverHidup = true;
    final HasilCuaca dariServer = await RepositoriCuacaLuring(
      layanan: layanan,
      cache: cacheSqlite,
    ).pantau(Kota.denpasar).last;
    // Disimpan dua kali: baris lama harus DITIMPA, bukan digandakan.
    await cacheSqlite.simpan(dariServer.cuaca, dariServer.diperbarui);
    final HasilCuaca? dibaca = await cacheSqlite.baca(Kota.denpasar);
    periksa('SQLite: hari tidak berganda', dibaca?.cuaca.harian.length, 3);
    periksa(
      'SQLite: kondisi terbaca lagi',
      dibaca?.cuaca.harian[1].kondisi,
      Kondisi.badaiPetir,
    );
    periksa(
      'SQLite: NULL tetap null',
      dibaca?.cuaca.harian[2].peluangHujan,
      null,
    );
    periksa(
      'SQLite: kota lain kosong',
      await cacheSqlite.baca(Kota.medan),
      null,
    );
  } catch (galat) {
    debugPrint('GAGAL  uji SQLite berhenti: $galat');
  } finally {
    await basisData.tutup();
    layanan.tutup();
  }
}
