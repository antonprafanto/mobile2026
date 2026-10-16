// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 15: BUILD, RILIS & FINALISASI
// CONTOH 01: Nomor Versi dan Nomor Build (Dart Murni)
// Topik: Setiap rilis aplikasi punya DUA nomor yang ditulis di baris
//        `version:` pada pubspec.yaml, misalnya `version: 1.4.2+17`:
//        - 1.4.2 = NAMA VERSI: dibaca pengguna, mengikuti aturan
//          Semantic Versioning MAYOR.MINOR.PATCH;
//        - 17    = NOMOR BUILD: dibaca toko aplikasi, WAJIB naik setiap
//          kali aplikasi diunggah.
//        Program ini:
//        1. mengurai teks versi dan menolak yang salah tulis;
//        2. membandingkan versi dengan benar (BUKAN sebagai teks);
//        3. menaikkan versi sesuai jenis perubahan;
//        4. memeriksa riwayat unggahan ke toko aplikasi;
//        5. memutuskan apakah pengguna wajib atau cukup disarankan
//           memperbarui aplikasinya.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_01_versi_dan_nomor_build_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// ------------------------------ VERSI ------------------------------

/// Versi aplikasi: MAYOR.MINOR.PATCH+BUILD, misalnya 1.4.2+17.
class Versi implements Comparable<Versi> {
  const Versi(this.mayor, this.minor, this.patch, [this.build = 1]);

  final int mayor; // perubahan besar: data/fitur lama tidak cocok lagi
  final int minor; // fitur baru, versi lama tetap cocok
  final int patch; // perbaikan bug saja
  final int build; // nomor build: naik setiap kali diunggah ke toko

  // Tiga angka dipisah titik, lalu boleh diikuti +angka.
  static final RegExp _pola = RegExp(r'^(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$');

  /// Mengurai teks seperti pada baris `version:` di pubspec.yaml.
  /// Bagian `+BUILD` boleh tidak ditulis; nomor build-nya dianggap 1.
  static Versi urai(String teks) {
    final RegExpMatch? cocok = _pola.firstMatch(teks.trim());
    if (cocok == null) {
      throw FormatException('format harus MAYOR.MINOR.PATCH+BUILD', teks);
    }
    final int build = int.parse(cocok.group(4) ?? '1');
    if (build < 1) {
      throw FormatException('nomor build minimal 1', teks);
    }
    return Versi(
      int.parse(cocok.group(1)!),
      int.parse(cocok.group(2)!),
      int.parse(cocok.group(3)!),
      build,
    );
  }

  /// Nama versi yang dilihat pengguna, tanpa nomor build.
  String get nama => '$mayor.$minor.$patch';

  /// Urutan menurut NAMA VERSI: mayor dulu, lalu minor, lalu patch.
  /// Nomor build tidak ikut dibandingkan: bagi pengguna, 1.4.2+17 dan
  /// 1.4.2+18 sama-sama "versi 1.4.2".
  @override
  int compareTo(Versi lain) {
    if (mayor != lain.mayor) return mayor.compareTo(lain.mayor);
    if (minor != lain.minor) return minor.compareTo(lain.minor);
    return patch.compareTo(lain.patch);
  }

  bool lebihLamaDari(Versi lain) => compareTo(lain) < 0;

  /// Versi berikutnya. Nomor build SELALU naik satu, apa pun jenis
  /// perubahannya.
  Versi naikkan(Perubahan jenis) {
    return switch (jenis) {
      Perubahan.perbaikan => Versi(mayor, minor, patch + 1, build + 1),
      Perubahan.fiturBaru => Versi(mayor, minor + 1, 0, build + 1),
      Perubahan.besar => Versi(mayor + 1, 0, 0, build + 1),
    };
  }

  @override
  String toString() => '$nama+$build';
}

enum Perubahan {
  perbaikan('perbaikan'),
  fiturBaru('fitur baru'),
  besar('perubahan besar');

  const Perubahan(this.label);

  final String label;
}

// ----------------------- RIWAYAT UNGGAHAN -----------------------

/// Aturan toko aplikasi: nomor build setiap unggahan harus LEBIH BESAR
/// daripada semua unggahan sebelumnya yang diterima.
List<String> periksaUnggahan(List<String> riwayat) {
  final List<String> hasil = [];
  int? buildTerakhir;
  for (final String teks in riwayat) {
    final Versi versi = Versi.urai(teks);
    final int? sebelumnya = buildTerakhir;
    if (sebelumnya != null && versi.build == sebelumnya) {
      hasil.add('$versi  DITOLAK: nomor build $sebelumnya sudah dipakai');
    } else if (sebelumnya != null && versi.build < sebelumnya) {
      hasil.add('$versi  DITOLAK: nomor build harus lebih dari $sebelumnya');
    } else {
      hasil.add('$versi  diterima');
      buildTerakhir = versi.build;
    }
  }
  return hasil;
}

// --------------------- KEPUTUSAN PEMBARUAN ---------------------

enum Keputusan { terbaru, disarankan, wajib }

/// Dipakai fitur "cek pembaruan" (Contoh 05): server memberi tahu versi
/// TERBARU dan versi MINIMUM yang masih boleh dipakai.
Keputusan putuskanPembaruan({
  required Versi terpasang,
  required Versi terbaru,
  required Versi minimum,
}) {
  if (terpasang.lebihLamaDari(minimum)) return Keputusan.wajib;
  if (terpasang.lebihLamaDari(terbaru)) return Keputusan.disarankan;
  return Keputusan.terbaru;
}

// ------------------------------ MAIN ------------------------------

void main() {
  print('=== 1. Mengurai baris version: di pubspec.yaml ===');
  for (final String teks in [
    '1.0.0+1',
    '2.3.10+45',
    '1.4.2',
    'v1.0.0',
    '1.2',
    '1.0.0+0',
  ]) {
    try {
      final Versi versi = Versi.urai(teks);
      print(
        '${teks.padRight(10)}-> nama versi ${versi.nama}, '
        'nomor build ${versi.build}',
      );
    } on FormatException catch (galat) {
      print('${teks.padRight(10)}-> DITOLAK: ${galat.message}');
    }
  }
  print('');

  print('=== 2. Membandingkan versi ===');
  // Kesalahan klasik: membandingkan versi sebagai TEKS. Teks dibandingkan
  // huruf demi huruf, dan '1' < '9', sehingga "1.10.0" dianggap lebih
  // kecil daripada "1.9.0".
  final bool menurutTeks = '1.10.0'.compareTo('1.9.0') < 0;
  final bool menurutVersi = Versi.urai('1.10.0')
      .lebihLamaDari(Versi.urai('1.9.0'));
  print('1.10.0 vs 1.9.0');
  print('  sebagai teks : 1.10.0 lebih ${menurutTeks ? 'LAMA' : 'BARU'}');
  print('  sebagai Versi: 1.10.0 lebih ${menurutVersi ? 'LAMA' : 'BARU'}');
  final int sama = Versi.urai('1.4.2+17').compareTo(Versi.urai('1.4.2+18'));
  print(
    '1.4.2+17 vs 1.4.2+18 -> '
    '${sama == 0 ? 'nama versinya sama' : 'berbeda'}',
  );
  print('');

  print('=== 3. Menaikkan versi menurut jenis perubahan ===');
  Versi versi = Versi.urai('1.0.0+1');
  print('${'Rilis pertama'.padRight(29)}-> $versi');
  for (final (String catatan, Perubahan jenis) in [
    ('Perbaiki salah ketik', Perubahan.perbaikan),
    ('Tambah fitur ekspor jadwal', Perubahan.fiturBaru),
    ('Perbaiki tombol simpan macet', Perubahan.perbaikan),
    ('Format data lama dihapus', Perubahan.besar),
  ]) {
    versi = versi.naikkan(jenis);
    print('${catatan.padRight(29)}-> $versi (${jenis.label})');
  }
  print('');

  print('=== 4. Riwayat unggahan ke toko aplikasi ===');
  periksaUnggahan(['1.0.0+1', '1.0.1+2', '1.0.2+2', '1.1.0+1', '1.1.0+3'])
      .forEach(print);
  print('');

  print('=== 5. Perlukah pengguna memperbarui? ===');
  final Versi terbaru = Versi.urai('1.3.0+12');
  final Versi minimum = Versi.urai('1.2.0+8');
  print('Server: terbaru ${terbaru.nama}, minimum ${minimum.nama}');
  for (final String terpasang in ['1.3.0+12', '1.2.4+10', '1.1.9+7']) {
    final Keputusan keputusan = putuskanPembaruan(
      terpasang: Versi.urai(terpasang),
      terbaru: terbaru,
      minimum: minimum,
    );
    final String saran = switch (keputusan) {
      Keputusan.terbaru => 'sudah versi terbaru',
      Keputusan.disarankan => 'disarankan memperbarui ke ${terbaru.nama}',
      Keputusan.wajib => 'WAJIB memperbarui ke ${terbaru.nama}',
    };
    print('Terpasang ${Versi.urai(terpasang).nama} -> $saran');
  }
}

// OUTPUT:
// === 1. Mengurai baris version: di pubspec.yaml ===
// 1.0.0+1   -> nama versi 1.0.0, nomor build 1
// 2.3.10+45 -> nama versi 2.3.10, nomor build 45
// 1.4.2     -> nama versi 1.4.2, nomor build 1
// v1.0.0    -> DITOLAK: format harus MAYOR.MINOR.PATCH+BUILD
// 1.2       -> DITOLAK: format harus MAYOR.MINOR.PATCH+BUILD
// 1.0.0+0   -> DITOLAK: nomor build minimal 1
//
// === 2. Membandingkan versi ===
// 1.10.0 vs 1.9.0
//   sebagai teks : 1.10.0 lebih LAMA
//   sebagai Versi: 1.10.0 lebih BARU
// 1.4.2+17 vs 1.4.2+18 -> nama versinya sama
//
// === 3. Menaikkan versi menurut jenis perubahan ===
// Rilis pertama                -> 1.0.0+1
// Perbaiki salah ketik         -> 1.0.1+2 (perbaikan)
// Tambah fitur ekspor jadwal   -> 1.1.0+3 (fitur baru)
// Perbaiki tombol simpan macet -> 1.1.1+4 (perbaikan)
// Format data lama dihapus     -> 2.0.0+5 (perubahan besar)
//
// === 4. Riwayat unggahan ke toko aplikasi ===
// 1.0.0+1  diterima
// 1.0.1+2  diterima
// 1.0.2+2  DITOLAK: nomor build 2 sudah dipakai
// 1.1.0+1  DITOLAK: nomor build harus lebih dari 2
// 1.1.0+3  diterima
//
// === 5. Perlukah pengguna memperbarui? ===
// Server: terbaru 1.3.0, minimum 1.2.0
// Terpasang 1.3.0 -> sudah versi terbaru
// Terpasang 1.2.4 -> disarankan memperbarui ke 1.3.0
// Terpasang 1.1.9 -> WAJIB memperbarui ke 1.3.0
