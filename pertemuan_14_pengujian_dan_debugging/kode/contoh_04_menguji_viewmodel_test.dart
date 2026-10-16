// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 04: Menguji ViewModel dengan Data Palsu
// Topik: "Antrean Konsultasi Dosen": mahasiswa mengambil nomor antrean
//        konsultasi. ViewModel diuji TANPA layar, memakai repository
//        palsu yang:
//        - bisa pura-pura gagal (gagalSaatMemuat, gagalSaatMengambil);
//        - menghitung berapa kali dipanggil (mata-mata / spy);
//        - bisa DITAHAN (Completer), sehingga keadaan antara seperti
//          "sedang memuat" dan "sedang mengirim" bisa diperiksa.
//        Yang diuji: keadaan memuat/berhasil/gagal, kabar ke pendengar,
//        aturan sebelum mengirim, penjaga ketukan ganda, dan ViewModel
//        yang dibuang (dispose) saat data belum datang.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
//    Hasil tes tampil di panel Console.
// B. Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_04_menguji_viewmodel_test.dart
// =====================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

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

sealed class Kegagalan {
  const Kegagalan();
}

final class TanpaKoneksi extends Kegagalan {
  const TanpaKoneksi();
}

final class ServerBermasalah extends Kegagalan {
  const ServerBermasalah(this.kodeStatus);

  final int kodeStatus;
}

// ================= BERKAS: lib/domain/models/antrean.dart =================

class Antrean {
  const Antrean({
    required this.nomor,
    required this.nama,
    required this.keperluan,
  });

  final int nomor;
  final String nama;
  final String keperluan;
}

// ============== BERKAS: lib/domain/models/aturan_antrean.dart ==============

const int kuotaHarian = 10;

/// Alasan penolakan, atau null jika boleh mengambil nomor.
String? periksaPengambilan({
  required String nama,
  required String keperluan,
  required List<Antrean> sudahAda,
}) {
  final String namaBersih = nama.trim();
  if (namaBersih.isEmpty) {
    return 'Nama wajib diisi.';
  }
  if (keperluan.trim().length < 5) {
    return 'Tuliskan keperluan minimal 5 huruf.';
  }
  if (sudahAda.length >= kuotaHarian) {
    return 'Kuota hari ini ($kuotaHarian antrean) sudah penuh.';
  }
  final bool sudahAntre = sudahAda.any(
    (Antrean a) => a.nama.toLowerCase() == namaBersih.toLowerCase(),
  );
  if (sudahAntre) {
    return '$namaBersih sudah punya nomor antrean.';
  }
  return null;
}

// ========= BERKAS: lib/domain/repositories/repositori_antrean.dart =========

abstract interface class RepositoriAntrean {
  Future<Hasil<List<Antrean>>> semua();

  Future<Hasil<Antrean>> ambilNomor({
    required String nama,
    required String keperluan,
  });
}

// ======= BERKAS: lib/ui/antrean/view_models/antrean_view_model.dart =======

enum StatusMuat { memuat, berhasil, gagal }

String pesanKegagalan(Kegagalan kegagalan) {
  return switch (kegagalan) {
    TanpaKoneksi() => 'Tidak dapat terhubung. Periksa koneksi internet Anda.',
    ServerBermasalah(:final int kodeStatus) =>
      'Server sedang bermasalah (kode $kodeStatus). Coba lagi nanti.',
  };
}

class AntreanViewModel extends ChangeNotifier {
  AntreanViewModel({required this._repositori});

  final RepositoriAntrean _repositori;

  StatusMuat _status = StatusMuat.memuat;
  List<Antrean> _daftar = [];
  String? _pesanGalat;
  bool _mengirim = false;
  String? _pesanKirim;
  Antrean? _nomorSaya;
  bool _sudahDibuang = false;

  StatusMuat get status => _status;
  List<Antrean> get daftar => List.unmodifiable(_daftar);
  String? get pesanGalat => _pesanGalat;
  bool get mengirim => _mengirim;
  String? get pesanKirim => _pesanKirim;
  Antrean? get nomorSaya => _nomorSaya;

  Future<void> muat() async {
    _status = StatusMuat.memuat;
    _pesanGalat = null;
    _kabari();
    final Hasil<List<Antrean>> hasil = await _repositori.semua();
    switch (hasil) {
      case Berhasil(:final List<Antrean> nilai):
        _daftar = nilai;
        _status = StatusMuat.berhasil;
      case Gagal(:final Kegagalan kegagalan):
        _pesanGalat = pesanKegagalan(kegagalan);
        _status = StatusMuat.gagal;
    }
    _kabari();
  }

  /// Mengembalikan true jika nomor berhasil diambil.
  Future<bool> ambilNomor({
    required String nama,
    required String keperluan,
  }) async {
    // PENJAGA: selama pengiriman berjalan, ketukan berikutnya diabaikan.
    if (_mengirim) return false;
    final String? alasan = periksaPengambilan(
      nama: nama,
      keperluan: keperluan,
      sudahAda: _daftar,
    );
    if (alasan != null) {
      _pesanKirim = alasan;
      _kabari();
      return false;
    }
    _mengirim = true;
    _pesanKirim = null;
    _kabari();
    final Hasil<Antrean> hasil = await _repositori.ambilNomor(
      nama: nama.trim(),
      keperluan: keperluan.trim(),
    );
    _mengirim = false;
    switch (hasil) {
      case Berhasil(:final Antrean nilai):
        _nomorSaya = nilai;
        await _bacaUlang(); // daftar dibaca ulang dari sumbernya
        return true;
      case Gagal(:final Kegagalan kegagalan):
        _pesanKirim = pesanKegagalan(kegagalan);
        _kabari();
        return false;
    }
  }

  // Dipanggil View setelah lembar formulir ditutup, agar pesan lama tidak
  // muncul lagi saat formulir dibuka berikutnya.
  void bersihkanPesanKirim() {
    _pesanKirim = null;
    _kabari();
  }

  // Membaca ulang tanpa menampilkan lingkaran memuat lagi.
  Future<void> _bacaUlang() async {
    final Hasil<List<Antrean>> hasil = await _repositori.semua();
    if (hasil is Berhasil<List<Antrean>>) {
      _daftar = hasil.nilai;
    }
    _kabari();
  }

  // Halaman bisa ditutup sebelum data datang. ViewModel yang sudah dibuang
  // tidak boleh memberi kabar lagi.
  void _kabari() {
    if (!_sudahDibuang) notifyListeners();
  }

  @override
  void dispose() {
    _sudahDibuang = true;
    super.dispose();
  }
}

// ======== BERKAS: testing/fakes/repositori_antrean_palsu.dart ========
// Data palsu dengan "remote control": dipakai bersama oleh banyak tes.

class RepositoriAntreanPalsu implements RepositoriAntrean {
  RepositoriAntreanPalsu({List<Antrean> isi = const []}) : _isi = [...isi];

  final List<Antrean> _isi;

  // Diisi tes agar repository pura-pura gagal.
  Kegagalan? gagalSaatMemuat;
  Kegagalan? gagalSaatMengambil;

  // Mata-mata (spy): berapa kali "server" dihubungi.
  int jumlahMemuat = 0;
  int jumlahMengambil = 0;

  // Jika true, setiap panggilan MENUNGGU sampai lepaskan() dipanggil.
  bool tahan = false;
  final List<Completer<void>> _menunggu = [];

  void lepaskan() {
    for (final Completer<void> c in _menunggu) {
      c.complete();
    }
    _menunggu.clear();
  }

  Future<void> _mungkinDitahan() async {
    if (!tahan) return;
    final Completer<void> penahan = Completer<void>();
    _menunggu.add(penahan);
    await penahan.future;
  }

  @override
  Future<Hasil<List<Antrean>>> semua() async {
    jumlahMemuat++;
    await _mungkinDitahan();
    final Kegagalan? kegagalan = gagalSaatMemuat;
    if (kegagalan != null) return Gagal(kegagalan);
    return Berhasil(List.of(_isi));
  }

  @override
  Future<Hasil<Antrean>> ambilNomor({
    required String nama,
    required String keperluan,
  }) async {
    jumlahMengambil++;
    await _mungkinDitahan();
    final Kegagalan? kegagalan = gagalSaatMengambil;
    if (kegagalan != null) return Gagal(kegagalan);
    final Antrean baru = Antrean(
      nomor: _isi.length + 1,
      nama: nama,
      keperluan: keperluan,
    );
    _isi.add(baru);
    return Berhasil(baru);
  }
}

// ======= BERKAS: test/ui/antrean/antrean_view_model_test.dart =======

void main() {
  late RepositoriAntreanPalsu repositori;
  late AntreanViewModel vm;

  // setUp di luar group berlaku untuk SEMUA tes di berkas ini.
  setUp(() {
    repositori = RepositoriAntreanPalsu(
      isi: const [
        Antrean(nomor: 1, nama: 'Rina', keperluan: 'Bimbingan proposal'),
        Antrean(nomor: 2, nama: 'Dimas', keperluan: 'Tanda tangan KRS'),
      ],
    );
    vm = AntreanViewModel(repositori: repositori);
  });

  // tearDown dijalankan SETELAH setiap tes: membereskan ViewModel.
  tearDown(() {
    vm.dispose();
  });

  group('memuat', () {
    test('mula-mula berstatus memuat dengan daftar kosong', () {
      expect(vm.status, StatusMuat.memuat);
      expect(vm.daftar, isEmpty);
    });

    test('berhasil: daftar terisi dari repository', () async {
      await vm.muat();

      expect(vm.status, StatusMuat.berhasil);
      expect(vm.daftar, hasLength(2));
      expect(vm.daftar.first.nama, 'Rina');
    });

    test('gagal: menjadi pesan yang ramah, bukan exception', () async {
      repositori.gagalSaatMemuat = const TanpaKoneksi();

      await vm.muat();

      expect(vm.status, StatusMuat.gagal);
      expect(
        vm.pesanGalat,
        'Tidak dapat terhubung. Periksa koneksi internet Anda.',
      );
    });

    test('saat repository ditahan, status masih memuat', () async {
      repositori.tahan = true;

      final Future<void> proses = vm.muat(); // sengaja BELUM di-await
      expect(vm.status, StatusMuat.memuat);

      repositori.lepaskan(); // "server" menjawab
      await proses;
      expect(vm.status, StatusMuat.berhasil);
    });

    test('pendengar diberi kabar saat mulai dan saat selesai memuat', () async {
      final List<StatusMuat> tercatat = [];
      vm.addListener(() => tercatat.add(vm.status));

      await vm.muat();

      expect(tercatat, [StatusMuat.memuat, StatusMuat.berhasil]);
    });
  });

  group('mengambil nomor', () {
    // setUp di dalam group dijalankan SETELAH setUp di luar.
    setUp(() async {
      await vm.muat();
    });

    test('berhasil: mendapat nomor 3 dan daftar dibaca ulang', () async {
      final bool berhasil = await vm.ambilNomor(
        nama: 'Sari',
        keperluan: 'Konsultasi judul skripsi',
      );

      expect(berhasil, isTrue);
      expect(vm.nomorSaya?.nomor, 3);
      expect(vm.daftar, hasLength(3));
      expect(repositori.jumlahMemuat, 2); // muat awal + baca ulang
    });

    test('nama kosong ditolak SEBELUM menghubungi server', () async {
      final bool berhasil = await vm.ambilNomor(
        nama: '   ',
        keperluan: 'Konsultasi judul skripsi',
      );

      expect(berhasil, isFalse);
      expect(vm.pesanKirim, 'Nama wajib diisi.');
      expect(repositori.jumlahMengambil, 0);
    });

    test('nama yang sudah antre ditolak', () async {
      final bool berhasil = await vm.ambilNomor(
        nama: 'rina',
        keperluan: 'Bimbingan bab 2',
      );

      expect(berhasil, isFalse);
      expect(vm.pesanKirim, 'rina sudah punya nomor antrean.');
    });

    test('ketukan ganda hanya mengirim SATU kali', () async {
      repositori.tahan = true;

      final Future<bool> pertama = vm.ambilNomor(
        nama: 'Sari',
        keperluan: 'Konsultasi judul skripsi',
      );
      expect(vm.mengirim, isTrue); // tombol di layar seharusnya mati

      final bool kedua = await vm.ambilNomor(
        nama: 'Sari',
        keperluan: 'Konsultasi judul skripsi',
      );
      expect(kedua, isFalse);

      repositori
        ..tahan = false
        ..lepaskan();
      expect(await pertama, isTrue);
      expect(repositori.jumlahMengambil, 1);
      expect(vm.mengirim, isFalse);
    });

    test('pesan penolakan bisa dibersihkan', () async {
      await vm.ambilNomor(nama: '', keperluan: 'Konsultasi judul skripsi');
      expect(vm.pesanKirim, isNotNull);

      vm.bersihkanPesanKirim();

      expect(vm.pesanKirim, isNull);
    });

    test('server gagal: pesan tampil dan pengiriman bisa diulang', () async {
      repositori.gagalSaatMengambil = const ServerBermasalah(503);

      final bool berhasil = await vm.ambilNomor(
        nama: 'Sari',
        keperluan: 'Konsultasi judul skripsi',
      );

      expect(berhasil, isFalse);
      expect(
        vm.pesanKirim,
        'Server sedang bermasalah (kode 503). Coba lagi nanti.',
      );
      expect(vm.mengirim, isFalse);
    });
  });

  test('ViewModel yang dibuang saat memuat tidak memberi kabar lagi', () async {
    // ViewModel kedua, karena yang dari setUp dibuang oleh tearDown.
    final AntreanViewModel lain = AntreanViewModel(repositori: repositori);
    repositori.tahan = true;

    final Future<void> proses = lain.muat();
    lain.dispose(); // halaman ditutup sebelum data datang
    repositori.lepaskan();

    // Tanpa penjaga _sudahDibuang, baris ini gagal dengan FlutterError:
    // "A AntreanViewModel was used after being disposed."
    await proses;
    expect(repositori.jumlahMemuat, 1);
  });
}

// HASIL di DartPad (panel Console), diringkas:
// 00:00 +0: memuat mula-mula berstatus memuat dengan daftar kosong
// ...
// 00:00 +8: mengambil nomor ketukan ganda hanya mengirim SATU kali
// ...
// 00:00 +12: All tests passed!
