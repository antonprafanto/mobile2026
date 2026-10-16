// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 01: Status Izin dan Keputusan Aplikasi (Dart Murni)
// Topik: Sebelum menyentuh GPS atau kamera sungguhan, kita pahami dulu
//        "percakapan" antara aplikasi, sistem operasi, dan pengguna:
//        1. status izin yang mungkin. Namanya meniru enum
//           LocationPermission milik paket geolocator (Contoh 03);
//        2. sistem operasi TIRUAN yang berperilaku seperti Android:
//           - memeriksa izin TIDAK PERNAH menampilkan dialog;
//           - meminta izin menampilkan dialog, KECUALI izin sudah
//             ditolak permanen;
//           - penolakan kedua dianggap permanen;
//           - pilihan "Hanya kali ini" berakhir saat aplikasi ditutup;
//        3. fungsi tindakanUntuk(): dari keadaan layanan dan status
//           izin, apa yang sebaiknya dilakukan aplikasi.
//        Semuanya Dart murni, jadi bisa dicoba tanpa HP.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run contoh_01_status_izin_dart_murni.dart
// =====================================================================

// Ini program konsol, jadi print() boleh dipakai.
// ignore_for_file: avoid_print

// --------------------------- STATUS IZIN ---------------------------

/// Status izin lokasi. Padanannya di paket geolocator ditulis di kanan.
enum StatusIzin {
  /// Belum pernah diminta, ATAU baru ditolak. Masih BOLEH diminta lagi.
  ditolak('denied'),

  /// Ditolak permanen: dialog izin tidak akan muncul lagi.
  ditolakPermanen('deniedForever'),

  /// Diizinkan selama aplikasi sedang dipakai.
  saatDipakai('whileInUse'),

  /// Diizinkan, termasuk saat aplikasi berjalan di latar belakang.
  selalu('always'),

  /// Tidak bisa diketahui (hanya terjadi di browser lama).
  tidakDiketahui('unableToDetermine');

  const StatusIzin(this.namaDiGeolocator);
  final String namaDiGeolocator;
}

/// Tombol yang bisa dipilih pengguna pada dialog izin sistem.
enum PilihanPengguna {
  saatDipakai('Saat aplikasi digunakan'),
  hanyaKaliIni('Hanya kali ini'),
  jangan('Jangan izinkan');

  const PilihanPengguna(this.label);
  final String label;
}

// ---------------------- SISTEM OPERASI TIRUAN ----------------------

/// Meniru cara Android mengelola izin. Perhatikan: catatan izin disimpan
/// oleh SISTEM, bukan oleh aplikasi. Aplikasi hanya bisa bertanya.
class SistemOperasiTiruan {
  StatusIzin _status = StatusIzin.ditolak; // aplikasi baru dipasang
  int _jumlahPenolakan = 0;
  bool _hanyaKaliIni = false;
  bool layananLokasiAktif = true; // sakelar "Lokasi" di HP

  /// Seperti Geolocator.checkPermission(): hanya MELIHAT, tanpa dialog.
  Future<StatusIzin> periksaIzin() async => _status;

  /// Seperti Geolocator.requestPermission(). Parameter [jawaban]
  /// mewakili tombol yang akan diketuk pengguna JIKA dialog muncul.
  Future<StatusIzin> mintaIzin(PilihanPengguna jawaban) async {
    if (_status != StatusIzin.ditolak) {
      // Sudah diizinkan atau sudah diblokir: dialog tidak ditampilkan.
      print('    Dialog TIDAK muncul -> langsung: ${_status.name}');
      return _status;
    }
    print('    Dialog sistem muncul -> dipilih "${jawaban.label}"');
    switch (jawaban) {
      case PilihanPengguna.saatDipakai:
        _status = StatusIzin.saatDipakai;
      case PilihanPengguna.hanyaKaliIni:
        _status = StatusIzin.saatDipakai;
        _hanyaKaliIni = true;
      case PilihanPengguna.jangan:
        _jumlahPenolakan++;
        // Android: menolak LEBIH DARI SEKALI dianggap penolakan permanen.
        _status = _jumlahPenolakan >= 2
            ? StatusIzin.ditolakPermanen
            : StatusIzin.ditolak;
    }
    return _status;
  }

  /// Pengguna menutup aplikasi. Izin "Hanya kali ini" ikut berakhir.
  void tutupAplikasi() {
    if (_hanyaKaliIni) {
      _status = StatusIzin.ditolak;
      _hanyaKaliIni = false;
    }
  }

  /// Pengguna mengubah izin sendiri lewat aplikasi Pengaturan.
  void ubahLewatPengaturan(StatusIzin baru) {
    _status = baru;
    _jumlahPenolakan = 0;
    _hanyaKaliIni = false;
  }
}

// ------------------------- KEPUTUSAN APLIKASI -------------------------

enum Tindakan {
  ambilLokasi('Ambil lokasi sekarang'),
  mintaIzin('Tampilkan dialog izin'),
  nyalakanLayanan('Minta pengguna menyalakan layanan lokasi'),
  bukaPengaturan('Jelaskan, lalu tawarkan tombol "Buka Pengaturan"');

  const Tindakan(this.keterangan);
  final String keterangan;
}

/// Urutan pemeriksaannya penting: layanan dulu, baru izin.
Tindakan tindakanUntuk({required bool layananAktif, required StatusIzin izin}) {
  if (!layananAktif) return Tindakan.nyalakanLayanan;
  // switch ekspresi WAJIB menangani semua nilai enum. Jika kelak ada
  // status baru, analyzer langsung mengingatkan kita.
  return switch (izin) {
    StatusIzin.saatDipakai || StatusIzin.selalu => Tindakan.ambilLokasi,
    // Di browser lama status tidak bisa diketahui, jadi langsung minta.
    StatusIzin.ditolak || StatusIzin.tidakDiketahui => Tindakan.mintaIzin,
    StatusIzin.ditolakPermanen => Tindakan.bukaPengaturan,
  };
}

// ------------------------------ PROGRAM ------------------------------

Future<void> main() async {
  print('=== 1. Dari keadaan ke tindakan ===');
  final Tindakan mati = tindakanUntuk(
    layananAktif: false,
    izin: StatusIzin.saatDipakai,
  );
  print('${'layanan mati'.padRight(36)}${mati.keterangan}');
  for (final StatusIzin izin in StatusIzin.values) {
    final String kiri = '${izin.name} (${izin.namaDiGeolocator})';
    final Tindakan t = tindakanUntuk(layananAktif: true, izin: izin);
    print('${kiri.padRight(36)}${t.keterangan}');
  }
  print('');

  print('=== 2. Cerita Rina ===');
  final SistemOperasiTiruan hp = SistemOperasiTiruan();
  print(
    '[1] Aplikasi baru dipasang. Periksa izin: '
    '${(await hp.periksaIzin()).name}',
  );

  print('[2] Rina mengetuk "Gunakan lokasi saya".');
  StatusIzin hasil = await hp.mintaIzin(PilihanPengguna.jangan);
  print('    Hasil: ${hasil.name} (penolakan ke-1, masih boleh diminta)');

  print('[3] Rina mengetuk lagi.');
  hasil = await hp.mintaIzin(PilihanPengguna.jangan);
  print('    Hasil: ${hasil.name} (penolakan ke-2)');

  print('[4] Rina mengetuk lagi.');
  hasil = await hp.mintaIzin(PilihanPengguna.saatDipakai);
  final Tindakan t4 = tindakanUntuk(layananAktif: true, izin: hasil);
  print('    Aplikasi: ${t4.keterangan}');

  print('[5] Rina membuka Pengaturan dan memilih "Izinkan".');
  hp.ubahLewatPengaturan(StatusIzin.saatDipakai);
  hasil = await hp.periksaIzin();
  final Tindakan t5 = tindakanUntuk(layananAktif: true, izin: hasil);
  print('    Periksa izin: ${hasil.name} -> ${t5.keterangan}');

  print('[6] Rina mematikan sakelar Lokasi di HP.');
  hp.layananLokasiAktif = false;
  final Tindakan t6 = tindakanUntuk(
    layananAktif: hp.layananLokasiAktif,
    izin: await hp.periksaIzin(),
  );
  print('    Izin tetap ${hasil.name}, tetapi: ${t6.keterangan}');
  print('');

  print('=== 3. "Hanya kali ini" ===');
  final SistemOperasiTiruan hpBudi = SistemOperasiTiruan();
  print('Budi mengetuk "Gunakan lokasi saya".');
  hasil = await hpBudi.mintaIzin(PilihanPengguna.hanyaKaliIni);
  print('    Hasil: ${hasil.name}');
  hpBudi.tutupAplikasi();
  print('Budi menutup aplikasi, lalu membukanya lagi besok.');
  print(
    '    Periksa izin: ${(await hpBudi.periksaIzin()).name}'
    ' -> izin harus diminta lagi',
  );
}

// OUTPUT:
// === 1. Dari keadaan ke tindakan ===
// layanan mati                        Minta pengguna menyalakan layanan lokasi
// ditolak (denied)                    Tampilkan dialog izin
// ditolakPermanen (deniedForever)     Jelaskan, lalu tawarkan tombol "Buka Pengaturan"
// saatDipakai (whileInUse)            Ambil lokasi sekarang
// selalu (always)                     Ambil lokasi sekarang
// tidakDiketahui (unableToDetermine)  Tampilkan dialog izin
//
// === 2. Cerita Rina ===
// [1] Aplikasi baru dipasang. Periksa izin: ditolak
// [2] Rina mengetuk "Gunakan lokasi saya".
//     Dialog sistem muncul -> dipilih "Jangan izinkan"
//     Hasil: ditolak (penolakan ke-1, masih boleh diminta)
// [3] Rina mengetuk lagi.
//     Dialog sistem muncul -> dipilih "Jangan izinkan"
//     Hasil: ditolakPermanen (penolakan ke-2)
// [4] Rina mengetuk lagi.
//     Dialog TIDAK muncul -> langsung: ditolakPermanen
//     Aplikasi: Jelaskan, lalu tawarkan tombol "Buka Pengaturan"
// [5] Rina membuka Pengaturan dan memilih "Izinkan".
//     Periksa izin: saatDipakai -> Ambil lokasi sekarang
// [6] Rina mematikan sakelar Lokasi di HP.
//     Izin tetap saatDipakai, tetapi: Minta pengguna menyalakan layanan lokasi
//
// === 3. "Hanya kali ini" ===
// Budi mengetuk "Gunakan lokasi saya".
//     Dialog sistem muncul -> dipilih "Hanya kali ini"
//     Hasil: saatDipakai
// Budi menutup aplikasi, lalu membukanya lagi besok.
//     Periksa izin: ditolak -> izin harus diminta lagi
