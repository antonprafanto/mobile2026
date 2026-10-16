// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 12: CLEAN ARCHITECTURE
// CONTOH 08: Studi Kasus "Pinjam Ruang Kampus"
// Topik: Aplikasi peminjaman ruang yang ditata menjadi tiga lapisan:
//        - DOMAIN : entitas (Ruang, Peminjaman, RentangWaktu), aturan
//                   bisnis, kontrak repository, Hasil/Kegagalan, dan
//                   use case AjukanPeminjaman. Semuanya Dart murni.
//        - DATA   : layanan HTTP, model API (JSON berbahasa Inggris),
//                   dan implementasi repository (server dan memori).
//        - UI     : ViewModel (dengan Perintah/Command) dan View.
//        Lapisan dirakit di SATU tempat (buatPenyedia). Ganti nilai
//        konstanta lingkungan untuk berpindah dari data server ke data
//        palsu, tanpa mengubah satu baris pun di domain dan UI.
//        Sebelum aplikasi tampil, jalankanUji() memeriksa aturan bisnis,
//        use case, repository, dan ViewModel memakai data palsu. Lihat
//        hasilnya di konsol.
//        Setiap bagian diberi judul "BERKAS: lib/..." yang menunjukkan
//        letaknya jika aplikasi ini dipecah menjadi banyak berkas.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: jalankan sekali `flutter pub add http provider`,
//    salin seluruh isi berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome --web-port=8080
// =====================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ======================= BERKAS: lib/main.dart =======================

// Satu-satunya baris yang perlu diubah untuk memakai data palsu:
// Lingkungan.pengembangan. Data ruang server diambil dari berkas
// data/ruang_kampus.json di repositori GitHub mata kuliah ini.
const Lingkungan lingkungan = Lingkungan.produksi;

Future<void> main() async {
  await jalankanUji();
  runApp(
    MultiProvider(
      providers: buatPenyedia(lingkungan),
      child: const AplikasiPinjamRuang(lingkungan: lingkungan),
    ),
  );
}

// ================== BERKAS: lib/config/dependensi.dart ==================
// "Akar komposisi" (composition root): SATU-SATUNYA tempat yang tahu
// implementasi mana yang dipakai. Lapisan lain hanya mengenal kontraknya.

enum Lingkungan { pengembangan, produksi }

const Pengguna penggunaAktif = Pengguna(
  nim: '2609106001',
  nama: 'Budi Santoso',
);

List<SingleChildWidget> buatPenyedia(Lingkungan lingkungan) {
  return [
    Provider<Pengguna>.value(value: penggunaAktif),
    ...switch (lingkungan) {
      Lingkungan.pengembangan => [
        Provider<RepositoriRuang>(
          create: (BuildContext context) => RepositoriRuangMemori(),
        ),
      ],
      Lingkungan.produksi => [
        Provider<LayananApiKampus>(
          create: (BuildContext context) => LayananApiKampus(),
          dispose: (BuildContext context, LayananApiKampus layanan) =>
              layanan.tutup(),
        ),
        Provider<RepositoriRuang>(
          create: (BuildContext context) =>
              RepositoriRuangServer(layanan: context.read<LayananApiKampus>()),
        ),
      ],
    },
    // Di kedua lingkungan, peminjaman disimpan di memori. Di proyek
    // sungguhan, baris ini diganti RepositoriPeminjamanSqlite
    // (Pertemuan 11) tanpa mengubah lapisan lain.
    Provider<RepositoriPeminjaman>(
      create: (BuildContext context) =>
          RepositoriPeminjamanMemori(pemilikContoh: penggunaAktif),
    ),
    Provider<AjukanPeminjaman>(
      create: (BuildContext context) => AjukanPeminjaman(
        ruang: context.read<RepositoriRuang>(),
        peminjaman: context.read<RepositoriPeminjaman>(),
      ),
    ),
  ];
}

// ===================== BERKAS: lib/domain/hasil.dart =====================
// Hasil<T> = "kotak" berisi nilai (Berhasil) ATAU kegagalan (Gagal).
// T adalah jenis isinya, misalnya Hasil<List<Ruang>>. Karena sealed,
// switch wajib menangani kedua kemungkinan.

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

// Bahasa kegagalan milik aplikasi. UI tidak perlu tahu ClientException,
// TimeoutException, atau FormatException: lapisan data menerjemahkannya.
sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class WaktuHabis extends Kegagalan {
  const WaktuHabis();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

final class DataRusak extends Kegagalan {
  const DataRusak();
}

// Permintaan pengguna melanggar aturan bisnis. Alasannya ditulis domain.
final class AturanDilanggar extends Kegagalan {
  const AturanDilanggar(this.alasan);

  final String alasan;
}

// ================= BERKAS: lib/domain/models/ruang.dart =================

enum Fasilitas {
  proyektor('Proyektor'),
  pendinginRuangan('AC'),
  komputer('Komputer'),
  papanTulis('Papan tulis'),
  pengerasSuara('Pengeras suara');

  const Fasilitas(this.label);

  final String label;
}

// Entitas: data yang dibutuhkan APLIKASI, dengan nama milik kita sendiri.
// Semua field final (immutable): untuk mengubah, buat objek baru.
class Ruang {
  const Ruang({
    required this.kode,
    required this.nama,
    required this.gedung,
    required this.lantai,
    required this.kapasitas,
    required this.fasilitas,
  });

  final String kode;
  final String nama;
  final String gedung;
  final int lantai;
  final int kapasitas;
  final List<Fasilitas> fasilitas;
}

// ================= BERKAS: lib/domain/models/pengguna.dart =================

class Pengguna {
  const Pengguna({required this.nim, required this.nama});

  final String nim;
  final String nama;
}

// ============== BERKAS: lib/domain/models/rentang_waktu.dart ==============

// Objek nilai (value object): dua rentang dengan jam yang sama dianggap
// sama, sehingga operator == dan hashCode ditulis sendiri.
class RentangWaktu {
  const RentangWaktu({required this.mulai, required this.selesai});

  final DateTime mulai;
  final DateTime selesai;

  Duration get durasi => selesai.difference(mulai);

  // Dua rentang bertumpuk jika yang satu mulai sebelum yang lain selesai.
  // 09.00-11.00 dan 11.00-12.00 TIDAK bertumpuk (bersambung).
  bool bertumpukDengan(RentangWaktu lain) {
    return mulai.isBefore(lain.selesai) && lain.mulai.isBefore(selesai);
  }

  bool samaHari(DateTime tanggal) {
    return mulai.year == tanggal.year &&
        mulai.month == tanggal.month &&
        mulai.day == tanggal.day;
  }

  String get teksJam => '${_jam(mulai)}–${_jam(selesai)}';

  static String _jam(DateTime t) {
    final String jam = t.hour.toString().padLeft(2, '0');
    final String menit = t.minute.toString().padLeft(2, '0');
    return '$jam.$menit';
  }

  @override
  bool operator ==(Object other) {
    return other is RentangWaktu &&
        other.mulai == mulai &&
        other.selesai == selesai;
  }

  @override
  int get hashCode => Object.hash(mulai, selesai);
}

// ================ BERKAS: lib/domain/models/peminjaman.dart ================

class Peminjaman {
  const Peminjaman({
    required this.id,
    required this.kodeRuang,
    required this.peminjam,
    required this.keperluan,
    required this.jumlahPeserta,
    required this.waktu,
  });

  final String id;
  final String kodeRuang;
  final Pengguna peminjam;
  final String keperluan;
  final int jumlahPeserta;
  final RentangWaktu waktu;
}

// Data yang diisi pengguna di formulir, sebelum menjadi Peminjaman
// (belum punya id dan belum diperiksa).
class PengajuanPeminjaman {
  const PengajuanPeminjaman({
    required this.kodeRuang,
    required this.keperluan,
    required this.jumlahPeserta,
    required this.waktu,
  });

  final String kodeRuang;
  final String keperluan;
  final int jumlahPeserta;
  final RentangWaktu waktu;
}

// ========== BERKAS: lib/domain/models/aturan_peminjaman.dart ==========
// Aturan bisnis yang cukup diperiksa dari pengajuannya sendiri (ditambah
// data ruang dan jam saat ini). Dart murni: bisa diuji tanpa layar.

const int jamBuka = 7; // 07.00
const int jamTutup = 21; // 21.00
const Duration durasiMinimal = Duration(minutes: 30);
const Duration durasiMaksimal = Duration(hours: 3);

bool hariKerja(DateTime tanggal) => tanggal.weekday <= DateTime.friday;

// Mengembalikan alasan penolakan, atau null jika pengajuan wajar.
String? periksaPengajuan(
  PengajuanPeminjaman pengajuan, {
  required Ruang ruang,
  required DateTime sekarang,
}) {
  final RentangWaktu waktu = pengajuan.waktu;
  if (pengajuan.keperluan.trim().isEmpty) {
    return 'Keperluan wajib diisi.';
  }
  if (pengajuan.jumlahPeserta < 1) {
    return 'Jumlah peserta minimal 1 orang.';
  }
  if (pengajuan.jumlahPeserta > ruang.kapasitas) {
    return 'Peserta (${pengajuan.jumlahPeserta}) melebihi kapasitas '
        '${ruang.nama} (${ruang.kapasitas} orang).';
  }
  if (!waktu.selesai.isAfter(waktu.mulai)) {
    return 'Jam selesai harus setelah jam mulai.';
  }
  if (waktu.durasi < durasiMinimal || waktu.durasi > durasiMaksimal) {
    return 'Lama peminjaman harus 30 menit sampai 3 jam.';
  }
  if (!hariKerja(waktu.mulai)) {
    return 'Ruang hanya bisa dipinjam Senin sampai Jumat.';
  }
  final DateTime buka = DateTime(
    waktu.mulai.year,
    waktu.mulai.month,
    waktu.mulai.day,
    jamBuka,
  );
  final DateTime tutup = DateTime(
    waktu.mulai.year,
    waktu.mulai.month,
    waktu.mulai.day,
    jamTutup,
  );
  if (waktu.mulai.isBefore(buka) || waktu.selesai.isAfter(tutup)) {
    return 'Ruang hanya bisa dipinjam pukul 07.00 sampai 21.00.';
  }
  if (!waktu.mulai.isAfter(sekarang)) {
    return 'Waktu mulai sudah lewat. Pilih jam yang akan datang.';
  }
  return null;
}

// ============ BERKAS: lib/domain/repositories/repositori_ruang.dart ============
// KONTRAK. Domain hanya menyebut APA yang dibutuhkan, bukan BAGAIMANA
// mengambilnya. Implementasinya ada di lapisan data.

abstract class RepositoriRuang {
  // segarkan: true = abaikan salinan di memori, ambil ulang dari sumbernya.
  Future<Hasil<List<Ruang>>> semuaRuang({bool segarkan = false});
}

// ========= BERKAS: lib/domain/repositories/repositori_peminjaman.dart =========

abstract class RepositoriPeminjaman {
  Future<Hasil<List<Peminjaman>>> milikRuang(String kodeRuang);

  Future<Hasil<List<Peminjaman>>> milikPengguna(String nim);

  Future<Hasil<Peminjaman>> simpan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  );

  Future<Hasil<void>> batalkan(String id);
}

// ========== BERKAS: lib/domain/use_cases/ajukan_peminjaman.dart ==========
// Use case dipakai karena logikanya MENGGABUNGKAN dua repository (ruang
// dan peminjaman) dan berisi aturan yang tidak boleh terlewat.

class AjukanPeminjaman {
  // sekarang disuntikkan agar pengujian bisa memakai jam tetap.
  AjukanPeminjaman({
    required this._ruang,
    required this._peminjaman,
    DateTime Function()? sekarang,
  }) : _sekarang = sekarang ?? DateTime.now;

  static const int batasPeminjamanAktif = 2;

  final RepositoriRuang _ruang;
  final RepositoriPeminjaman _peminjaman;
  final DateTime Function() _sekarang;

  Future<Hasil<Peminjaman>> jalankan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  ) async {
    final DateTime sekarang = _sekarang();

    // 1. Data ruang dibutuhkan untuk memeriksa kapasitas.
    final Hasil<List<Ruang>> hasilRuang = await _ruang.semuaRuang();
    final List<Ruang> semuaRuang;
    switch (hasilRuang) {
      case Gagal():
        return Gagal(hasilRuang.kegagalan);
      case Berhasil():
        semuaRuang = hasilRuang.nilai;
    }
    final Ruang? ruang = semuaRuang
        .where((Ruang r) => r.kode == pengajuan.kodeRuang)
        .firstOrNull;
    if (ruang == null) {
      return const Gagal(AturanDilanggar('Ruang tidak ditemukan.'));
    }

    // 2. Aturan yang cukup dilihat dari pengajuannya sendiri.
    final String? masalah = periksaPengajuan(
      pengajuan,
      ruang: ruang,
      sekarang: sekarang,
    );
    if (masalah != null) {
      return Gagal(AturanDilanggar(masalah));
    }

    // 3. Tidak boleh bentrok dengan peminjaman lain di ruang yang sama.
    final Hasil<List<Peminjaman>> hasilRuangIni = await _peminjaman.milikRuang(
      ruang.kode,
    );
    switch (hasilRuangIni) {
      case Gagal():
        return Gagal(hasilRuangIni.kegagalan);
      case Berhasil():
        for (final Peminjaman lain in hasilRuangIni.nilai) {
          if (lain.waktu.bertumpukDengan(pengajuan.waktu)) {
            return Gagal(
              AturanDilanggar(
                'Bentrok dengan "${lain.keperluan}" '
                'pukul ${lain.waktu.teksJam}.',
              ),
            );
          }
        }
    }

    // 4. Satu orang paling banyak punya 2 peminjaman yang belum selesai.
    final Hasil<List<Peminjaman>> hasilMilikku = await _peminjaman
        .milikPengguna(peminjam.nim);
    switch (hasilMilikku) {
      case Gagal():
        return Gagal(hasilMilikku.kegagalan);
      case Berhasil():
        final int aktif = hasilMilikku.nilai
            .where((Peminjaman p) => p.waktu.selesai.isAfter(sekarang))
            .length;
        if (aktif >= batasPeminjamanAktif) {
          return const Gagal(
            AturanDilanggar(
              'Anda sudah punya 2 peminjaman aktif. '
              'Batalkan salah satu dulu.',
            ),
          );
        }
    }

    // 5. Semua aturan terpenuhi: simpan.
    return _peminjaman.simpan(pengajuan, peminjam);
  }
}

// ============ BERKAS: lib/data/services/layanan_api_kampus.dart ============
// Layanan: hanya mengurus HTTP dan JSON. Ia boleh melempar exception
// teknis; repository-lah yang menerjemahkannya menjadi Kegagalan.

class ApiException implements Exception {
  const ApiException(this.kodeStatus);

  final int kodeStatus;

  @override
  String toString() => 'ApiException: kode status $kodeStatus';
}

class LayananApiKampus {
  LayananApiKampus({http.Client? klien}) : _klien = klien ?? http.Client();

  static final Uri alamatRuang = Uri.https(
    'raw.githubusercontent.com',
    '/antonprafanto/mobile2026/main/'
        'pertemuan_12_clean_architecture/data/ruang_kampus.json',
  );
  static const Duration batasWaktu = Duration(seconds: 10);

  final http.Client _klien;

  Future<Object?> ambilDataRuang() async {
    final http.Response respons = await _klien
        .get(alamatRuang)
        .timeout(batasWaktu);
    if (respons.statusCode != 200) {
      throw ApiException(respons.statusCode);
    }
    return jsonDecode(respons.body);
  }

  void tutup() => _klien.close();
}

// ============== BERKAS: lib/data/models/ruang_api_model.dart ==============
// Model API: bentuknya MENGIKUTI server (nama kolom berbahasa Inggris).
// Jika server mengganti nama kolom, hanya berkas ini yang ikut berubah.

class RuangApiModel {
  const RuangApiModel({
    required this.roomCode,
    required this.roomName,
    required this.building,
    required this.floor,
    required this.capacity,
    required this.facilities,
    required this.isActive,
  });

  final String roomCode;
  final String roomName;
  final String building;
  final int floor;
  final int capacity;
  final List<String> facilities;
  final bool isActive;

  // json bisa berbentuk apa saja. Pola di bawah memastikan bentuknya
  // benar; jika tidak, FormatException dilempar.
  factory RuangApiModel.fromJson(Object? json) {
    return switch (json) {
      {
        'room_code': final String roomCode,
        'room_name': final String roomName,
        'building': final String building,
        'floor': final int floor,
        'capacity': final int capacity,
        'facilities': final List<Object?> facilities,
        'is_active': final bool isActive,
      } =>
        RuangApiModel(
          roomCode: roomCode,
          roomName: roomName,
          building: building,
          floor: floor,
          capacity: capacity,
          facilities: facilities.whereType<String>().toList(),
          isActive: isActive,
        ),
      _ => throw FormatException('Data ruang tidak sesuai: $json'),
    };
  }

  // Model API -> entitas domain. Fasilitas yang belum dikenal aplikasi
  // (misalnya "stage") dilewati: ?x berarti "masukkan jika tidak null".
  Ruang keDomain() {
    return Ruang(
      kode: roomCode,
      nama: roomName,
      gedung: 'Gedung $building',
      lantai: floor,
      kapasitas: capacity,
      fasilitas: [for (final String nama in facilities) ?_petaFasilitas[nama]],
    );
  }

  static const Map<String, Fasilitas> _petaFasilitas = {
    'projector': Fasilitas.proyektor,
    'air_conditioner': Fasilitas.pendinginRuangan,
    'computer': Fasilitas.komputer,
    'whiteboard': Fasilitas.papanTulis,
    'sound_system': Fasilitas.pengerasSuara,
  };
}

// ======== BERKAS: lib/data/repositories/repositori_ruang_server.dart ========

class RepositoriRuangServer implements RepositoriRuang {
  RepositoriRuangServer({required this._layanan});

  final LayananApiKampus _layanan;

  // Salinan di memori: halaman yang dibuka ulang tidak perlu menunggu
  // internet lagi. Repository adalah sumber kebenaran data ruang.
  List<Ruang>? _salinan;

  @override
  Future<Hasil<List<Ruang>>> semuaRuang({bool segarkan = false}) async {
    final List<Ruang>? salinan = _salinan;
    if (salinan != null && !segarkan) {
      return Berhasil(salinan);
    }
    try {
      final Object? json = await _layanan.ambilDataRuang();
      final List<RuangApiModel> semua = switch (json) {
        {'rooms': final List<Object?> rooms} =>
          rooms.map(RuangApiModel.fromJson).toList(),
        _ => throw const FormatException('Kolom rooms tidak ditemukan'),
      };
      // Ruang yang sedang tidak aktif (misalnya direnovasi) disaring di
      // sini, sehingga lapisan lain tidak perlu tahu kolom is_active.
      final List<Ruang> daftar = [
        for (final RuangApiModel ruang in semua)
          if (ruang.isActive) ruang.keDomain(),
      ];
      _salinan = daftar;
      return Berhasil(daftar);
    } on TimeoutException {
      return const Gagal(WaktuHabis());
    } on http.ClientException {
      return const Gagal(TanpaKoneksi());
    } on ApiException catch (galat) {
      return Gagal(ServerBermasalah(galat.kodeStatus));
    } on FormatException {
      return const Gagal(DataRusak());
    }
  }
}

// ======== BERKAS: lib/data/repositories/repositori_ruang_memori.dart ========
// Data palsu untuk pengembangan dan pengujian: tanpa internet.

class RepositoriRuangMemori implements RepositoriRuang {
  RepositoriRuangMemori({this.jeda = const Duration(milliseconds: 300)});

  final Duration jeda;

  static const List<Ruang> data = [
    Ruang(
      kode: 'LAB-1',
      nama: 'Laboratorium Komputer 1',
      gedung: 'Gedung B',
      lantai: 2,
      kapasitas: 40,
      fasilitas: [
        Fasilitas.proyektor,
        Fasilitas.pendinginRuangan,
        Fasilitas.komputer,
      ],
    ),
    Ruang(
      kode: 'LAB-2',
      nama: 'Laboratorium Komputer 2',
      gedung: 'Gedung B',
      lantai: 2,
      kapasitas: 30,
      fasilitas: [
        Fasilitas.proyektor,
        Fasilitas.pendinginRuangan,
        Fasilitas.komputer,
      ],
    ),
    Ruang(
      kode: 'B-204',
      nama: 'Ruang Kelas B.204',
      gedung: 'Gedung B',
      lantai: 2,
      kapasitas: 45,
      fasilitas: [
        Fasilitas.proyektor,
        Fasilitas.pendinginRuangan,
        Fasilitas.papanTulis,
      ],
    ),
    Ruang(
      kode: 'C-105',
      nama: 'Ruang Seminar C.105',
      gedung: 'Gedung C',
      lantai: 1,
      kapasitas: 80,
      fasilitas: [
        Fasilitas.proyektor,
        Fasilitas.pendinginRuangan,
        Fasilitas.pengerasSuara,
      ],
    ),
    Ruang(
      kode: 'C-110',
      nama: 'Ruang Diskusi C.110',
      gedung: 'Gedung C',
      lantai: 1,
      kapasitas: 12,
      fasilitas: [Fasilitas.papanTulis, Fasilitas.pendinginRuangan],
    ),
    Ruang(
      kode: 'A-302',
      nama: 'Ruang Rapat A.302',
      gedung: 'Gedung A',
      lantai: 3,
      kapasitas: 20,
      fasilitas: [Fasilitas.proyektor, Fasilitas.pendinginRuangan],
    ),
    Ruang(
      kode: 'AULA',
      nama: 'Aula Fakultas',
      gedung: 'Gedung A',
      lantai: 1,
      kapasitas: 200,
      fasilitas: [
        Fasilitas.proyektor,
        Fasilitas.pendinginRuangan,
        Fasilitas.pengerasSuara,
      ],
    ),
  ];

  @override
  Future<Hasil<List<Ruang>>> semuaRuang({bool segarkan = false}) async {
    await Future<void>.delayed(jeda);
    return const Berhasil(data);
  }
}

// ===== BERKAS: lib/data/repositories/repositori_peminjaman_memori.dart =====
// Menyimpan peminjaman di memori (hilang saat aplikasi ditutup). Jika
// pemilikContoh diisi, beberapa contoh peminjaman dibuat pada hari kerja
// berikutnya agar jadwal tidak kosong.

class RepositoriPeminjamanMemori implements RepositoriPeminjaman {
  RepositoriPeminjamanMemori({
    DateTime Function()? sekarang,
    Pengguna? pemilikContoh,
  }) {
    if (pemilikContoh != null) {
      _isiContoh((sekarang ?? DateTime.now)(), pemilikContoh);
    }
  }

  final List<Peminjaman> _data = [];
  int _nomorTerakhir = 0;

  void _isiContoh(DateTime sekarang, Pengguna pemilik) {
    DateTime hari = DateTime(sekarang.year, sekarang.month, sekarang.day + 1);
    while (!hariKerja(hari)) {
      hari = DateTime(hari.year, hari.month, hari.day + 1);
    }
    RentangWaktu jam(int mulai, int selesai, {int menitSelesai = 0}) {
      return RentangWaktu(
        mulai: DateTime(hari.year, hari.month, hari.day, mulai),
        selesai: DateTime(
          hari.year,
          hari.month,
          hari.day,
          selesai,
          menitSelesai,
        ),
      );
    }

    const Pengguna hima = Pengguna(
      nim: 'HIMA-IF',
      nama: 'Himpunan Mahasiswa Informatika',
    );
    const Pengguna komunitas = Pengguna(
      nim: 'KOM-MOBILE',
      nama: 'Komunitas Mobile Developer',
    );
    _tambah('C-105', hima, 'Seminar Proposal Skripsi', 60, jam(9, 11));
    _tambah('C-105', hima, 'Pelatihan Penulisan Ilmiah', 45, jam(13, 15));
    _tambah('LAB-1', komunitas, 'Pelatihan Flutter', 35, jam(13, 15));
    _tambah(
      'B-204',
      pemilik,
      'Belajar kelompok Basis Data',
      8,
      jam(15, 16, menitSelesai: 30),
    );
  }

  Peminjaman _tambah(
    String kodeRuang,
    Pengguna peminjam,
    String keperluan,
    int peserta,
    RentangWaktu waktu,
  ) {
    _nomorTerakhir++;
    final Peminjaman baru = Peminjaman(
      id: 'PJ-${_nomorTerakhir.toString().padLeft(3, '0')}',
      kodeRuang: kodeRuang,
      peminjam: peminjam,
      keperluan: keperluan,
      jumlahPeserta: peserta,
      waktu: waktu,
    );
    _data.add(baru);
    return baru;
  }

  List<Peminjaman> _urut(Iterable<Peminjaman> daftar) {
    return daftar.toList()
      ..sort((a, b) => a.waktu.mulai.compareTo(b.waktu.mulai));
  }

  @override
  Future<Hasil<List<Peminjaman>>> milikRuang(String kodeRuang) async {
    return Berhasil(
      _urut(_data.where((Peminjaman p) => p.kodeRuang == kodeRuang)),
    );
  }

  @override
  Future<Hasil<List<Peminjaman>>> milikPengguna(String nim) async {
    return Berhasil(
      _urut(_data.where((Peminjaman p) => p.peminjam.nim == nim)),
    );
  }

  @override
  Future<Hasil<Peminjaman>> simpan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  ) async {
    return Berhasil(
      _tambah(
        pengajuan.kodeRuang,
        peminjam,
        pengajuan.keperluan.trim(),
        pengajuan.jumlahPeserta,
        pengajuan.waktu,
      ),
    );
  }

  @override
  Future<Hasil<void>> batalkan(String id) async {
    final int sebelum = _data.length;
    _data.removeWhere((Peminjaman p) => p.id == id);
    if (_data.length == sebelum) {
      return const Gagal(AturanDilanggar('Peminjaman tidak ditemukan.'));
    }
    return const Berhasil(null);
  }
}

// ================= BERKAS: lib/ui/core/perintah.dart =================
// Perintah (Command): membungkus satu aksi ViewModel beserta statusnya
// (sedang berjalan, berhasil, gagal). View cukup mendengarkan perintah
// itu. Perintah yang sedang berjalan tidak bisa dijalankan lagi, jadi
// tombol yang diketuk dua kali tidak mengirim dua permintaan.

abstract class Perintah<T> extends ChangeNotifier {
  bool _sedangBerjalan = false;
  Hasil<T>? _hasil;
  bool _sudahDibuang = false;

  bool get sedangBerjalan => _sedangBerjalan;

  // Hasil terakhir; null jika belum pernah dijalankan atau sudah dibaca.
  Hasil<T>? get hasil => _hasil;

  bool get gagal => _hasil is Gagal<T>;

  bool get berhasil => _hasil is Berhasil<T>;

  // Dipanggil View setelah menanggapi hasil (misalnya menampilkan
  // SnackBar), agar tanggapan itu tidak muncul berulang kali.
  void bersihkanHasil() {
    _hasil = null;
    _kabari();
  }

  Future<void> _jalankan(Future<Hasil<T>> Function() aksi) async {
    if (_sedangBerjalan) return;
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

// Perintah tanpa argumen, misalnya "muat".
class Perintah0<T> extends Perintah<T> {
  Perintah0(this._aksi);

  final Future<Hasil<T>> Function() _aksi;

  Future<void> jalankan() => _jalankan(_aksi);
}

// Perintah dengan satu argumen A, misalnya "ajukan(pengajuan)".
class Perintah1<T, A> extends Perintah<T> {
  Perintah1(this._aksi);

  final Future<Hasil<T>> Function(A) _aksi;

  Future<void> jalankan(A argumen) => _jalankan(() => _aksi(argumen));
}

// ================ BERKAS: lib/ui/core/pesan_kegagalan.dart ================
// Satu tempat untuk menerjemahkan Kegagalan menjadi kalimat untuk
// pengguna. switch pada sealed class wajib lengkap: jika kelak ada jenis
// Kegagalan baru, analyzer mengingatkan bahwa pesannya belum ditulis.

String pesanKegagalan(Kegagalan kegagalan) {
  return switch (kegagalan) {
    TanpaKoneksi() => 'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    WaktuHabis() => 'Server terlalu lama menjawab. Coba lagi sebentar lagi.',
    ServerBermasalah(:final int kodeStatus) =>
      'Server sedang bermasalah (kode $kodeStatus). Coba lagi nanti.',
    DataRusak() => 'Data dari server tidak bisa dibaca.',
    AturanDilanggar(:final String alasan) => alasan,
  };
}

// =========== BERKAS: lib/ui/core/format_waktu.dart ===========

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
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

String formatTanggal(DateTime t) =>
    '${_namaHari[t.weekday - 1]}, ${t.day} ${_namaBulan[t.month - 1]}';

DateTime awalHari(DateTime t) => DateTime(t.year, t.month, t.day);

// ===== BERKAS: lib/ui/daftar_ruang/view_models/daftar_ruang_view_model.dart =====

class DaftarRuangViewModel extends ChangeNotifier {
  DaftarRuangViewModel({required this._repositori}) {
    muat = Perintah0<List<Ruang>>(_muat)..jalankan();
  }

  final RepositoriRuang _repositori;

  // late final: diisi sekali di constructor, karena _muat butuh `this`.
  late final Perintah0<List<Ruang>> muat;

  List<Ruang> _semua = [];
  int _kapasitasMinimal = 0;
  bool _sudahDibuang = false;

  int get kapasitasMinimal => _kapasitasMinimal;

  List<Ruang> get ruangTampil =>
      _semua.where((Ruang r) => r.kapasitas >= _kapasitasMinimal).toList();

  void saringKapasitas(int minimal) {
    _kapasitasMinimal = minimal;
    notifyListeners();
  }

  Future<Hasil<List<Ruang>>> _muat() async {
    final Hasil<List<Ruang>> hasil = await _repositori.semuaRuang();
    if (_sudahDibuang) return hasil; // halaman sudah ditutup
    if (hasil is Berhasil<List<Ruang>>) {
      _semua = hasil.nilai;
      notifyListeners();
    }
    return hasil;
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    muat.dispose();
    super.dispose();
  }
}

// ===== BERKAS: lib/ui/jadwal_ruang/view_models/jadwal_ruang_view_model.dart =====

class JadwalRuangViewModel extends ChangeNotifier {
  JadwalRuangViewModel({
    required this.ruang,
    required this._pengguna,
    required this._repositori,
    required this._ajukanPeminjaman,
    DateTime Function()? sekarang,
  }) : _sekarang = sekarang ?? DateTime.now {
    pilihanTanggal = _buatPilihanTanggal();
    _tanggal = pilihanTanggal.first;
    muat = Perintah0<List<Peminjaman>>(_muat)..jalankan();
    ajukan = Perintah1<Peminjaman, PengajuanPeminjaman>(_ajukan);
  }

  final Ruang ruang;
  final Pengguna _pengguna;
  final RepositoriPeminjaman _repositori;
  final AjukanPeminjaman _ajukanPeminjaman;
  final DateTime Function() _sekarang;

  late final Perintah0<List<Peminjaman>> muat;
  late final Perintah1<Peminjaman, PengajuanPeminjaman> ajukan;

  // Hari ini (jika hari kerja) ditambah hari kerja berikutnya: 5 pilihan.
  late final List<DateTime> pilihanTanggal;
  late DateTime _tanggal;
  List<Peminjaman> _semua = [];
  bool _sudahDibuang = false;

  DateTime get tanggal => _tanggal;

  String labelTanggal(DateTime tanggal) {
    return tanggal == awalHari(_sekarang())
        ? 'Hari ini'
        : formatTanggal(tanggal);
  }

  List<Peminjaman> get jadwalTanggalIni =>
      _semua.where((Peminjaman p) => p.waktu.samaHari(_tanggal)).toList();

  void pilihTanggal(DateTime tanggal) {
    _tanggal = tanggal;
    notifyListeners();
  }

  List<DateTime> _buatPilihanTanggal() {
    final List<DateTime> hasil = [];
    DateTime hari = awalHari(_sekarang());
    while (hasil.length < 5) {
      if (hariKerja(hari)) hasil.add(hari);
      hari = DateTime(hari.year, hari.month, hari.day + 1);
    }
    return hasil;
  }

  Future<Hasil<List<Peminjaman>>> _muat() async {
    final Hasil<List<Peminjaman>> hasil = await _repositori.milikRuang(
      ruang.kode,
    );
    if (_sudahDibuang) return hasil;
    if (hasil is Berhasil<List<Peminjaman>>) {
      _semua = hasil.nilai;
      notifyListeners();
    }
    return hasil;
  }

  Future<Hasil<Peminjaman>> _ajukan(PengajuanPeminjaman pengajuan) async {
    final Hasil<Peminjaman> hasil = await _ajukanPeminjaman.jalankan(
      pengajuan,
      _pengguna,
    );
    if (hasil is Berhasil<Peminjaman>) {
      await _muat(); // jadwal dibaca ulang dari sumber kebenarannya
    }
    return hasil;
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    muat.dispose();
    ajukan.dispose();
    super.dispose();
  }
}

// == BERKAS: lib/ui/peminjaman_saya/view_models/peminjaman_saya_view_model.dart ==

class PeminjamanSayaViewModel extends ChangeNotifier {
  PeminjamanSayaViewModel({
    required this._pengguna,
    required this._repositori,
    DateTime Function()? sekarang,
  }) : _sekarang = sekarang ?? DateTime.now {
    muat = Perintah0<List<Peminjaman>>(_muat)..jalankan();
    batalkan = Perintah1<void, String>(_batalkan);
  }

  final Pengguna _pengguna;
  final RepositoriPeminjaman _repositori;
  final DateTime Function() _sekarang;

  late final Perintah0<List<Peminjaman>> muat;
  late final Perintah1<void, String> batalkan;

  List<Peminjaman> _daftar = [];
  bool _sudahDibuang = false;

  List<Peminjaman> get daftar => _daftar;

  // Aktif = belum selesai. Batas jumlahnya diperiksa use case.
  int get jumlahAktif => _daftar
      .where((Peminjaman p) => p.waktu.selesai.isAfter(_sekarang()))
      .length;

  Future<Hasil<List<Peminjaman>>> _muat() async {
    final Hasil<List<Peminjaman>> hasil = await _repositori.milikPengguna(
      _pengguna.nim,
    );
    if (_sudahDibuang) return hasil;
    if (hasil is Berhasil<List<Peminjaman>>) {
      _daftar = hasil.nilai;
      notifyListeners();
    }
    return hasil;
  }

  Future<Hasil<void>> _batalkan(String id) async {
    final Hasil<void> hasil = await _repositori.batalkan(id);
    if (hasil is Berhasil<void>) {
      await _muat();
    }
    return hasil;
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    muat.dispose();
    batalkan.dispose();
    super.dispose();
  }
}

// ================== BERKAS: lib/ui/core/aplikasi.dart ==================

class AplikasiPinjamRuang extends StatelessWidget {
  const AplikasiPinjamRuang({super.key, required this.lingkungan});

  final Lingkungan lingkungan;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinjam Ruang Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      // Pita "DATA PALSU" di pojok kanan atas saat memakai data palsu,
      // agar tidak tertukar dengan data sungguhan.
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
      home: const HalamanUtama(),
    );
  }
}

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
      // Setiap tab dibuat ulang saat dipilih, jadi ViewModel-nya ikut
      // dibuat ulang dan datanya dibaca lagi dari repository.
      body: switch (_indeks) {
        0 => const HalamanDaftarRuang(),
        _ => const HalamanPeminjamanSaya(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (int indeks) {
          setState(() => _indeks = indeks);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.meeting_room_outlined),
            selectedIcon: Icon(Icons.meeting_room),
            label: 'Ruang',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Peminjaman Saya',
          ),
        ],
      ),
    );
  }
}

// =========== BERKAS: lib/ui/core/pesan_gagal.dart ===========

class PesanGagal extends StatelessWidget {
  const PesanGagal({super.key, required this.pesan, required this.onCobaLagi});

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView: tetap aman walaupun layar sangat pendek.
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48),
            const SizedBox(height: 12),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 12),
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

// ======= BERKAS: lib/ui/daftar_ruang/widgets/halaman_daftar_ruang.dart =======

class HalamanDaftarRuang extends StatelessWidget {
  const HalamanDaftarRuang({super.key});

  @override
  Widget build(BuildContext context) {
    // ViewModel dibuat di sini dan menerima KONTRAK repository dari
    // provider. Ia tidak tahu datanya dari server atau dari memori.
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          DaftarRuangViewModel(repositori: context.read<RepositoriRuang>()),
      child: const _TampilanDaftarRuang(),
    );
  }
}

class _TampilanDaftarRuang extends StatelessWidget {
  const _TampilanDaftarRuang();

  static const List<int> pilihanKapasitas = [0, 20, 40, 80];

  @override
  Widget build(BuildContext context) {
    final DaftarRuangViewModel vm = context.watch<DaftarRuangViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Pinjam Ruang Kampus')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                const Icon(Icons.groups_outlined),
                const SizedBox(width: 12),
                SegmentedButton<int>(
                  segments: [
                    for (final int minimal in pilihanKapasitas)
                      ButtonSegment<int>(
                        value: minimal,
                        label: Text(minimal == 0 ? 'Semua' : '≥ $minimal'),
                      ),
                  ],
                  selected: {vm.kapasitasMinimal},
                  showSelectedIcon: false,
                  onSelectionChanged: (Set<int> pilihan) {
                    vm.saringKapasitas(pilihan.first);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            // Status memuat dibaca dari PERINTAH muat, datanya dari VM.
            child: ListenableBuilder(
              listenable: vm.muat,
              builder: (BuildContext context, Widget? child) {
                if (vm.muat.sedangBerjalan) {
                  return const Center(child: CircularProgressIndicator());
                }
                final Hasil<List<Ruang>>? hasil = vm.muat.hasil;
                if (hasil is Gagal<List<Ruang>>) {
                  return PesanGagal(
                    pesan: pesanKegagalan(hasil.kegagalan),
                    onCobaLagi: vm.muat.jalankan,
                  );
                }
                final List<Ruang> daftar = vm.ruangTampil;
                if (daftar.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada ruang sebesar itu.'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  itemCount: daftar.length,
                  itemBuilder: (BuildContext context, int i) =>
                      KartuRuang(ruang: daftar[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KartuRuang extends StatelessWidget {
  const KartuRuang({super.key, required this.ruang});

  final Ruang ruang;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.meeting_room_outlined)),
        title: Text(ruang.nama),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${ruang.kode} · ${ruang.gedung}, lantai ${ruang.lantai}'),
            Text(
              ruang.fasilitas.map((Fasilitas f) => f.label).join(' · '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.groups_outlined),
            Text(
              '${ruang.kapasitas}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  HalamanJadwalRuang(ruang: ruang),
            ),
          );
        },
      ),
    );
  }
}

// ======= BERKAS: lib/ui/jadwal_ruang/widgets/halaman_jadwal_ruang.dart =======

class HalamanJadwalRuang extends StatelessWidget {
  const HalamanJadwalRuang({super.key, required this.ruang});

  final Ruang ruang;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => JadwalRuangViewModel(
        ruang: ruang,
        pengguna: context.read<Pengguna>(),
        repositori: context.read<RepositoriPeminjaman>(),
        ajukanPeminjaman: context.read<AjukanPeminjaman>(),
      ),
      child: const _TampilanJadwalRuang(),
    );
  }
}

class _TampilanJadwalRuang extends StatelessWidget {
  const _TampilanJadwalRuang();

  Future<void> _bukaFormulir(BuildContext context) async {
    final JadwalRuangViewModel vm = context.read<JadwalRuangViewModel>();
    final Peminjaman? baru = await showModalBottomSheet<Peminjaman>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
        value: vm,
        child: const LembarPengajuan(),
      ),
    );
    vm.ajukan.bersihkanHasil(); // pesan lama tidak muncul lagi
    if (baru == null || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Peminjaman ${baru.id} tercatat: '
          '${formatTanggal(baru.waktu.mulai)}, ${baru.waktu.teksJam}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final JadwalRuangViewModel vm = context.watch<JadwalRuangViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(vm.ruang.nama)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              '${vm.ruang.gedung}, lantai ${vm.ruang.lantai} · '
              'kapasitas ${vm.ruang.kapasitas} orang',
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                for (final DateTime tanggal in vm.pilihanTanggal)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(vm.labelTanggal(tanggal)),
                      selected: tanggal == vm.tanggal,
                      onSelected: (_) => vm.pilihTanggal(tanggal),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: vm.muat,
              builder: (BuildContext context, Widget? child) {
                if (vm.muat.sedangBerjalan) {
                  return const Center(child: CircularProgressIndicator());
                }
                final Hasil<List<Peminjaman>>? hasil = vm.muat.hasil;
                if (hasil is Gagal<List<Peminjaman>>) {
                  return PesanGagal(
                    pesan: pesanKegagalan(hasil.kegagalan),
                    onCobaLagi: vm.muat.jalankan,
                  );
                }
                final List<Peminjaman> jadwal = vm.jadwalTanggalIni;
                if (jadwal.isEmpty) {
                  return const Center(
                    child: Text('Belum ada peminjaman. Ruang bebas seharian.'),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.only(bottom: 88),
                  children: [
                    for (final Peminjaman p in jadwal)
                      ListTile(
                        leading: const Icon(Icons.schedule),
                        title: Text(p.keperluan),
                        subtitle: Text(
                          '${p.waktu.teksJam} · ${p.peminjam.nama} · '
                          '${p.jumlahPeserta} peserta',
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaFormulir(context),
        icon: const Icon(Icons.add),
        label: const Text('Ajukan peminjaman'),
      ),
    );
  }
}

// ========= BERKAS: lib/ui/jadwal_ruang/widgets/lembar_pengajuan.dart =========

class LembarPengajuan extends StatefulWidget {
  const LembarPengajuan({super.key});

  @override
  State<LembarPengajuan> createState() => _LembarPengajuanState();
}

class _LembarPengajuanState extends State<LembarPengajuan> {
  final TextEditingController _keperluan = TextEditingController();
  final TextEditingController _peserta = TextEditingController();
  int _jamMulai = 9;
  int _lamaMenit = 60;

  static const Map<int, String> pilihanLama = {
    60: '1 jam',
    90: '1½ jam',
    120: '2 jam',
    180: '3 jam',
  };

  @override
  void dispose() {
    _keperluan.dispose();
    _peserta.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    final JadwalRuangViewModel vm = context.read<JadwalRuangViewModel>();
    final DateTime tanggal = vm.tanggal;
    final DateTime mulai = DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
      _jamMulai,
    );
    // View hanya MENGUMPULKAN isian. Benar-tidaknya diputuskan domain.
    await vm.ajukan.jalankan(
      PengajuanPeminjaman(
        kodeRuang: vm.ruang.kode,
        keperluan: _keperluan.text,
        jumlahPeserta: int.tryParse(_peserta.text.trim()) ?? 0,
        waktu: RentangWaktu(
          mulai: mulai,
          selesai: mulai.add(Duration(minutes: _lamaMenit)),
        ),
      ),
    );
    if (!mounted) return;
    final Hasil<Peminjaman>? hasil = vm.ajukan.hasil;
    if (hasil is Berhasil<Peminjaman>) {
      Navigator.pop(context, hasil.nilai);
    }
  }

  @override
  Widget build(BuildContext context) {
    final JadwalRuangViewModel vm = context.watch<JadwalRuangViewModel>();
    return Padding(
      // Memberi ruang untuk papan ketik di layar sentuh.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ajukan ${vm.ruang.kode}: ${formatTanggal(vm.tanggal)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _keperluan,
              decoration: const InputDecoration(
                labelText: 'Keperluan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _peserta,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah peserta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _jamMulai,
              decoration: const InputDecoration(
                labelText: 'Jam mulai',
                border: OutlineInputBorder(),
              ),
              items: [
                for (int jam = jamBuka; jam < jamTutup; jam++)
                  DropdownMenuItem<int>(
                    value: jam,
                    child: Text('${jam.toString().padLeft(2, '0')}.00'),
                  ),
              ],
              onChanged: (int? jam) {
                if (jam != null) setState(() => _jamMulai = jam);
              },
            ),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: [
                for (final MapEntry<int, String> pilihan in pilihanLama.entries)
                  ButtonSegment<int>(
                    value: pilihan.key,
                    label: Text(pilihan.value),
                  ),
              ],
              selected: {_lamaMenit},
              showSelectedIcon: false,
              onSelectionChanged: (Set<int> pilihan) {
                setState(() => _lamaMenit = pilihan.first);
              },
            ),
            const SizedBox(height: 12),
            // Hanya bagian ini yang mendengarkan perintah ajukan.
            ListenableBuilder(
              listenable: vm.ajukan,
              builder: (BuildContext context, Widget? child) {
                final Hasil<Peminjaman>? hasil = vm.ajukan.hasil;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (hasil is Gagal<Peminjaman>)
                      Card(
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            pesanKegagalan(hasil.kegagalan),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      // null = tombol mati selama perintah berjalan.
                      onPressed: vm.ajukan.sedangBerjalan ? null : _kirim,
                      icon: vm.ajukan.sedangBerjalan
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      label: const Text('Ajukan'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// == BERKAS: lib/ui/peminjaman_saya/widgets/halaman_peminjaman_saya.dart ==

class HalamanPeminjamanSaya extends StatelessWidget {
  const HalamanPeminjamanSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PeminjamanSayaViewModel(
        pengguna: context.read<Pengguna>(),
        repositori: context.read<RepositoriPeminjaman>(),
      ),
      child: const _TampilanPeminjamanSaya(),
    );
  }
}

class _TampilanPeminjamanSaya extends StatelessWidget {
  const _TampilanPeminjamanSaya();

  Future<void> _batalkan(BuildContext context, Peminjaman p) async {
    final PeminjamanSayaViewModel vm = context.read<PeminjamanSayaViewModel>();
    await vm.batalkan.jalankan(p.id);
    if (!context.mounted) return;
    final Hasil<void>? hasil = vm.batalkan.hasil;
    vm.batalkan.bersihkanHasil();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(switch (hasil) {
          Gagal<void>(:final Kegagalan kegagalan) => pesanKegagalan(kegagalan),
          _ => 'Peminjaman ${p.id} dibatalkan.',
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PeminjamanSayaViewModel vm = context.watch<PeminjamanSayaViewModel>();
    final Pengguna pengguna = context.read<Pengguna>();
    return Scaffold(
      appBar: AppBar(title: const Text('Peminjaman Saya')),
      // Mendengarkan dua perintah sekaligus: muat dan batalkan.
      body: ListenableBuilder(
        listenable: Listenable.merge([vm.muat, vm.batalkan]),
        builder: (BuildContext _, Widget? child) {
          if (vm.muat.sedangBerjalan && vm.daftar.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final Hasil<List<Peminjaman>>? hasil = vm.muat.hasil;
          if (hasil is Gagal<List<Peminjaman>>) {
            return PesanGagal(
              pesan: pesanKegagalan(hasil.kegagalan),
              onCobaLagi: vm.muat.jalankan,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Text(
                '${pengguna.nama} (${pengguna.nim}) · '
                '${vm.jumlahAktif} dari '
                '${AjukanPeminjaman.batasPeminjamanAktif} peminjaman aktif',
              ),
              const SizedBox(height: 8),
              if (vm.daftar.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Text(
                    'Belum ada peminjaman. Pilih ruang di tab Ruang.',
                    textAlign: TextAlign.center,
                  ),
                ),
              for (final Peminjaman p in vm.daftar)
                Card(
                  child: ListTile(
                    title: Text(p.keperluan),
                    subtitle: Text(
                      '${formatTanggal(p.waktu.mulai)} · ${p.waktu.teksJam}\n'
                      '${p.kodeRuang} · ${p.jumlahPeserta} peserta · ${p.id}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Batalkan',
                      icon: const Icon(Icons.event_busy),
                      onPressed: vm.batalkan.sedangBerjalan
                          ? null
                          : () => _batalkan(context, p),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// =============== PEMERIKSAAN (di proyek: folder test/) ===============
// Semua lapisan diperiksa dengan data palsu dan jam tetap, tanpa layar
// dan tanpa internet. Pertemuan 14 memindahkannya ke flutter test.

void periksa(String nama, Object? didapat, Object? diharapkan) {
  if (didapat == diharapkan) {
    debugPrint('LULUS  $nama');
  } else {
    debugPrint('GAGAL  $nama: diharapkan $diharapkan, hasilnya $didapat');
  }
}

// Hasil -> teks pendek, agar mudah dibandingkan.
String ringkas<T>(Hasil<T> hasil) {
  return switch (hasil) {
    Berhasil() => 'berhasil',
    Gagal(:final Kegagalan kegagalan) => switch (kegagalan) {
      AturanDilanggar(:final String alasan) => 'ditolak: $alasan',
      TanpaKoneksi() => 'gagal: tanpa koneksi',
      WaktuHabis() => 'gagal: waktu habis',
      ServerBermasalah(:final int kodeStatus) => 'gagal: server $kodeStatus',
      DataRusak() => 'gagal: data rusak',
    },
  };
}

const String contohJsonRuang = '''
{
  "updated_at": "2026-10-16T08:00:00+08:00",
  "rooms": [
    {"room_code": "C-110", "room_name": "Ruang Diskusi C.110", "building": "C",
     "floor": 1, "capacity": 12, "facilities": ["whiteboard", "stage"],
     "is_active": true},
    {"room_code": "STUDIO", "room_name": "Studio Multimedia", "building": "C",
     "floor": 2, "capacity": 15, "facilities": ["computer"],
     "is_active": false}
  ]
}
''';

Future<void> jalankanUji() async {
  // Rabu, 14 Oktober 2026 pukul 10.00. Contoh peminjaman ada di hari
  // kerja berikutnya: Kamis, 15 Oktober 2026.
  DateTime jamTetap() => DateTime(2026, 10, 14, 10);
  DateTime kamis(int jam, [int menit = 0]) =>
      DateTime(2026, 10, 15, jam, menit);
  RentangWaktu rentang(DateTime mulai, int menit) => RentangWaktu(
    mulai: mulai,
    selesai: mulai.add(Duration(minutes: menit)),
  );
  const Pengguna budi = Pengguna(nim: '2609106001', nama: 'Budi Santoso');
  const Ruang ruangDiskusi = Ruang(
    kode: 'C-110',
    nama: 'Ruang Diskusi C.110',
    gedung: 'Gedung C',
    lantai: 1,
    kapasitas: 12,
    fasilitas: [],
  );

  try {
    // ---- 1. Domain: entitas dan aturan bisnis (Dart murni) ----
    periksa(
      'Rentang 09.00-11.00 dan 10.00-12.00 bertumpuk',
      rentang(kamis(9), 120).bertumpukDengan(rentang(kamis(10), 120)),
      true,
    );
    periksa(
      'Rentang 09.00-11.00 dan 11.00-12.00 tidak bertumpuk',
      rentang(kamis(9), 120).bertumpukDengan(rentang(kamis(11), 60)),
      false,
    );
    periksa(
      'Dua rentang dengan jam sama dianggap sama (==)',
      rentang(kamis(9), 60) == rentang(kamis(9), 60),
      true,
    );
    String? aturan(int peserta, RentangWaktu waktu) => periksaPengajuan(
      PengajuanPeminjaman(
        kodeRuang: 'C-110',
        keperluan: 'Diskusi kelompok',
        jumlahPeserta: peserta,
        waktu: waktu,
      ),
      ruang: ruangDiskusi,
      sekarang: jamTetap(),
    );
    periksa('Pengajuan wajar lolos', aturan(8, rentang(kamis(13), 90)), null);
    periksa(
      'Peserta melebihi kapasitas ditolak',
      aturan(15, rentang(kamis(13), 60)),
      'Peserta (15) melebihi kapasitas Ruang Diskusi C.110 (12 orang).',
    );
    periksa(
      'Lebih dari 3 jam ditolak',
      aturan(8, rentang(kamis(9), 240)),
      'Lama peminjaman harus 30 menit sampai 3 jam.',
    );
    periksa(
      'Sabtu ditolak',
      aturan(8, rentang(DateTime(2026, 10, 17, 9), 60)),
      'Ruang hanya bisa dipinjam Senin sampai Jumat.',
    );
    periksa(
      'Pukul 20.00-22.00 ditolak',
      aturan(8, rentang(kamis(20), 120)),
      'Ruang hanya bisa dipinjam pukul 07.00 sampai 21.00.',
    );
    periksa(
      'Waktu yang sudah lewat ditolak',
      aturan(8, rentang(DateTime(2026, 10, 14, 8), 60)),
      'Waktu mulai sudah lewat. Pilih jam yang akan datang.',
    );

    // ---- 2. Use case dengan repository palsu dan jam tetap ----
    final RepositoriPeminjamanMemori peminjaman = RepositoriPeminjamanMemori(
      sekarang: jamTetap,
      pemilikContoh: budi,
    );
    final AjukanPeminjaman ajukan = AjukanPeminjaman(
      ruang: RepositoriRuangMemori(jeda: Duration.zero),
      peminjaman: peminjaman,
      sekarang: jamTetap,
    );
    PengajuanPeminjaman pengajuan(String kode, RentangWaktu waktu) {
      return PengajuanPeminjaman(
        kodeRuang: kode,
        keperluan: 'Rapat panitia',
        jumlahPeserta: 10,
        waktu: waktu,
      );
    }

    periksa(
      'Bentrok dengan jadwal lain ditolak',
      ringkas(
        await ajukan.jalankan(
          pengajuan('C-105', rentang(kamis(10), 120)),
          budi,
        ),
      ),
      'ditolak: Bentrok dengan "Seminar Proposal Skripsi" pukul 09.00–11.00.',
    );
    periksa(
      'Jam yang bersambung (11.00-12.00) diterima',
      ringkas(
        await ajukan.jalankan(pengajuan('C-105', rentang(kamis(11), 60)), budi),
      ),
      'berhasil',
    );
    periksa(
      'Peminjaman ketiga yang masih aktif ditolak',
      ringkas(
        await ajukan.jalankan(
          pengajuan('LAB-2', rentang(DateTime(2026, 10, 16, 9), 60)),
          budi,
        ),
      ),
      'ditolak: Anda sudah punya 2 peminjaman aktif. '
          'Batalkan salah satu dulu.',
    );
    periksa(
      'Ruang yang tidak ada ditolak',
      ringkas(
        await ajukan.jalankan(pengajuan('Z-999', rentang(kamis(9), 60)), budi),
      ),
      'ditolak: Ruang tidak ditemukan.',
    );

    // ---- 3. Repository server dengan "server" palsu (MockClient) ----
    int jumlahPermintaan = 0;
    String jawaban = contohJsonRuang;
    int kodeStatus = 200;
    bool putus = false;
    final RepositoriRuangServer server = RepositoriRuangServer(
      layanan: LayananApiKampus(
        klien: MockClient((http.Request permintaan) async {
          jumlahPermintaan++;
          if (putus) throw http.ClientException('Tidak ada koneksi');
          return http.Response(jawaban, kodeStatus);
        }),
      ),
    );
    final Hasil<List<Ruang>> hasilServer = await server.semuaRuang();
    final List<Ruang> ruangServer = hasilServer is Berhasil<List<Ruang>>
        ? hasilServer.nilai
        : const [];
    periksa('JSON server -> 1 ruang aktif', ruangServer.length, 1);
    periksa(
      'Kolom Inggris menjadi entitas berbahasa Indonesia',
      ruangServer.isEmpty
          ? null
          : '${ruangServer.first.nama} · ${ruangServer.first.gedung}',
      'Ruang Diskusi C.110 · Gedung C',
    );
    periksa(
      'Fasilitas yang belum dikenal (stage) dilewati',
      ruangServer.isEmpty
          ? null
          : ruangServer.first.fasilitas.map((Fasilitas f) => f.label).join(),
      'Papan tulis',
    );
    await server.semuaRuang();
    periksa('Panggilan kedua memakai salinan memori', jumlahPermintaan, 1);
    kodeStatus = 500;
    periksa(
      'Kode 500 -> ServerBermasalah',
      ringkas(await server.semuaRuang(segarkan: true)),
      'gagal: server 500',
    );
    kodeStatus = 200;
    jawaban = '<html>bukan json</html>';
    periksa(
      'Bukan JSON -> DataRusak',
      ringkas(await server.semuaRuang(segarkan: true)),
      'gagal: data rusak',
    );
    putus = true;
    periksa(
      'Tanpa koneksi -> TanpaKoneksi',
      ringkas(await server.semuaRuang(segarkan: true)),
      'gagal: tanpa koneksi',
    );

    // ---- 4. ViewModel dengan repository palsu (tanpa layar) ----
    // ViewModel dan use case memakai repository yang SAMA, persis seperti
    // yang dirakit buatPenyedia.
    final RepositoriPeminjamanMemori repoKosong = RepositoriPeminjamanMemori();
    final JadwalRuangViewModel vm = JadwalRuangViewModel(
      ruang: ruangDiskusi,
      pengguna: budi,
      repositori: repoKosong,
      ajukanPeminjaman: AjukanPeminjaman(
        ruang: RepositoriRuangMemori(jeda: Duration.zero),
        peminjaman: repoKosong,
        sekarang: jamTetap,
      ),
      sekarang: jamTetap,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    periksa(
      'Pilihan tanggal: hari ini lalu hari kerja berikutnya',
      vm.pilihanTanggal.map((DateTime t) => t.day).join(','),
      '14,15,16,19,20',
    );
    vm.pilihTanggal(DateTime(2026, 10, 15));
    await vm.ajukan.jalankan(pengajuan('C-110', rentang(kamis(9), 60)));
    periksa('Perintah ajukan berhasil', vm.ajukan.berhasil, true);
    periksa(
      'Jadwal Kamis dibaca ulang setelah mengajukan',
      vm.jadwalTanggalIni.map((Peminjaman p) => p.waktu.teksJam).join(', '),
      '09.00–10.00',
    );
    vm.dispose();
  } catch (galat) {
    debugPrint('GAGAL  pemeriksaan berhenti: $galat');
  }
}
