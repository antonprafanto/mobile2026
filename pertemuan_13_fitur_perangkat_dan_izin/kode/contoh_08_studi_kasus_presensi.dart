// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 13: FITUR PERANGKAT & IZIN
// CONTOH 08: Studi Kasus "Presensi Praktikum"
// Topik: Mahasiswa melakukan presensi praktikum dengan foto selfie dan
//        lokasi. Presensi diterima jika:
//        - sesi sedang dibuka (15 menit sebelum mulai sampai 30 menit
//          sesudahnya) dan mahasiswa belum presensi di sesi itu;
//        - ada foto selfie;
//        - lokasinya bukan dari aplikasi pemalsu GPS, akurasinya paling
//          buruk 50 m, dan jaraknya paling jauh 100 m dari laboratorium.
//        Susunannya sama dengan Pertemuan 12:
//        - DOMAIN : entitas, aturan presensi (termasuk rumus jarak),
//                   KONTRAK layanan perangkat, kontrak repository, dan
//                   use case CatatPresensi. Semuanya Dart murni;
//        - DATA   : implementasi ASLI (geolocator, image_picker) yang
//                   menerjemahkan exception menjadi Kegagalan, serta
//                   implementasi PALSU untuk pengembangan dan pengujian;
//        - UI     : ViewModel (dengan Perintah) dan View. Kegagalan
//                   diubah menjadi pesan dan tombol di SATU tempat.
//        Lingkungan pengembangan memakai lokasi, kamera, dan JAM palsu
//        (pukul 13.10), sehingga semua keadaan bisa dicoba di laptop.
//        Menu di kanan atas halaman presensi mengganti skenario lokasi.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa aturan, use
//        case, dan ViewModel. Lihat hasilnya di konsol.
//        Setiap bagian diberi judul "BERKAS: ..." yang menunjukkan
//        letaknya jika aplikasi ini dipecah menjadi banyak berkas.
// =====================================================================
// CARA MENJALANKAN (tidak bisa di DartPad):
// 1. Di proyek Flutter: flutter pub add geolocator image_picker provider
// 2. Tambahkan izin dan keterangan lokasi serta kamera seperti Contoh 02
//    dan 03 (modul Bagian 3).
// 3. Salin seluruh isi berkas ini ke lib/main.dart.
// 4. Jalankan: flutter run -d chrome --web-port=8080 (atau di HP).
//    Lingkungan produksi memakai GPS dan kamera ASLI. Agar presensi
//    berhasil, palsukan lokasi lewat DevTools -> Sensors ke koordinat
//    laboratorium yang sedang dibuka, dengan Accuracy kecil (misalnya
//    10). Tanpa Accuracy, Chrome memakai 150 m sehingga presensi
//    ditolak karena kurang akurat (modul Bagian 11.1). Cara lain: ganti
//    koordinat di RepositoriPresensiMemori dengan koordinat Anda.
// =====================================================================

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ======================= BERKAS: lib/main.dart =======================

// Satu-satunya baris yang diubah untuk memakai lokasi, kamera, dan jam
// palsu: Lingkungan.pengembangan.
const Lingkungan lingkungan = Lingkungan.produksi;

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: buatPenyedia(lingkungan),
      child: const AplikasiPresensi(lingkungan: lingkungan),
    ),
  );
}

// ================== BERKAS: lib/config/dependensi.dart ==================
// Akar komposisi: SATU-SATUNYA tempat yang tahu implementasi mana yang
// dipakai. Lapisan lain hanya mengenal kontraknya.

enum Lingkungan { pengembangan, produksi }

const Mahasiswa mahasiswaAktif = Mahasiswa(
  nim: '2609106021',
  nama: 'Dimas Pratama',
);

/// Jam palsu untuk pengembangan: hari ini pukul 13.10.
DateTime jamPengembangan() {
  final DateTime kini = DateTime.now();
  return DateTime(kini.year, kini.month, kini.day, 13, 10);
}

List<SingleChildWidget> buatPenyedia(Lingkungan lingkungan) {
  return [
    Provider<Mahasiswa>.value(value: mahasiswaAktif),
    ...switch (lingkungan) {
      Lingkungan.pengembangan => [
        Provider<Jam>.value(value: const Jam(jamPengembangan)),
        Provider<LayananLokasi>(
          create: (BuildContext context) => LayananLokasiPalsu(),
        ),
        Provider<PemilihFoto>(
          create: (BuildContext context) => PemilihFotoPalsu(),
        ),
        Provider<PengaturanPerangkat>(
          create: (BuildContext context) => PengaturanPerangkatPalsu(),
        ),
      ],
      Lingkungan.produksi => [
        Provider<Jam>.value(value: const Jam()),
        Provider<LayananLokasi>(
          create: (BuildContext context) => const LayananLokasiGeolocator(),
        ),
        Provider<PemilihFoto>(
          create: (BuildContext context) => PemilihFotoImagePicker(),
        ),
        Provider<PengaturanPerangkat>(
          create: (BuildContext context) =>
              const PengaturanPerangkatGeolocator(),
        ),
      ],
    },
    // Di kedua lingkungan, jadwal dan presensi disimpan di memori. Di
    // proyek sungguhan, baris ini diganti repository server kampus
    // (Pertemuan 10) atau SQLite (Pertemuan 11).
    Provider<RepositoriPresensi>(
      create: (BuildContext context) =>
          RepositoriPresensiMemori(jam: context.read<Jam>()),
    ),
    Provider<CatatPresensi>(
      create: (BuildContext context) => CatatPresensi(
        repositori: context.read<RepositoriPresensi>(),
        lokasi: context.read<LayananLokasi>(),
        jam: context.read<Jam>(),
        mahasiswa: context.read<Mahasiswa>(),
      ),
    ),
  ];
}

// ===================== BERKAS: lib/domain/hasil.dart =====================

sealed class Hasil<T> {
  const Hasil();
}

final class Berhasil<T> extends Hasil<T> {
  const Berhasil(this.nilai);
  final T nilai;
}

final class Gagal<T> extends Hasil<T> {
  const Gagal(this.kegagalan);
  final Kegagalan kegagalan;
}

enum Fitur {
  lokasi('lokasi'),
  kamera('kamera'),
  galeri('galeri');

  const Fitur(this.nama);
  final String nama;
}

sealed class Kegagalan {
  const Kegagalan();
}

final class LayananLokasiMati extends Kegagalan {
  const LayananLokasiMati();
}

final class IzinDitolak extends Kegagalan {
  const IzinDitolak(this.fitur);
  final Fitur fitur;
}

final class IzinDiblokir extends Kegagalan {
  const IzinDiblokir(this.fitur);
  final Fitur fitur;
}

final class PerangkatTidakMendukung extends Kegagalan {
  const PerangkatTidakMendukung(this.fitur);
  final Fitur fitur;
}

final class Dibatalkan extends Kegagalan {
  const Dibatalkan();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

/// Galat perangkat yang tidak kita kenali. [kode] untuk pelaporan.
final class GangguanPerangkat extends Kegagalan {
  const GangguanPerangkat(this.kode);
  final String kode;
}

final class AturanDilanggar extends Kegagalan {
  const AturanDilanggar(this.alasan);
  final String alasan;
}

// ===================== BERKAS: lib/domain/jam.dart =====================

/// Sumber "waktu sekarang". Dibungkus kelas agar bisa dititipkan lewat
/// Provider dan diganti jam palsu saat pengembangan dan pengujian.
class Jam {
  const Jam([this._sumber = DateTime.now]);

  final DateTime Function() _sumber;

  DateTime sekarang() => _sumber();
}

String _duaDigit(int n) => n.toString().padLeft(2, '0');

/// 13.05
String teksJam(DateTime w) => '${_duaDigit(w.hour)}.${_duaDigit(w.minute)}';

// ============== BERKAS: lib/domain/models/presensi.dart ==============

class Mahasiswa {
  const Mahasiswa({required this.nim, required this.nama});
  final String nim;
  final String nama;
}

class Koordinat {
  const Koordinat(this.lintang, this.bujur);
  final double lintang;
  final double bujur;
}

class Posisi {
  const Posisi({
    required this.lintang,
    required this.bujur,
    required this.akurasiMeter,
    required this.waktu,
    this.palsu = false,
  });

  final double lintang;
  final double bujur;
  final double akurasiMeter;
  final DateTime waktu;
  final bool palsu;

  Koordinat get koordinat => Koordinat(lintang, bujur);
}

class FotoBukti {
  const FotoBukti({required this.nama, required this.bita});
  final String nama;
  final Uint8List bita;
}

class SesiPraktikum {
  const SesiPraktikum({
    required this.kode,
    required this.mataKuliah,
    required this.ruang,
    required this.titik,
    required this.mulai,
    required this.selesai,
    this.radiusMeter = 100,
  });

  final String kode;
  final String mataKuliah;
  final String ruang;
  final Koordinat titik;
  final DateTime mulai;
  final DateTime selesai;
  final int radiusMeter;

  DateTime get presensiDibuka => mulai.subtract(const Duration(minutes: 15));
  DateTime get presensiDitutup => mulai.add(const Duration(minutes: 30));
}

class Presensi {
  const Presensi({
    required this.id,
    required this.kodeSesi,
    required this.nim,
    required this.waktu,
    required this.jarakMeter,
    required this.akurasiMeter,
    required this.namaFoto,
  });

  final String id;
  final String kodeSesi;
  final String nim;
  final DateTime waktu;
  final double jarakMeter;
  final double akurasiMeter;
  final String namaFoto;
}

// =========== BERKAS: lib/domain/models/aturan_presensi.dart ===========

/// Rumus haversine, sama dengan Geolocator.distanceBetween. Domain TIDAK
/// mengimpor geolocator, jadi rumusnya ditulis sendiri (Contoh 04).
double jarakMeter(Koordinat a, Koordinat b) {
  double radian(double derajat) => derajat * pi / 180;
  final double h =
      pow(sin(radian(b.lintang - a.lintang) / 2), 2) +
      pow(sin(radian(b.bujur - a.bujur) / 2), 2) *
          cos(radian(a.lintang)) *
          cos(radian(b.lintang));
  return 6378137.0 * 2 * asin(sqrt(h));
}

enum StatusSesi { belumDibuka, dibuka, sudahPresensi, ditutup }

StatusSesi statusSesi(
  SesiPraktikum sesi, {
  required DateTime sekarang,
  required bool sudahPresensi,
}) {
  if (sudahPresensi) return StatusSesi.sudahPresensi;
  if (sekarang.isBefore(sesi.presensiDibuka)) return StatusSesi.belumDibuka;
  if (sekarang.isAfter(sesi.presensiDitutup)) return StatusSesi.ditutup;
  return StatusSesi.dibuka;
}

/// Pemeriksaan yang TIDAK butuh lokasi. Dijalankan lebih dulu agar
/// lokasi (dan izinnya) tidak diminta percuma.
String? periksaSebelumLokasi({
  required SesiPraktikum sesi,
  required FotoBukti? foto,
  required DateTime sekarang,
  required bool sudahPresensi,
}) {
  switch (statusSesi(sesi, sekarang: sekarang, sudahPresensi: sudahPresensi)) {
    case StatusSesi.sudahPresensi:
      return 'Anda sudah presensi untuk sesi ini.';
    case StatusSesi.belumDibuka:
      return 'Presensi baru dibuka pukul ${teksJam(sesi.presensiDibuka)}.';
    case StatusSesi.ditutup:
      return 'Presensi sudah ditutup pukul ${teksJam(sesi.presensiDitutup)}.';
    case StatusSesi.dibuka:
      break;
  }
  if (foto == null) return 'Ambil foto selfie terlebih dahulu.';
  return null;
}

const double akurasiMaksimalMeter = 50;

String? periksaLokasi({required SesiPraktikum sesi, required Posisi posisi}) {
  if (posisi.palsu) {
    return 'Lokasi palsu terdeteksi. Matikan aplikasi pemalsu GPS, lalu '
        'coba lagi.';
  }
  if (posisi.akurasiMeter > akurasiMaksimalMeter) {
    return 'Lokasi kurang akurat (± ${posisi.akurasiMeter.round()} m). '
        'Pindah ke dekat jendela, lalu coba lagi.';
  }
  final double jarak = jarakMeter(posisi.koordinat, sesi.titik);
  if (jarak > sesi.radiusMeter) {
    return 'Anda berada ${jarak.round()} m dari ${sesi.ruang}. Presensi '
        'hanya bisa dalam radius ${sesi.radiusMeter} m.';
  }
  return null;
}

// ========== BERKAS: lib/domain/services/layanan_perangkat.dart ==========
// KONTRAK fitur perangkat. Tidak ada kata "geolocator" di sini.

abstract interface class LayananLokasi {
  /// Memeriksa layanan dan izin, lalu mengambil posisi sekarang.
  Future<Hasil<Posisi>> posisiSekarang();
}

abstract interface class PemilihFoto {
  bool get kameraTersedia;

  Future<Hasil<FotoBukti>> ambil({required bool dariKamera});
}

abstract interface class PengaturanPerangkat {
  /// false di web: izin situs diatur lewat browser, bukan oleh aplikasi.
  bool get bisaDibuka;

  Future<void> bukaPengaturanAplikasi();

  Future<void> bukaPengaturanLokasi();
}

// ======== BERKAS: lib/domain/repositories/repositori_presensi.dart ========

abstract interface class RepositoriPresensi {
  Future<Hasil<List<SesiPraktikum>>> sesiHariIni();

  Future<Hasil<List<Presensi>>> riwayat(String nim);

  Future<Hasil<Presensi>> simpan({
    required String kodeSesi,
    required String nim,
    required DateTime waktu,
    required double jarakMeter,
    required double akurasiMeter,
    required String namaFoto,
  });
}

// ========== BERKAS: lib/domain/use_cases/catat_presensi.dart ==========
// Layak menjadi use case: menggabungkan repository, layanan lokasi, jam,
// dan aturan bisnis dalam urutan yang penting.

class CatatPresensi {
  CatatPresensi({
    required this._repositori,
    required this._lokasi,
    required this._jam,
    required this._mahasiswa,
  });

  final RepositoriPresensi _repositori;
  final LayananLokasi _lokasi;
  final Jam _jam;
  final Mahasiswa _mahasiswa;

  Future<Hasil<Presensi>> jalankan({
    required SesiPraktikum sesi,
    required FotoBukti? foto,
  }) async {
    // 1. Pemeriksaan tanpa lokasi: sesi dibuka? sudah presensi? foto ada?
    final Hasil<List<Presensi>> hasilRiwayat = await _repositori.riwayat(
      _mahasiswa.nim,
    );
    final List<Presensi> riwayat;
    switch (hasilRiwayat) {
      case Gagal(:final Kegagalan kegagalan):
        return Gagal(kegagalan);
      case Berhasil(:final List<Presensi> nilai):
        riwayat = nilai;
    }
    final String? alasanAwal = periksaSebelumLokasi(
      sesi: sesi,
      foto: foto,
      sekarang: _jam.sekarang(),
      sudahPresensi: riwayat.any((Presensi p) => p.kodeSesi == sesi.kode),
    );
    if (alasanAwal != null) return Gagal(AturanDilanggar(alasanAwal));

    // 2. Lokasi diambil SAAT INI JUGA, bukan lokasi yang tersimpan.
    final Hasil<Posisi> hasilPosisi = await _lokasi.posisiSekarang();
    final Posisi posisi;
    switch (hasilPosisi) {
      case Gagal(:final Kegagalan kegagalan):
        return Gagal(kegagalan);
      case Berhasil(:final Posisi nilai):
        posisi = nilai;
    }
    final String? alasanLokasi = periksaLokasi(sesi: sesi, posisi: posisi);
    if (alasanLokasi != null) return Gagal(AturanDilanggar(alasanLokasi));

    // 3. Semua aturan terpenuhi: simpan. (Foto pasti ada; sudah diperiksa
    //    di langkah 1.)
    return _repositori.simpan(
      kodeSesi: sesi.kode,
      nim: _mahasiswa.nim,
      waktu: _jam.sekarang(),
      jarakMeter: jarakMeter(posisi.koordinat, sesi.titik),
      akurasiMeter: posisi.akurasiMeter,
      namaFoto: foto?.nama ?? '',
    );
  }
}

// ====== BERKAS: lib/data/services/layanan_lokasi_geolocator.dart ======
// Implementasi ASLI. Inilah satu-satunya bagian yang mengenal paket
// geolocator, sekaligus PENERJEMAH exception-nya menjadi Kegagalan.

class LayananLokasiGeolocator implements LayananLokasi {
  const LayananLokasiGeolocator();

  @override
  Future<Hasil<Posisi>> posisiSekarang() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return const Gagal(LayananLokasiMati());
    }
    LocationPermission izin = await Geolocator.checkPermission();
    if (izin == LocationPermission.denied ||
        izin == LocationPermission.unableToDetermine) {
      izin = await Geolocator.requestPermission();
    }
    final Kegagalan? masalahIzin = switch (izin) {
      LocationPermission.denied => const IzinDitolak(Fitur.lokasi),
      LocationPermission.deniedForever => const IzinDiblokir(Fitur.lokasi),
      LocationPermission.whileInUse ||
      LocationPermission.always ||
      LocationPermission.unableToDetermine => null,
    };
    if (masalahIzin != null) return Gagal(masalahIzin);

    try {
      final Position p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      return Berhasil(
        Posisi(
          lintang: p.latitude,
          bujur: p.longitude,
          akurasiMeter: p.accuracy,
          waktu: p.timestamp.toLocal(),
          palsu: p.isMocked,
        ),
      );
    } on TimeoutException {
      return const Gagal(WaktuHabis());
    } on LocationServiceDisabledException {
      return const Gagal(LayananLokasiMati());
    } on PermissionDeniedException {
      return const Gagal(IzinDitolak(Fitur.lokasi));
    } on PositionUpdateException {
      return const Gagal(GangguanPerangkat('position_update'));
    }
  }
}

// ====== BERKAS: lib/data/services/pemilih_foto_image_picker.dart ======

class PemilihFotoImagePicker implements PemilihFoto {
  PemilihFotoImagePicker({ImagePicker? pemilih})
    : _pemilih = pemilih ?? ImagePicker();

  final ImagePicker _pemilih;

  @override
  bool get kameraTersedia => _pemilih.supportsImageSource(ImageSource.camera);

  @override
  Future<Hasil<FotoBukti>> ambil({required bool dariKamera}) async {
    try {
      final XFile? berkas = await _pemilih.pickImage(
        source: dariKamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 720,
        imageQuality: 70,
        requestFullMetadata: false,
      );
      if (berkas == null) return const Gagal(Dibatalkan());
      return Berhasil(
        FotoBukti(nama: berkas.name, bita: await berkas.readAsBytes()),
      );
    } on PlatformException catch (e) {
      return Gagal(switch (e.code) {
        'camera_access_denied' => const IzinDiblokir(Fitur.kamera),
        'photo_access_denied' => const IzinDiblokir(Fitur.galeri),
        'no_available_camera' => const PerangkatTidakMendukung(Fitur.kamera),
        _ => GangguanPerangkat(e.code),
      });
    }
  }
}

// ===== BERKAS: lib/data/services/pengaturan_perangkat_geolocator.dart =====

class PengaturanPerangkatGeolocator implements PengaturanPerangkat {
  const PengaturanPerangkatGeolocator();

  @override
  bool get bisaDibuka => !kIsWeb;

  @override
  Future<void> bukaPengaturanAplikasi() async {
    if (bisaDibuka) await Geolocator.openAppSettings();
  }

  @override
  Future<void> bukaPengaturanLokasi() async {
    if (bisaDibuka) await Geolocator.openLocationSettings();
  }
}

// ===== BERKAS: lib/data/services/perangkat_palsu.dart (juga untuk test) =====

enum SkenarioLokasi {
  diLab('Di laboratorium'),
  diLuar('Di luar area'),
  kurangAkurat('Akurasi buruk'),
  pemalsuGps('Pemalsu GPS'),
  izinDiblokir('Izin diblokir'),
  layananMati('Layanan lokasi mati');

  const SkenarioLokasi(this.label);
  final String label;
}

/// Posisi palsu di sekitar Lab Basis Data, yang sesinya dibuka pukul
/// 13.10 (jam pengembangan).
class LayananLokasiPalsu implements LayananLokasi {
  SkenarioLokasi skenario = SkenarioLokasi.diLab;
  int dipanggil = 0;

  @override
  Future<Hasil<Posisi>> posisiSekarang() async {
    dipanggil++;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    Posisi di(double lintang, double bujur, double akurasi, bool palsu) =>
        Posisi(
          lintang: lintang,
          bujur: bujur,
          akurasiMeter: akurasi,
          waktu: DateTime.now(),
          palsu: palsu,
        );
    return switch (skenario) {
      SkenarioLokasi.diLab => Berhasil(di(-0.47125, 117.15955, 9, false)),
      SkenarioLokasi.diLuar => Berhasil(di(-0.4733, 117.1595, 7, false)),
      SkenarioLokasi.kurangAkurat => Berhasil(
        di(-0.47125, 117.15955, 120, false),
      ),
      SkenarioLokasi.pemalsuGps => Berhasil(di(-0.4712, 117.1595, 3, true)),
      SkenarioLokasi.izinDiblokir => const Gagal(IzinDiblokir(Fitur.lokasi)),
      SkenarioLokasi.layananMati => const Gagal(LayananLokasiMati()),
    };
  }
}

class PemilihFotoPalsu implements PemilihFoto {
  bool batal = false;

  @override
  bool get kameraTersedia => true;

  @override
  Future<Hasil<FotoBukti>> ambil({required bool dariKamera}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (batal) return const Gagal(Dibatalkan());
    // Bita kosong: tampilan menggambar ikon pengganti foto.
    return Berhasil(FotoBukti(nama: 'selfie_palsu.jpg', bita: Uint8List(0)));
  }
}

class PengaturanPerangkatPalsu implements PengaturanPerangkat {
  final List<String> dibuka = [];

  @override
  bool get bisaDibuka => true;

  @override
  Future<void> bukaPengaturanAplikasi() async => dibuka.add('aplikasi');

  @override
  Future<void> bukaPengaturanLokasi() async => dibuka.add('lokasi');
}

// ===== BERKAS: lib/data/repositories/repositori_presensi_memori.dart =====

class RepositoriPresensiMemori implements RepositoriPresensi {
  RepositoriPresensiMemori({required this._jam});

  final Jam _jam;
  final List<Presensi> _semua = [];
  int _nomorTerakhir = 0;

  @override
  Future<Hasil<List<SesiPraktikum>>> sesiHariIni() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final DateTime h = _jam.sekarang();
    DateTime pukul(int jam, int menit) =>
        DateTime(h.year, h.month, h.day, jam, menit);
    // Koordinat CONTOH. Ganti dengan koordinat laboratorium kampus Anda.
    return Berhasil([
      SesiPraktikum(
        kode: 'PPB-A',
        mataKuliah: 'Praktikum Pemrograman Piranti Bergerak',
        ruang: 'Lab Pemrograman',
        titik: const Koordinat(-0.4700, 117.1580),
        mulai: pukul(8, 0),
        selesai: pukul(10, 30),
      ),
      SesiPraktikum(
        kode: 'BD-B',
        mataKuliah: 'Praktikum Basis Data',
        ruang: 'Lab Basis Data',
        titik: const Koordinat(-0.4712, 117.1595),
        mulai: pukul(13, 0),
        selesai: pukul(15, 30),
      ),
      SesiPraktikum(
        kode: 'JK-A',
        mataKuliah: 'Praktikum Jaringan Komputer',
        ruang: 'Lab Jaringan',
        titik: const Koordinat(-0.4689, 117.1561),
        mulai: pukul(15, 45),
        selesai: pukul(18, 15),
      ),
    ]);
  }

  @override
  Future<Hasil<List<Presensi>>> riwayat(String nim) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return Berhasil([
      for (final Presensi p in _semua)
        if (p.nim == nim) p,
    ]);
  }

  @override
  Future<Hasil<Presensi>> simpan({
    required String kodeSesi,
    required String nim,
    required DateTime waktu,
    required double jarakMeter,
    required double akurasiMeter,
    required String namaFoto,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _nomorTerakhir++;
    final Presensi baru = Presensi(
      id: 'PR-${_nomorTerakhir.toString().padLeft(3, '0')}',
      kodeSesi: kodeSesi,
      nim: nim,
      waktu: waktu,
      jarakMeter: jarakMeter,
      akurasiMeter: akurasiMeter,
      namaFoto: namaFoto,
    );
    _semua.add(baru);
    return Berhasil(baru);
  }
}

// ================= BERKAS: lib/ui/core/perintah.dart =================

abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;
  Hasil<T>? get hasil => _hasil;

  void bersihkanHasil() {
    _hasil = null;
    _kabari();
  }

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    if (_sedangBerjalan) return; // penjaga ketukan ganda
    _sedangBerjalan = true;
    _hasil = null;
    _kabari();
    try {
      _hasil = await aksi();
    } finally {
      _sedangBerjalan = false;
      _kabari();
    }
  }

  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

class Perintah0<T> extends Perintah<T> {
  Perintah0(this._aksi);
  final Future<Hasil<T>> Function() _aksi;
  Future<void> jalankan() => _jalankan(_aksi);
}

// ================ BERKAS: lib/ui/core/tanggapan.dart ================

enum AksiPerbaikan { tidakAda, cobaLagi, bukaPengaturan, nyalakanLokasi }

class Tanggapan {
  const Tanggapan(this.pesan, this.aksi);
  final String pesan;
  final AksiPerbaikan aksi;
}

/// SATU-SATUNYA tempat yang mengubah Kegagalan menjadi kalimat dan
/// tombol. null berarti tidak perlu pesan apa pun.
Tanggapan? tanggapanUntuk(Kegagalan kegagalan) {
  return switch (kegagalan) {
    Dibatalkan() => null,
    AturanDilanggar(:final String alasan) => Tanggapan(
      alasan,
      AksiPerbaikan.tidakAda,
    ),
    LayananLokasiMati() => const Tanggapan(
      'Layanan lokasi mati. Nyalakan, lalu kirim lagi.',
      AksiPerbaikan.nyalakanLokasi,
    ),
    IzinDitolak(:final Fitur fitur) => Tanggapan(
      'Presensi membutuhkan izin ${fitur.nama}.',
      AksiPerbaikan.cobaLagi,
    ),
    IzinDiblokir(:final Fitur fitur) => Tanggapan(
      'Izin ${fitur.nama} diblokir. Jika ingin presensi lewat aplikasi '
      'ini, izinkan ${fitur.nama} di Pengaturan.',
      AksiPerbaikan.bukaPengaturan,
    ),
    PerangkatTidakMendukung(:final Fitur fitur) => Tanggapan(
      'Perangkat ini tidak memiliki ${fitur.nama}. Lakukan presensi '
      'dari HP.',
      AksiPerbaikan.tidakAda,
    ),
    WaktuHabis() => const Tanggapan(
      'Lokasi belum didapat. Pindah ke dekat jendela, lalu coba lagi.',
      AksiPerbaikan.cobaLagi,
    ),
    GangguanPerangkat(:final String kode) => Tanggapan(
      'Terjadi gangguan pada perangkat ($kode). Coba lagi.',
      AksiPerbaikan.cobaLagi,
    ),
  };
}

// ============= BERKAS: lib/ui/core/format_tanggal.dart =============

const List<String> _namaHari = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

const List<String> _namaBulan = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

/// Jumat, 16 Oktober
String teksTanggal(DateTime w) =>
    '${_namaHari[w.weekday - 1]}, ${w.day} ${_namaBulan[w.month - 1]}';

// ================== BERKAS: lib/ui/core/aplikasi.dart ==================

class AplikasiPresensi extends StatelessWidget {
  const AplikasiPresensi({super.key, required this.lingkungan});

  final Lingkungan lingkungan;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensi Praktikum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        if (lingkungan == Lingkungan.pengembangan) {
          return Banner(
            message: 'DATA PALSU',
            location: BannerLocation.topEnd,
            child: child!,
          );
        }
        return child!;
      },
      home: ChangeNotifierProvider(
        create: (BuildContext context) => BerandaViewModel(
          repositori: context.read<RepositoriPresensi>(),
          jam: context.read<Jam>(),
          mahasiswa: context.read<Mahasiswa>(),
        ),
        child: const HalamanUtama(),
      ),
    );
  }
}

// ======= BERKAS: lib/ui/beranda/view_models/beranda_view_model.dart =======

class BerandaViewModel extends ChangeNotifier {
  BerandaViewModel({
    required this._repositori,
    required this._jam,
    required this.mahasiswa,
  }) {
    muat = Perintah0<void>(_muat)..jalankan();
  }

  final RepositoriPresensi _repositori;
  final Jam _jam;
  final Mahasiswa mahasiswa;

  late final Perintah0<void> muat;

  List<SesiPraktikum> _sesi = [];
  List<Presensi> _riwayat = [];
  bool _sudahDibuang = false;

  DateTime get sekarang => _jam.sekarang();
  List<Presensi> get riwayat => _riwayat;

  List<(SesiPraktikum, StatusSesi)> get jadwal => [
    for (final SesiPraktikum s in _sesi)
      (
        s,
        statusSesi(
          s,
          sekarang: sekarang,
          sudahPresensi: _riwayat.any((Presensi p) => p.kodeSesi == s.kode),
        ),
      ),
  ];

  SesiPraktikum? sesiUntuk(String kode) {
    for (final SesiPraktikum s in _sesi) {
      if (s.kode == kode) return s;
    }
    return null;
  }

  Future<Hasil<void>> _muat() async {
    final Hasil<List<SesiPraktikum>> hasilSesi = await _repositori
        .sesiHariIni();
    final Hasil<List<Presensi>> hasilRiwayat = await _repositori.riwayat(
      mahasiswa.nim,
    );
    if (_sudahDibuang) return const Berhasil<void>(null);
    switch ((hasilSesi, hasilRiwayat)) {
      case (Berhasil(nilai: final sesi), Berhasil(nilai: final riwayat)):
        _sesi = sesi;
        _riwayat = riwayat;
        notifyListeners();
        return const Berhasil<void>(null);
      case (Gagal(:final Kegagalan kegagalan), _):
      case (_, Gagal(:final Kegagalan kegagalan)):
        return Gagal(kegagalan);
    }
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    muat.dispose();
    super.dispose();
  }
}

// ====== BERKAS: lib/ui/presensi/view_models/presensi_view_model.dart ======

class PresensiViewModel extends ChangeNotifier {
  PresensiViewModel({
    required this.sesi,
    required this._pemilihFoto,
    required this._catatPresensi,
    required this._pengaturan,
  }) {
    ambilFoto = Perintah0<FotoBukti>(_ambilFoto);
    kirim = Perintah0<Presensi>(_kirim);
  }

  final SesiPraktikum sesi;
  final PemilihFoto _pemilihFoto;
  final CatatPresensi _catatPresensi;
  final PengaturanPerangkat _pengaturan;

  late final Perintah0<FotoBukti> ambilFoto;
  late final Perintah0<Presensi> kirim;

  FotoBukti? _foto;

  FotoBukti? get foto => _foto;
  bool get kameraTersedia => _pemilihFoto.kameraTersedia;
  bool get pengaturanBisaDibuka => _pengaturan.bisaDibuka;

  Future<Hasil<FotoBukti>> _ambilFoto() async {
    // Presensi hanya menerima foto KAMERA, bukan dari galeri.
    final Hasil<FotoBukti> hasil = await _pemilihFoto.ambil(dariKamera: true);
    if (hasil case Berhasil(:final FotoBukti nilai)) {
      _foto = nilai;
      notifyListeners();
    }
    return hasil;
  }

  Future<Hasil<Presensi>> _kirim() =>
      _catatPresensi.jalankan(sesi: sesi, foto: _foto);

  Future<void> perbaiki(AksiPerbaikan aksi) async {
    switch (aksi) {
      case AksiPerbaikan.cobaLagi:
        await kirim.jalankan();
      case AksiPerbaikan.bukaPengaturan:
        await _pengaturan.bukaPengaturanAplikasi();
      case AksiPerbaikan.nyalakanLokasi:
        await _pengaturan.bukaPengaturanLokasi();
      case AksiPerbaikan.tidakAda:
        break;
    }
  }

  @override
  void dispose() {
    ambilFoto.dispose();
    kirim.dispose();
    super.dispose();
  }
}

// ============== BERKAS: lib/ui/beranda/widgets/halaman_utama.dart ==============

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Presensi Praktikum')),
      body: switch (_indeks) {
        0 => const TabJadwal(),
        _ => const TabRiwayat(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (int indeks) {
          setState(() => _indeks = indeks);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Jadwal',
          ),
          NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
    );
  }
}

class TabJadwal extends StatelessWidget {
  const TabJadwal({super.key});

  Future<void> _bukaPresensi(BuildContext context, SesiPraktikum sesi) async {
    final BerandaViewModel vm = context.read<BerandaViewModel>();
    final bool? tercatat = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => HalamanPresensi(sesi: sesi),
      ),
    );
    if (tercatat == true) await vm.muat.jalankan();
  }

  @override
  Widget build(BuildContext context) {
    final BerandaViewModel vm = context.watch<BerandaViewModel>();
    final TextTheme teks = Theme.of(context).textTheme;
    if (vm.muat.sedangBerjalan && vm.jadwal.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(teksTanggal(vm.sekarang), style: teks.titleLarge),
        Text('${vm.mahasiswa.nama} · ${vm.mahasiswa.nim}'),
        const SizedBox(height: 12),
        for (final (SesiPraktikum sesi, StatusSesi status) in vm.jadwal)
          Card(
            child: ListTile(
              leading: const Icon(Icons.science_outlined),
              title: Text(sesi.mataKuliah),
              subtitle: Text(
                '${sesi.ruang} · ${teksJam(sesi.mulai)}–'
                '${teksJam(sesi.selesai)}\n${_teksStatus(sesi, status)}',
              ),
              isThreeLine: true,
              trailing: status == StatusSesi.dibuka
                  ? const Icon(Icons.chevron_right)
                  : _ikonStatus(context, status),
              onTap: status == StatusSesi.dibuka
                  ? () => _bukaPresensi(context, sesi)
                  : null,
            ),
          ),
      ],
    );
  }

  String _teksStatus(SesiPraktikum sesi, StatusSesi status) {
    return switch (status) {
      StatusSesi.belumDibuka =>
        'Presensi dibuka pukul ${teksJam(sesi.presensiDibuka)}',
      StatusSesi.dibuka =>
        'Presensi DIBUKA sampai ${teksJam(sesi.presensiDitutup)}',
      StatusSesi.sudahPresensi => 'Sudah presensi',
      StatusSesi.ditutup => 'Presensi sudah ditutup',
    };
  }

  Widget _ikonStatus(BuildContext context, StatusSesi status) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    return switch (status) {
      StatusSesi.sudahPresensi => Icon(
        Icons.check_circle,
        color: warna.primary,
      ),
      StatusSesi.ditutup => Icon(Icons.lock_clock, color: warna.outline),
      StatusSesi.belumDibuka ||
      StatusSesi.dibuka => Icon(Icons.schedule, color: warna.outline),
    };
  }
}

class TabRiwayat extends StatelessWidget {
  const TabRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    final BerandaViewModel vm = context.watch<BerandaViewModel>();
    if (vm.riwayat.isEmpty) {
      return const Center(child: Text('Belum ada presensi hari ini.'));
    }
    return ListView(
      children: [
        for (final Presensi p in vm.riwayat.reversed)
          ListTile(
            leading: const Icon(Icons.verified_outlined),
            title: Text(vm.sesiUntuk(p.kodeSesi)?.mataKuliah ?? p.kodeSesi),
            subtitle: Text(
              'Pukul ${teksJam(p.waktu)} · ${p.jarakMeter.round()} m dari '
              '${vm.sesiUntuk(p.kodeSesi)?.ruang ?? 'lab'} · '
              '± ${p.akurasiMeter.round()} m',
            ),
            trailing: Text(p.id),
          ),
      ],
    );
  }
}

// ============ BERKAS: lib/ui/presensi/widgets/halaman_presensi.dart ============

class HalamanPresensi extends StatelessWidget {
  const HalamanPresensi({super.key, required this.sesi});

  final SesiPraktikum sesi;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PresensiViewModel(
        sesi: sesi,
        pemilihFoto: context.read<PemilihFoto>(),
        catatPresensi: context.read<CatatPresensi>(),
        pengaturan: context.read<PengaturanPerangkat>(),
      ),
      child: const _IsiPresensi(),
    );
  }
}

class _IsiPresensi extends StatefulWidget {
  const _IsiPresensi();

  @override
  State<_IsiPresensi> createState() => _IsiPresensiState();
}

class _IsiPresensiState extends State<_IsiPresensi> {
  late final PresensiViewModel _vm;
  late final AppLifecycleListener _pendengar;

  @override
  void initState() {
    super.initState();
    _vm = context.read<PresensiViewModel>();
    _vm.kirim.addListener(_saatKirimBerubah);
    _pendengar = AppLifecycleListener(onResume: _saatKembali);
  }

  @override
  void dispose() {
    _vm.kirim.removeListener(_saatKirimBerubah);
    _pendengar.dispose();
    super.dispose();
  }

  /// Berhasil: beri tahu, lalu kembali ke jadwal.
  void _saatKirimBerubah() {
    final Hasil<Presensi>? hasil = _vm.kirim.hasil;
    if (hasil is! Berhasil<Presensi>) return;
    _vm.kirim.bersihkanHasil();
    final Presensi p = hasil.nilai;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Presensi tercatat pukul ${teksJam(p.waktu)} '
          '(${p.jarakMeter.round()} m dari ${_vm.sesi.ruang}).',
        ),
      ),
    );
    Navigator.of(context).pop(true);
  }

  /// Kembali dari Pengaturan: hapus pesan lama tentang izin atau layanan,
  /// agar pengguna bisa langsung menekan Kirim lagi.
  void _saatKembali() {
    final Hasil<Presensi>? hasil = _vm.kirim.hasil;
    if (hasil case Gagal(kegagalan: IzinDiblokir() || LayananLokasiMati())) {
      _vm.kirim.bersihkanHasil();
    }
  }

  @override
  Widget build(BuildContext context) {
    final PresensiViewModel vm = context.watch<PresensiViewModel>();
    final SesiPraktikum sesi = vm.sesi;
    final LayananLokasi lokasi = context.watch<LayananLokasi>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi'),
        actions: [
          // Hanya ada di lingkungan pengembangan.
          if (lokasi is LayananLokasiPalsu) _MenuSkenario(lokasi: lokasi),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(sesi.mataKuliah, style: Theme.of(context).textTheme.titleLarge),
          Text(
            '${sesi.ruang} · ${teksJam(sesi.mulai)}–${teksJam(sesi.selesai)} '
            '· presensi ${teksJam(sesi.presensiDibuka)}–'
            '${teksJam(sesi.presensiDitutup)}',
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: vm.ambilFoto,
            builder: (BuildContext context, _) => _LangkahFoto(vm: vm),
          ),
          const SizedBox(height: 12),
          ListenableBuilder(
            listenable: vm.kirim,
            builder: (BuildContext context, _) => _LangkahKirim(vm: vm),
          ),
        ],
      ),
    );
  }
}

class _MenuSkenario extends StatelessWidget {
  const _MenuSkenario({required this.lokasi});

  final LayananLokasiPalsu lokasi;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SkenarioLokasi>(
      icon: const Icon(Icons.tune),
      tooltip: 'Skenario lokasi palsu',
      initialValue: lokasi.skenario,
      onSelected: (SkenarioLokasi s) => lokasi.skenario = s,
      itemBuilder: (BuildContext context) => [
        for (final SkenarioLokasi s in SkenarioLokasi.values)
          PopupMenuItem(value: s, child: Text(s.label)),
      ],
    );
  }
}

class _LangkahFoto extends StatelessWidget {
  const _LangkahFoto({required this.vm});

  final PresensiViewModel vm;

  @override
  Widget build(BuildContext context) {
    final FotoBukti? foto = vm.foto;
    final ColorScheme warna = Theme.of(context).colorScheme;
    final Hasil<FotoBukti>? hasil = vm.ambilFoto.hasil;
    final Tanggapan? masalah = hasil is Gagal<FotoBukti>
        ? tanggapanUntuk(hasil.kegagalan)
        : null;

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox.square(
                dimension: 72,
                child: foto == null || foto.bita.isEmpty
                    ? ColoredBox(
                        color: warna.surfaceContainerHighest,
                        child: Icon(
                          foto == null
                              ? Icons.face
                              : Icons.face_retouching_natural,
                          size: 40,
                          color: warna.outline,
                        ),
                      )
                    : Image.memory(
                        foto.bita,
                        fit: BoxFit.cover,
                        cacheWidth: 216,
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('1. Foto selfie'),
                  if (!vm.kameraTersedia)
                    const Text('Perangkat ini tidak memiliki kamera.')
                  else
                    TextButton.icon(
                      onPressed: vm.ambilFoto.sedangBerjalan
                          ? null
                          : vm.ambilFoto.jalankan,
                      icon: const Icon(Icons.photo_camera_front_outlined),
                      label: Text(foto == null ? 'Ambil foto' : 'Ulangi foto'),
                    ),
                  if (masalah != null)
                    Text(masalah.pesan, style: TextStyle(color: warna.error)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LangkahKirim extends StatelessWidget {
  const _LangkahKirim({required this.vm});

  final PresensiViewModel vm;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final bool sibuk = vm.kirim.sedangBerjalan;
    final Hasil<Presensi>? hasil = vm.kirim.hasil;
    final Tanggapan? masalah = hasil is Gagal<Presensi>
        ? tanggapanUntuk(hasil.kegagalan)
        : null;

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('2. Kirim presensi'),
            const SizedBox(height: 4),
            Text(
              'Lokasi Anda diambil saat tombol Kirim ditekan, hanya untuk '
              'memeriksa jarak ke ${vm.sesi.ruang} (paling jauh '
              '${vm.sesi.radiusMeter} m).',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: sibuk || vm.foto == null ? null : vm.kirim.jalankan,
              icon: sibuk
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(sibuk ? 'Memeriksa lokasi...' : 'Kirim presensi'),
            ),
            if (masalah != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: warna.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      masalah.pesan,
                      style: TextStyle(color: warna.onErrorContainer),
                    ),
                    ..._tombolPerbaikan(masalah.aksi, warna),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _tombolPerbaikan(AksiPerbaikan aksi, ColorScheme warna) {
    final bool lewatPengaturan =
        aksi == AksiPerbaikan.bukaPengaturan ||
        aksi == AksiPerbaikan.nyalakanLokasi;
    if (aksi == AksiPerbaikan.tidakAda) return const [];
    if (lewatPengaturan && !vm.pengaturanBisaDibuka) {
      // Di browser: izin situs diatur lewat ikon di sebelah kiri alamat.
      return [
        const SizedBox(height: 8),
        Text(
          'Klik ikon di sebelah kiri alamat situs, izinkan Lokasi dan '
          'Kamera, lalu kirim lagi.',
          style: TextStyle(color: warna.onErrorContainer),
        ),
      ];
    }
    return [
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: FilledButton.tonal(
          onPressed: () => vm.perbaiki(aksi),
          child: Text(switch (aksi) {
            AksiPerbaikan.cobaLagi => 'Coba lagi',
            AksiPerbaikan.nyalakanLokasi => 'Buka Pengaturan Lokasi',
            AksiPerbaikan.bukaPengaturan ||
            AksiPerbaikan.tidakAda => 'Buka Pengaturan',
          }),
        ),
      ),
    ];
  }
}

// =============== PEMERIKSAAN (di proyek: folder test/) ===============
// Semua lapisan diperiksa dengan data palsu dan jam tetap, tanpa HP,
// tanpa dialog izin, dan tanpa GPS.

int _lulus = 0;
int _jumlah = 0;

void periksa(String nama, Object? didapat, Object? diharapkan) {
  _jumlah++;
  if (didapat == diharapkan) {
    _lulus++;
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

String ringkas<T>(Hasil<T> hasil) {
  return switch (hasil) {
    Berhasil(:final T nilai) =>
      nilai is Presensi ? 'berhasil ${nilai.id}' : 'berhasil',
    Gagal(:final Kegagalan kegagalan) => switch (kegagalan) {
      AturanDilanggar(:final String alasan) => 'ditolak: $alasan',
      IzinDiblokir(:final Fitur fitur) => 'izin ${fitur.nama} diblokir',
      IzinDitolak(:final Fitur fitur) => 'izin ${fitur.nama} ditolak',
      LayananLokasiMati() => 'layanan lokasi mati',
      PerangkatTidakMendukung() => 'tidak didukung',
      Dibatalkan() => 'dibatalkan',
      WaktuHabis() => 'waktu habis',
      GangguanPerangkat(:final String kode) => 'gangguan $kode',
    },
  };
}

Future<void> jalankanUji() async {
  debugPrint('=== Pemeriksaan Presensi Praktikum ===');
  DateTime pukul(int jam, int menit) => DateTime(2026, 10, 16, jam, menit);
  final SesiPraktikum bd = SesiPraktikum(
    kode: 'BD-B',
    mataKuliah: 'Praktikum Basis Data',
    ruang: 'Lab Basis Data',
    titik: const Koordinat(-0.4712, 117.1595),
    mulai: pukul(13, 0),
    selesai: pukul(15, 30),
  );
  final FotoBukti selfie = FotoBukti(nama: 'selfie.jpg', bita: Uint8List(0));
  Posisi di(double lintang, double bujur, {double akurasi = 9}) => Posisi(
    lintang: lintang,
    bujur: bujur,
    akurasiMeter: akurasi,
    waktu: pukul(13, 10),
  );

  // ---- 1. Domain (Dart murni) ----
  periksa(
    'Jarak dua titik contoh = 25 m',
    jarakMeter(
      const Koordinat(-0.4700, 117.1580),
      const Koordinat(-0.4702, 117.1581),
    ).round(),
    25,
  );
  StatusSesi status(int jam, int menit) =>
      statusSesi(bd, sekarang: pukul(jam, menit), sudahPresensi: false);
  periksa('12.44 belum dibuka', status(12, 44), StatusSesi.belumDibuka);
  periksa('12.45 dibuka', status(12, 45), StatusSesi.dibuka);
  periksa('13.30 masih dibuka', status(13, 30), StatusSesi.dibuka);
  periksa('13.31 ditutup', status(13, 31), StatusSesi.ditutup);
  periksa(
    'Tanpa foto ditolak',
    periksaSebelumLokasi(
      sesi: bd,
      foto: null,
      sekarang: pukul(13, 10),
      sudahPresensi: false,
    ),
    'Ambil foto selfie terlebih dahulu.',
  );
  periksa(
    'Di dalam radius (8 m) diterima',
    periksaLokasi(sesi: bd, posisi: di(-0.47125, 117.15955)),
    null,
  );
  periksa(
    'Akurasi 120 m ditolak',
    periksaLokasi(
      sesi: bd,
      posisi: di(-0.47125, 117.15955, akurasi: 120),
    )?.startsWith('Lokasi kurang akurat (± 120 m).'),
    true,
  );
  periksa(
    '234 m dari lab ditolak',
    periksaLokasi(sesi: bd, posisi: di(-0.4733, 117.1595)),
    'Anda berada 234 m dari Lab Basis Data. Presensi hanya bisa dalam '
        'radius 100 m.',
  );

  // ---- 2. Use case dengan data palsu ----
  Jam jamTetap(int jam, int menit) => Jam(() => pukul(jam, menit));
  final RepositoriPresensiMemori repo = RepositoriPresensiMemori(
    jam: jamTetap(13, 10),
  );
  final LayananLokasiPalsu lokasi = LayananLokasiPalsu();
  CatatPresensi catat(Jam jam) => CatatPresensi(
    repositori: repo,
    lokasi: lokasi,
    jam: jam,
    mahasiswa: mahasiswaAktif,
  );
  final CatatPresensi pukul1310 = catat(jamTetap(13, 10));

  periksa(
    'Di lab pukul 13.10 -> tercatat',
    ringkas(await pukul1310.jalankan(sesi: bd, foto: selfie)),
    'berhasil PR-001',
  );
  final int panggilan = lokasi.dipanggil;
  periksa(
    'Presensi kedua -> ditolak',
    ringkas(await pukul1310.jalankan(sesi: bd, foto: selfie)),
    'ditolak: Anda sudah presensi untuk sesi ini.',
  );
  periksa(
    'Presensi kedua -> lokasi TIDAK diminta',
    lokasi.dipanggil,
    panggilan,
  );
  final RepositoriPresensiMemori repoBaru = RepositoriPresensiMemori(
    jam: jamTetap(14, 0),
  );
  final CatatPresensi pukul1400 = CatatPresensi(
    repositori: repoBaru,
    lokasi: lokasi,
    jam: jamTetap(14, 0),
    mahasiswa: mahasiswaAktif,
  );
  periksa(
    'Pukul 14.00 -> ditutup, lokasi tidak diminta',
    '${ringkas(await pukul1400.jalankan(sesi: bd, foto: selfie))} / '
        '${lokasi.dipanggil == panggilan}',
    'ditolak: Presensi sudah ditutup pukul 13.30. / true',
  );
  lokasi.skenario = SkenarioLokasi.izinDiblokir;
  final RepositoriPresensiMemori repoKosong = RepositoriPresensiMemori(
    jam: jamTetap(13, 10),
  );
  final CatatPresensi blokir = CatatPresensi(
    repositori: repoKosong,
    lokasi: lokasi,
    jam: jamTetap(13, 10),
    mahasiswa: mahasiswaAktif,
  );
  final String hasilBlokir = ringkas(
    await blokir.jalankan(sesi: bd, foto: selfie),
  );
  final Hasil<List<Presensi>> sisa = await repoKosong.riwayat(
    mahasiswaAktif.nim,
  );
  periksa(
    'Izin lokasi diblokir -> gagal, tidak tersimpan',
    '$hasilBlokir / ${sisa is Berhasil<List<Presensi>> ? sisa.nilai.length : -1}',
    'izin lokasi diblokir / 0',
  );
  periksa(
    'Izin diblokir -> tombol Buka Pengaturan',
    tanggapanUntuk(const IzinDiblokir(Fitur.lokasi))?.aksi,
    AksiPerbaikan.bukaPengaturan,
  );

  // ---- 3. ViewModel ----
  lokasi.skenario = SkenarioLokasi.diLab;
  final PemilihFotoPalsu kamera = PemilihFotoPalsu();
  PresensiViewModel vmBaru(RepositoriPresensiMemori r) => PresensiViewModel(
    sesi: bd,
    pemilihFoto: kamera,
    catatPresensi: CatatPresensi(
      repositori: r,
      lokasi: lokasi,
      jam: jamTetap(13, 10),
      mahasiswa: mahasiswaAktif,
    ),
    pengaturan: PengaturanPerangkatPalsu(),
  );
  final RepositoriPresensiMemori repoVm = RepositoriPresensiMemori(
    jam: jamTetap(13, 10),
  );
  final PresensiViewModel vm = vmBaru(repoVm);
  await vm.kirim.jalankan();
  final Hasil<Presensi>? tanpaFoto = vm.kirim.hasil;
  periksa(
    'Kirim tanpa foto -> diminta foto',
    tanpaFoto == null ? null : ringkas(tanpaFoto),
    'ditolak: Ambil foto selfie terlebih dahulu.',
  );
  kamera.batal = true;
  await vm.ambilFoto.jalankan();
  periksa('Foto dibatalkan -> foto tetap kosong', vm.foto, null);
  kamera.batal = false;
  await vm.ambilFoto.jalankan();
  await Future.wait([vm.kirim.jalankan(), vm.kirim.jalankan()]);
  final Hasil<List<Presensi>> tercatat = await repoVm.riwayat(
    mahasiswaAktif.nim,
  );
  periksa(
    'Dua ketukan cepat -> satu presensi',
    tercatat is Berhasil<List<Presensi>> ? tercatat.nilai.length : -1,
    1,
  );

  debugPrint('Ringkasan: $_lulus dari $_jumlah uji lulus');
}
