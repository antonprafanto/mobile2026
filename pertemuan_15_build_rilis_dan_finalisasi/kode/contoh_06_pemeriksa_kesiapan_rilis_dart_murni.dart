// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 06: Pemeriksa Kesiapan Rilis (Dart Murni)
// Topik: Sebelum rilis, ada daftar periksa yang sering terlupa: izin
//        INTERNET, applicationId bawaan "com.example", nama aplikasi yang
//        masih berupa nama paket, kunci rahasia yang ikut ter-commit, dan
//        seterusnya. Daftar itu bisa ditulis sebagai PROGRAM:
//        1. isi beberapa berkas proyek "Tugas Kuliahku" disimpan sebagai
//           teks (Map: nama berkas -> isi);
//        2. setiap pemeriksaan membaca teks itu dan melapor OK, SARAN,
//           atau WAJIB (wajib diperbaiki sebelum rilis);
//        3. proyek diperiksa dua kali: sebelum dan sesudah dirapikan.
//        Ingin memeriksa proyek Anda sendiri? Ganti isi Map dengan isi
//        berkas proyek Anda (salin-tempel), lalu jalankan lagi.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_06_pemeriksa_kesiapan_rilis_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

typedef Proyek = Map<String, String>; // nama berkas -> isi berkas

const String bPubspec = 'pubspec.yaml';
const String bManifest = 'android/app/src/main/AndroidManifest.xml';
const String bGradle = 'android/app/build.gradle.kts';
const String bAbaikanAndroid = 'android/.gitignore';
const String bIndexWeb = 'web/index.html';

enum Tingkat { ok, saran, wajib }

class HasilCek {
  const HasilCek(this.tingkat, this.pesan);

  final Tingkat tingkat;
  final String pesan;
}

String isi(Proyek proyek, String berkas) => proyek[berkas] ?? '';

/// Nilai pertama yang cocok dengan pola (grup 1), atau null.
String? ambil(String teks, String pola) =>
    RegExp(pola, multiLine: true).firstMatch(teks)?.group(1);

// --------------------------- PEMERIKSAAN ---------------------------

HasilCek cekVersi(Proyek p) {
  final String? versi = ambil(isi(p, bPubspec), r'^version:\s*(\S+)');
  if (versi == null || !RegExp(r'^\d+\.\d+\.\d+\+\d+$').hasMatch(versi)) {
    return const HasilCek(Tingkat.wajib, 'Baris version: belum lengkap');
  }
  return HasilCek(Tingkat.ok, 'Nomor versi lengkap ($versi)');
}

HasilCek cekDeskripsi(Proyek p) {
  if (isi(p, bPubspec).contains('A new Flutter project.')) {
    return const HasilCek(Tingkat.saran, 'Deskripsi pubspec masih bawaan');
  }
  return const HasilCek(Tingkat.ok, 'Deskripsi pubspec sudah diisi');
}

HasilCek cekIzinInternet(Proyek p) {
  // Paket http dipakai, tetapi izin INTERNET tidak ada: build debug
  // lancar, build rilis gagal memuat data (Pertemuan 10, Bagian 14.2).
  final bool pakaiHttp = RegExp(
    r'^\s+(http|dio):',
    multiLine: true,
  ).hasMatch(isi(p, bPubspec));
  final bool adaIzin = isi(
    p,
    bManifest,
  ).contains('android.permission.INTERNET');
  if (pakaiHttp && !adaIzin) {
    return const HasilCek(Tingkat.wajib, 'Izin INTERNET belum ada');
  }
  return const HasilCek(Tingkat.ok, 'Izin INTERNET sesuai kebutuhan');
}

HasilCek cekNamaTampilan(Proyek p) {
  final String? namaPaket = ambil(isi(p, bPubspec), r'^name:\s*(\S+)');
  final String? label = ambil(isi(p, bManifest), r'android:label="([^"]*)"');
  if (label == null || label == namaPaket) {
    return HasilCek(Tingkat.saran, 'Nama di HP masih "$label"');
  }
  return HasilCek(Tingkat.ok, 'Nama di HP: "$label"');
}

HasilCek cekApplicationId(Proyek p) {
  final String? id = ambil(isi(p, bGradle), r'applicationId = "([^"]*)"');
  // Google Play menolak applicationId yang diawali com.example.
  if (id == null || id.startsWith('com.example')) {
    return HasilCek(Tingkat.wajib, 'applicationId masih $id');
  }
  return HasilCek(Tingkat.ok, 'applicationId: $id');
}

HasilCek cekTandaTangan(Proyek p) {
  if (isi(p, bGradle).contains('signingConfigs.getByName("debug")')) {
    return const HasilCek(Tingkat.saran, 'Rilis masih memakai kunci debug');
  }
  return const HasilCek(Tingkat.ok, 'Rilis memakai kunci unggah sendiri');
}

HasilCek cekJudulWeb(Proyek p) {
  final String? namaPaket = ambil(isi(p, bPubspec), r'^name:\s*(\S+)');
  final String? judul = ambil(isi(p, bIndexWeb), r'<title>(.*)</title>');
  if (judul == null || judul == namaPaket) {
    return HasilCek(Tingkat.saran, 'Judul tab web masih "$judul"');
  }
  return HasilCek(Tingkat.ok, 'Judul tab web: "$judul"');
}

HasilCek cekGitignore(Proyek p) {
  final String abaikan = isi(p, bAbaikanAndroid);
  if (!abaikan.contains('key.properties') || !abaikan.contains('*.jks')) {
    return const HasilCek(Tingkat.wajib, 'Kunci unggah bisa ter-commit');
  }
  return const HasilCek(Tingkat.ok, 'key.properties dan *.jks diabaikan Git');
}

/// Mencari pola di semua berkas lib/. Hasil: "berkas:baris" pertama.
String? cariDiLib(Proyek p, RegExp pola) {
  final List<String> berkasLib =
      p.keys.where((String b) => b.startsWith('lib/')).toList()..sort();
  for (final String berkas in berkasLib) {
    final List<String> baris = p[berkas]!.split('\n');
    for (int i = 0; i < baris.length; i++) {
      final String b = baris[i].trimLeft();
      if (!b.startsWith('//') && pola.hasMatch(b)) return '$berkas:${i + 1}';
    }
  }
  return null;
}

HasilCek cekRahasia(Proyek p) {
  // Teks panjang yang ditulis langsung untuk nama seperti kunci/token.
  final String? letak = cariDiLib(
    p,
    RegExp(
      r"(kunci|key|token|sandi|password)\w*\s*=\s*'[^']{12,}'",
      caseSensitive: false,
    ),
  );
  if (letak != null) {
    return HasilCek(Tingkat.wajib, 'Ada kunci rahasia di $letak');
  }
  return const HasilCek(Tingkat.ok, 'Tidak ada kunci rahasia di lib/');
}

HasilCek cekPrint(Proyek p) {
  final String? letak = cariDiLib(p, RegExp(r'(^|[^\w.])print\('));
  if (letak != null) {
    return HasilCek(Tingkat.saran, 'Ada print() di $letak');
  }
  return const HasilCek(Tingkat.ok, 'Tidak ada print() di lib/');
}

final List<HasilCek Function(Proyek)> semuaPemeriksaan = [
  cekVersi,
  cekDeskripsi,
  cekIzinInternet,
  cekNamaTampilan,
  cekApplicationId,
  cekTandaTangan,
  cekJudulWeb,
  cekGitignore,
  cekRahasia,
  cekPrint,
];

void periksaDanCetak(String judul, Proyek proyek) {
  print('=== $judul ===');
  int wajib = 0;
  int saran = 0;
  for (final HasilCek Function(Proyek) periksa in semuaPemeriksaan) {
    final HasilCek hasil = periksa(proyek);
    final String label = switch (hasil.tingkat) {
      Tingkat.ok => '[OK]   ',
      Tingkat.saran => '[SARAN]',
      Tingkat.wajib => '[WAJIB]',
    };
    if (hasil.tingkat == Tingkat.wajib) wajib++;
    if (hasil.tingkat == Tingkat.saran) saran++;
    print('$label ${hasil.pesan}');
  }
  final String kesimpulan = wajib > 0 ? 'BELUM SIAP RILIS' : 'SIAP RILIS';
  print('Hasil: $wajib wajib, $saran saran -> $kesimpulan');
}

// ------------------------------ DATA ------------------------------

const String pubspecAwal = '''
name: tugas_kuliahku
description: "A new Flutter project."
publish_to: 'none'
version: 1.0.0+1

dependencies:
  flutter:
    sdk: flutter
  http: ^1.6.0
  provider: ^6.1.5
''';

const Proyek proyekSebelum = {
  bPubspec: pubspecAwal,
  bManifest: '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="tugas_kuliahku"
        android:icon="@mipmap/ic_launcher">
    </application>
</manifest>
''',
  bGradle: '''
    defaultConfig {
        applicationId = "com.example.tugas_kuliahku"
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
''',
  bAbaikanAndroid: '''
/local.properties
**/*.keystore
**/*.jks
''',
  bIndexWeb: '<title>tugas_kuliahku</title>',
  'lib/config/kunci.dart': '''
// JANGAN ditiru: kunci ditulis langsung di kode.
const String kunciPeta = 'rahasia-contoh-0123456789';
''',
  'lib/data/services/layanan_dummy_json.dart': '''
Future<void> ambilTugas(Uri alamat) async {
  print('GET \$alamat');
}
''',
};

final Proyek proyekSesudah = {
  bPubspec: pubspecAwal.replaceFirst(
    'A new Flutter project.',
    'Pencatat tugas kuliah yang tetap bisa dibaca tanpa internet.',
  ),
  bManifest: '''
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        android:label="Tugas Kuliahku"
        android:icon="@mipmap/ic_launcher">
    </application>
</manifest>
''',
  bGradle: '''
    defaultConfig {
        applicationId = "com.budisantoso.tugaskuliahku"
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
''',
  bAbaikanAndroid: '''
/local.properties
key.properties
**/*.keystore
**/*.jks
''',
  bIndexWeb: '<title>Tugas Kuliahku</title>',
  'lib/config/kunci.dart': '''
// Diberikan saat build: --dart-define=KUNCI_PETA=...
const String kunciPeta = String.fromEnvironment('KUNCI_PETA');
''',
  'lib/data/services/layanan_dummy_json.dart': '''
Future<void> ambilTugas(Uri alamat) async {
  if (kDebugMode) debugPrint('GET \$alamat');
}
''',
};

void main() {
  periksaDanCetak('Tugas Kuliahku: sebelum dirapikan', proyekSebelum);
  print('');
  periksaDanCetak('Tugas Kuliahku: sesudah dirapikan', proyekSesudah);
}

// OUTPUT:
// === Tugas Kuliahku: sebelum dirapikan ===
// [OK]    Nomor versi lengkap (1.0.0+1)
// [SARAN] Deskripsi pubspec masih bawaan
// [WAJIB] Izin INTERNET belum ada
// [SARAN] Nama di HP masih "tugas_kuliahku"
// [WAJIB] applicationId masih com.example.tugas_kuliahku
// [SARAN] Rilis masih memakai kunci debug
// [SARAN] Judul tab web masih "tugas_kuliahku"
// [WAJIB] Kunci unggah bisa ter-commit
// [WAJIB] Ada kunci rahasia di lib/config/kunci.dart:2
// [SARAN] Ada print() di lib/data/services/layanan_dummy_json.dart:2
// Hasil: 4 wajib, 5 saran -> BELUM SIAP RILIS
//
// === Tugas Kuliahku: sesudah dirapikan ===
// [OK]    Nomor versi lengkap (1.0.0+1)
// [OK]    Deskripsi pubspec sudah diisi
// [OK]    Izin INTERNET sesuai kebutuhan
// [OK]    Nama di HP: "Tugas Kuliahku"
// [OK]    applicationId: com.budisantoso.tugaskuliahku
// [OK]    Rilis memakai kunci unggah sendiri
// [OK]    Judul tab web: "Tugas Kuliahku"
// [OK]    key.properties dan *.jks diabaikan Git
// [OK]    Tidak ada kunci rahasia di lib/
// [OK]    Tidak ada print() di lib/
// Hasil: 0 wajib, 0 saran -> SIAP RILIS
