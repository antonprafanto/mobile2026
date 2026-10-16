// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 02: Mode Build dan Konfigurasi dengan --dart-define
// Topik: Satu kode yang sama bisa dijalankan dengan cara berbeda TANPA
//        mengubah satu baris pun:
//        1. MODE BUILD (debug, profile, release) dibaca dari konstanta
//           kDebugMode, kProfileMode, dan kReleaseMode;
//        2. assert() dan isi `if (kDebugMode)` hanya berjalan di mode
//           debug; di build rilis keduanya dibuang compiler;
//        3. KONFIGURASI diberikan saat menjalankan atau mem-build:
//              flutter run --dart-define=LINGKUNGAN=pengembangan
//           lalu dibaca dengan `const String.fromEnvironment(...)`;
//        4. nilai yang salah ketik (misalnya "produksii") langsung
//           ketahuan, bukan diam-diam dianggap nilai bawaan;
//        5. pita "BUILD UJI" agar build untuk pengembangan tidak
//           tertukar dengan build sungguhan.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. DartPad: tempel seluruh isi berkas ini, klik Run. DartPad selalu
//    memakai mode DEBUG dan tidak bisa diberi --dart-define, jadi yang
//    tampil adalah nilai bawaan.
// B. Proyek Flutter: salin ke lib/main.dart, lalu coba satu per satu:
//    flutter run -d chrome
//    flutter run -d chrome --dart-define=LINGKUNGAN=pengembangan
//    flutter run -d chrome --dart-define=LINGKUNGAN=produksii
//    flutter run -d chrome --release
//    flutter run -d chrome --dart-define-from-file=config/uji.json
//    (isi config/uji.json: {"LINGKUNGAN": "pengembangan",
//                           "ALAMAT_API": "http://localhost:8080"})
// =====================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  final Konfigurasi konfigurasi;
  try {
    konfigurasi = Konfigurasi.dariLingkungan();
  } on KonfigurasiSalah catch (galat) {
    // Lebih baik aplikasi menolak berjalan dengan pesan yang jelas,
    // daripada diam-diam memakai alamat atau data yang salah.
    runApp(LayarKonfigurasiSalah(pesan: galat.pesan));
    return;
  }
  catatDebug('Mulai: ${konfigurasi.lingkungan.name}, ${konfigurasi.alamatApi}');
  runApp(AplikasiInfoBuild(konfigurasi: konfigurasi));
}

// ========================= KONFIGURASI =========================

enum Lingkungan { pengembangan, produksi }

class KonfigurasiSalah implements Exception {
  const KonfigurasiSalah(this.pesan);

  final String pesan;
}

class Konfigurasi {
  const Konfigurasi({
    required this.lingkungan,
    required this.alamatApi,
    required this.logRinci,
  });

  final Lingkungan lingkungan;
  final Uri alamatApi;
  final bool logRinci;

  // WAJIB `const`. Nilai --dart-define ditanamkan ke kode saat dikompilasi.
  // Tanpa const, nilainya tidak dijamin terbaca di aplikasi rilis
  // Android/iOS, dan di web malah melempar UnsupportedError.
  // Nilai bawaan sengaja dipilih yang AMAN untuk rilis: lupa menulis
  // --dart-define tidak boleh menghasilkan aplikasi rilis berisi data uji.
  static const String _teksLingkungan = String.fromEnvironment(
    'LINGKUNGAN',
    defaultValue: 'produksi',
  );
  static const String _teksAlamat = String.fromEnvironment(
    'ALAMAT_API',
    defaultValue: 'https://dummyjson.com',
  );
  static const bool _logRinci = bool.fromEnvironment('LOG_RINCI');

  static Konfigurasi dariLingkungan() {
    // asNameMap(): {'pengembangan': Lingkungan.pengembangan, ...}
    final Lingkungan? lingkungan = Lingkungan.values
        .asNameMap()[_teksLingkungan];
    if (lingkungan == null) {
      throw KonfigurasiSalah(
        'LINGKUNGAN "$_teksLingkungan" tidak dikenal. '
        'Pilih: ${Lingkungan.values.map((l) => l.name).join(' atau ')}.',
      );
    }
    final Uri? alamat = Uri.tryParse(_teksAlamat);
    if (alamat == null || alamat.host.isEmpty) {
      throw KonfigurasiSalah('ALAMAT_API "$_teksAlamat" tidak valid.');
    }
    // Aturan keamanan: data sungguhan hanya lewat https.
    if (lingkungan == Lingkungan.produksi && alamat.scheme != 'https') {
      throw KonfigurasiSalah('Lingkungan produksi wajib memakai https://.');
    }
    return Konfigurasi(
      lingkungan: lingkungan,
      alamatApi: alamat,
      logRinci: _logRinci,
    );
  }
}

// ========================= MODE BUILD =========================

String get namaModeBuild {
  if (kReleaseMode) return 'Release';
  if (kProfileMode) return 'Profile';
  return 'Debug';
}

/// Log yang HANYA ada di mode debug. kDebugMode adalah konstanta, jadi di
/// build rilis seluruh isi `if` ini dibuang compiler. Catatan: debugPrint
/// sendiri TIDAK otomatis hilang di rilis; tanpa `if` ini, isinya tetap
/// tertulis di log perangkat dan bisa dibaca orang lain.
void catatDebug(String pesan) {
  if (kDebugMode) {
    debugPrint('[debug] $pesan');
  }
}

/// assert() hanya dievaluasi di mode debug. Fungsi ini menandai bahwa
/// pemeriksaan assert benar-benar dijalankan.
bool _assertDijalankan = false;

bool _tandaiAssert() {
  _assertDijalankan = true;
  return true;
}

// ============================ VIEW ============================

class AplikasiInfoBuild extends StatelessWidget {
  const AplikasiInfoBuild({super.key, required this.konfigurasi});

  final Konfigurasi konfigurasi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Pita DEBUG bawaan dimatikan; pita lingkungan di bawah lebih jujur.
      debugShowCheckedModeBanner: false,
      title: 'Info Build',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      builder: (BuildContext context, Widget? child) {
        if (konfigurasi.lingkungan == Lingkungan.pengembangan) {
          // Pesan pita maksimal sekitar 10 huruf agar tidak terpotong.
          return Banner(
            message: 'BUILD UJI',
            location: BannerLocation.topEnd,
            child: child!,
          );
        }
        return child!;
      },
      home: HalamanInfoBuild(konfigurasi: konfigurasi),
    );
  }
}

class HalamanInfoBuild extends StatelessWidget {
  const HalamanInfoBuild({super.key, required this.konfigurasi});

  final Konfigurasi konfigurasi;

  @override
  Widget build(BuildContext context) {
    assert(_tandaiAssert());
    final String platform = kIsWeb ? 'web' : defaultTargetPlatform.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Info Build')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ListTile(
            leading: const Icon(Icons.build_circle_outlined),
            title: Text('Mode build: $namaModeBuild'),
            subtitle: const Text(
              'Debug: hot reload dan pesan galat lengkap. '
              'Release: cepat, kecil, siap dibagikan.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.devices_outlined),
            title: Text('Platform: $platform'),
          ),
          ListTile(
            leading: const Icon(Icons.rule_outlined),
            title: Text(
              'assert(): ${_assertDijalankan ? 'dijalankan' : 'dilewati'}',
            ),
            subtitle: const Text(
              'Di build rilis, assert() tidak pernah jalan.',
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.layers_outlined),
            title: Text('Lingkungan: ${konfigurasi.lingkungan.name}'),
            subtitle: const Text('--dart-define=LINGKUNGAN=...'),
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: Text('Alamat API: ${konfigurasi.alamatApi}'),
            subtitle: const Text('--dart-define=ALAMAT_API=...'),
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: Text(
              'Log rinci: ${konfigurasi.logRinci ? 'aktif' : 'mati'}',
            ),
            subtitle: const Text('--dart-define=LOG_RINCI=true'),
          ),
        ],
      ),
    );
  }
}

class LayarKonfigurasiSalah extends StatelessWidget {
  const LayarKonfigurasiSalah({super.key, required this.pesan});

  final String pesan;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.settings_suggest_outlined, size: 56),
                const SizedBox(height: 12),
                const Text('Konfigurasi build tidak valid'),
                const SizedBox(height: 8),
                Text(pesan, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
