// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 08: Studi Kasus - Menguji "Pinjam Ruang Kampus"
// Topik: Pemeriksaan buatan sendiri (periksa, LULUS/GAGAL) di studi
//        kasus Pertemuan 12 dipindahkan ke flutter test, lalu dilengkapi
//        widget test. Kode aplikasinya TIDAK diubah sama sekali.
//        Satu berkas ini mewakili beberapa berkas di folder test/
//        (lihat judul "BERKAS: ..."):
//        1. domain : RentangWaktu dan aturan peminjaman di nilai batas;
//        2. use case: AjukanPeminjaman dengan repository palsu;
//        3. data   : RepositoriRuangServer dengan server palsu (MockClient);
//        4. ViewModel: JadwalRuangViewModel dengan jam tetap;
//        5. View   : daftar ruang, jadwal, dan "tombol Ajukan mati selama
//                    menyimpan" (janji Pertemuan 12, Bagian 9.1);
//        6. alur lengkap: seluruh aplikasi dengan data palsu.
// =====================================================================
// CARA MENJALANKAN:
// Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart
// Hanya satu kelompok, misalnya kelompok "aturan peminjaman":
//    flutter test --plain-name "aturan peminjaman" pertemuan_14_pengujian_dan_debugging/kode/contoh_08_studi_kasus_menguji_pinjam_ruang_test.dart
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

// Kode yang diuji: studi kasus Pertemuan 12.
import '../../pertemuan_12_clean_architecture/kode/contoh_08_studi_kasus_pinjam_ruang.dart';

void main() {
  ujiRentangWaktu();
  ujiAturanPeminjaman();
  ujiAjukanPeminjaman();
  ujiRepositoriRuangServer();
  ujiJadwalRuangViewModel();
  ujiHalamanDaftarRuang();
  ujiHalamanJadwalRuang();
  ujiAlurLengkap();
}

// ===================== BERKAS: testing/data_uji.dart =====================
// Data bersama untuk banyak tes.

/// Rabu, 14 Oktober 2026 pukul 10.00. Hari kerja berikutnya: Kamis, 15.
DateTime jamTetap() => DateTime(2026, 10, 14, 10);

DateTime kamis(int jam, [int menit = 0]) => DateTime(2026, 10, 15, jam, menit);

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
  fasilitas: [Fasilitas.papanTulis],
);

PengajuanPeminjaman pengajuan(
  String kodeRuang,
  RentangWaktu waktu, {
  int peserta = 10,
  String keperluan = 'Rapat panitia',
}) {
  return PengajuanPeminjaman(
    kodeRuang: kodeRuang,
    keperluan: keperluan,
    jumlahPeserta: peserta,
    waktu: waktu,
  );
}

/// Matcher: Hasil yang Gagal dengan kegagalan tertentu.
Matcher gagalDengan(Matcher kegagalan) => isA<Gagal<Object?>>().having(
  (Gagal<Object?> g) => g.kegagalan,
  'kegagalan',
  kegagalan,
);

/// Matcher: ditolak aturan dengan alasan tertentu.
Matcher ditolak(Object? alasan) => gagalDengan(
  isA<AturanDilanggar>().having(
    (AturanDilanggar k) => k.alasan,
    'alasan',
    alasan,
  ),
);

// ================= BERKAS: testing/fakes/repositori_uji.dart =================

/// Repository ruang yang bisa pura-pura gagal dan menghitung panggilan.
class RepositoriRuangUji implements RepositoriRuang {
  Kegagalan? gagal;
  int dipanggil = 0;

  @override
  Future<Hasil<List<Ruang>>> semuaRuang({bool segarkan = false}) async {
    dipanggil++;
    final Kegagalan? kegagalan = gagal;
    if (kegagalan != null) return Gagal(kegagalan);
    return const Berhasil(RepositoriRuangMemori.data);
  }
}

/// RepositoriPeminjamanMemori (Pertemuan 12) yang simpan()-nya bisa
/// DITAHAN, agar keadaan "sedang menyimpan" bisa diperiksa.
class RepositoriPeminjamanDitahan extends RepositoriPeminjamanMemori {
  RepositoriPeminjamanDitahan({super.sekarang});

  Completer<void>? penahan;
  int jumlahSimpan = 0;

  @override
  Future<Hasil<Peminjaman>> simpan(
    PengajuanPeminjaman pengajuan,
    Pengguna peminjam,
  ) async {
    jumlahSimpan++;
    final Completer<void>? tahan = penahan;
    if (tahan != null) await tahan.future;
    return super.simpan(pengajuan, peminjam);
  }
}

// ======== BERKAS: test/domain/models/rentang_waktu_test.dart ========

void ujiRentangWaktu() {
  group('RentangWaktu', () {
    test('09.00-11.00 dan 10.00-12.00 bertumpuk', () {
      expect(
        rentang(kamis(9), 120).bertumpukDengan(rentang(kamis(10), 120)),
        isTrue,
      );
    });

    test('09.00-11.00 dan 11.00-12.00 bersambung, tidak bertumpuk', () {
      expect(
        rentang(kamis(9), 120).bertumpukDengan(rentang(kamis(11), 60)),
        isFalse,
      );
    });

    test('dua rentang dengan jam sama dianggap sama (==)', () {
      expect(rentang(kamis(9), 60), rentang(kamis(9), 60));
    });

    test('teksJam memakai dua digit dan titik', () {
      expect(rentang(kamis(9), 90).teksJam, '09.00–10.30');
    });
  });
}

// ====== BERKAS: test/domain/models/aturan_peminjaman_test.dart ======

void ujiAturanPeminjaman() {
  group('aturan peminjaman', () {
    String? aturan(RentangWaktu waktu, {int peserta = 8, String? keperluan}) {
      return periksaPengajuan(
        pengajuan(
          'C-110',
          waktu,
          peserta: peserta,
          keperluan: keperluan ?? 'Diskusi kelompok',
        ),
        ruang: ruangDiskusi,
        sekarang: jamTetap(),
      );
    }

    const String alasanLama = 'Lama peminjaman harus 30 menit sampai 3 jam.';
    const String alasanJam =
        'Ruang hanya bisa dipinjam pukul 07.00 sampai 21.00.';

    test('pengajuan wajar lolos', () {
      expect(aturan(rentang(kamis(13), 90)), isNull);
    });

    test('lama: 29 menit ditolak, 30 menit lolos', () {
      expect(aturan(rentang(kamis(13), 29)), alasanLama);
      expect(aturan(rentang(kamis(13), 30)), isNull);
    });

    test('lama: 3 jam lolos, 3 jam 1 menit ditolak', () {
      expect(aturan(rentang(kamis(9), 180)), isNull);
      expect(aturan(rentang(kamis(9), 181)), alasanLama);
    });

    test('jam buka: mulai 07.00 lolos, mulai 06.30 ditolak', () {
      expect(aturan(rentang(kamis(7), 60)), isNull);
      expect(aturan(rentang(kamis(6, 30), 60)), alasanJam);
    });

    test('jam tutup: selesai 21.00 lolos, selesai 21.30 ditolak', () {
      expect(aturan(rentang(kamis(20), 60)), isNull);
      expect(aturan(rentang(kamis(20, 30), 60)), alasanJam);
    });

    test('peserta: 12 (kapasitas) lolos, 13 ditolak, 0 ditolak', () {
      expect(aturan(rentang(kamis(13), 60), peserta: 12), isNull);
      expect(
        aturan(rentang(kamis(13), 60), peserta: 13),
        'Peserta (13) melebihi kapasitas Ruang Diskusi C.110 (12 orang).',
      );
      expect(
        aturan(rentang(kamis(13), 60), peserta: 0),
        'Jumlah peserta minimal 1 orang.',
      );
    });

    test('hari: Jumat lolos, Sabtu ditolak', () {
      expect(aturan(rentang(DateTime(2026, 10, 16, 9), 60)), isNull);
      expect(
        aturan(rentang(DateTime(2026, 10, 17, 9), 60)),
        'Ruang hanya bisa dipinjam Senin sampai Jumat.',
      );
    });

    test('mulai tepat "sekarang" ditolak, semenit kemudian lolos', () {
      expect(
        aturan(rentang(jamTetap(), 60)),
        'Waktu mulai sudah lewat. Pilih jam yang akan datang.',
      );
      expect(
        aturan(rentang(jamTetap().add(const Duration(minutes: 1)), 60)),
        isNull,
      );
    });

    test('keperluan berisi spasi saja ditolak', () {
      expect(
        aturan(rentang(kamis(13), 60), keperluan: '   '),
        'Keperluan wajib diisi.',
      );
    });
  });
}

// ===== BERKAS: test/domain/use_cases/ajukan_peminjaman_test.dart =====

void ujiAjukanPeminjaman() {
  group('AjukanPeminjaman', () {
    late RepositoriPeminjamanMemori peminjaman;
    late AjukanPeminjaman ajukan;

    setUp(() {
      // Data contoh P12: di Kamis ada "Seminar Proposal Skripsi" di C-105
      // pukul 09.00-11.00, dan Budi sudah punya 1 peminjaman aktif.
      peminjaman = RepositoriPeminjamanMemori(
        sekarang: jamTetap,
        pemilikContoh: budi,
      );
      ajukan = AjukanPeminjaman(
        ruang: RepositoriRuangMemori(jeda: Duration.zero),
        peminjaman: peminjaman,
        sekarang: jamTetap,
      );
    });

    Future<int> jumlahDiRuang(String kode) async {
      final Hasil<List<Peminjaman>> hasil = await peminjaman.milikRuang(kode);
      return (hasil as Berhasil<List<Peminjaman>>).nilai.length;
    }

    test('bentrok ditolak dan TIDAK disimpan', () async {
      final Hasil<Peminjaman> hasil = await ajukan.jalankan(
        pengajuan('C-105', rentang(kamis(10), 120)),
        budi,
      );

      expect(
        hasil,
        ditolak('Bentrok dengan "Seminar Proposal Skripsi" pukul 09.00–11.00.'),
      );
      expect(await jumlahDiRuang('C-105'), 2);
    });

    test('jam yang bersambung (11.00-12.00) diterima', () async {
      final Hasil<Peminjaman> hasil = await ajukan.jalankan(
        pengajuan('C-105', rentang(kamis(11), 60)),
        budi,
      );

      expect(hasil, isA<Berhasil<Peminjaman>>());
      expect(await jumlahDiRuang('C-105'), 3);
    });

    test('peminjaman aktif ketiga ditolak', () async {
      await ajukan.jalankan(pengajuan('C-105', rentang(kamis(11), 60)), budi);

      final Hasil<Peminjaman> ketiga = await ajukan.jalankan(
        pengajuan('LAB-2', rentang(DateTime(2026, 10, 16, 9), 60)),
        budi,
      );

      expect(
        ketiga,
        ditolak(
          'Anda sudah punya 2 peminjaman aktif. Batalkan salah satu dulu.',
        ),
      );
    });

    test('ruang yang tidak ada ditolak', () async {
      expect(
        await ajukan.jalankan(pengajuan('Z-999', rentang(kamis(9), 60)), budi),
        ditolak('Ruang tidak ditemukan.'),
      );
    });

    test('kegagalan repository ruang diteruskan apa adanya', () async {
      final AjukanPeminjaman tanpaInternet = AjukanPeminjaman(
        ruang: RepositoriRuangUji()..gagal = const TanpaKoneksi(),
        peminjaman: peminjaman,
        sekarang: jamTetap,
      );

      final Hasil<Peminjaman> hasil = await tanpaInternet.jalankan(
        pengajuan('C-110', rentang(kamis(9), 60)),
        budi,
      );

      expect(hasil, gagalDengan(isA<TanpaKoneksi>()));
      expect(await jumlahDiRuang('C-110'), 0);
    });
  });
}

// === BERKAS: test/data/repositories/repositori_ruang_server_test.dart ===

const String jsonServerPalsu = '''
{
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

void ujiRepositoriRuangServer() {
  group('RepositoriRuangServer', () {
    // "Server" palsu yang bisa diatur dari dalam tes.
    late List<http.Request> permintaan;
    late String jawaban;
    late int kodeStatus;
    late Exception? galat;
    late RepositoriRuangServer repositori;

    setUp(() {
      permintaan = [];
      jawaban = jsonServerPalsu;
      kodeStatus = 200;
      galat = null;
      repositori = RepositoriRuangServer(
        layanan: LayananApiKampus(
          klien: MockClient((http.Request p) async {
            permintaan.add(p);
            final Exception? lempar = galat;
            if (lempar != null) throw lempar;
            return http.Response(jawaban, kodeStatus);
          }),
        ),
      );
    });

    test('JSON server menjadi entitas: hanya ruang aktif', () async {
      final Hasil<List<Ruang>> hasil = await repositori.semuaRuang();

      final List<Ruang> daftar = (hasil as Berhasil<List<Ruang>>).nilai;
      expect(daftar, hasLength(1));
      expect(daftar.single.nama, 'Ruang Diskusi C.110');
      expect(daftar.single.gedung, 'Gedung C');
      // Fasilitas "stage" belum dikenal aplikasi, jadi dilewati.
      expect(daftar.single.fasilitas, [Fasilitas.papanTulis]);
      expect(permintaan.single.url, LayananApiKampus.alamatRuang);
    });

    test('panggilan kedua memakai salinan; segarkan meminta ulang', () async {
      await repositori.semuaRuang();
      await repositori.semuaRuang();
      expect(permintaan, hasLength(1));

      await repositori.semuaRuang(segarkan: true);
      expect(permintaan, hasLength(2));
    });

    test('kode 500 menjadi ServerBermasalah(500)', () async {
      kodeStatus = 500;
      expect(
        await repositori.semuaRuang(),
        gagalDengan(
          isA<ServerBermasalah>().having(
            (ServerBermasalah k) => k.kodeStatus,
            'kodeStatus',
            500,
          ),
        ),
      );
    });

    test('bukan JSON menjadi DataRusak', () async {
      jawaban = '<html>bukan json</html>';
      expect(await repositori.semuaRuang(), gagalDengan(isA<DataRusak>()));
    });

    test('koneksi putus menjadi TanpaKoneksi', () async {
      galat = http.ClientException('Tidak ada koneksi');
      expect(await repositori.semuaRuang(), gagalDengan(isA<TanpaKoneksi>()));
    });

    test('server terlalu lama menjadi WaktuHabis', () async {
      galat = TimeoutException('Terlalu lama');
      expect(await repositori.semuaRuang(), gagalDengan(isA<WaktuHabis>()));
    });
  });
}

// === BERKAS: test/ui/jadwal_ruang/jadwal_ruang_view_model_test.dart ===

void ujiJadwalRuangViewModel() {
  group('JadwalRuangViewModel', () {
    late RepositoriPeminjamanDitahan repositori;
    late JadwalRuangViewModel vm;

    setUp(() async {
      repositori = RepositoriPeminjamanDitahan();
      vm = JadwalRuangViewModel(
        ruang: ruangDiskusi,
        pengguna: budi,
        repositori: repositori,
        ajukanPeminjaman: AjukanPeminjaman(
          ruang: RepositoriRuangMemori(jeda: Duration.zero),
          peminjaman: repositori,
          sekarang: jamTetap,
        ),
        sekarang: jamTetap,
      );
      // Constructor langsung memuat. Tunggu antrean Future selesai.
      await pumpEventQueue();
    });

    tearDown(() {
      vm.dispose();
    });

    test('pilihan tanggal: hari ini, lalu hari kerja berikutnya', () {
      expect(vm.pilihanTanggal.map((DateTime t) => t.day), [
        14,
        15,
        16,
        19,
        20,
      ]);
      expect(vm.labelTanggal(DateTime(2026, 10, 14)), 'Hari ini');
      expect(vm.labelTanggal(DateTime(2026, 10, 15)), 'Kamis, 15 Okt');
    });

    test('setelah mengajukan, jadwal dibaca ulang', () async {
      vm.pilihTanggal(DateTime(2026, 10, 15));

      await vm.ajukan.jalankan(pengajuan('C-110', rentang(kamis(9), 60)));

      expect(vm.ajukan.berhasil, isTrue);
      expect(vm.jadwalTanggalIni.map((Peminjaman p) => p.waktu.teksJam), [
        '09.00–10.00',
      ]);
    });

    test('ketukan ganda: Perintah hanya menyimpan sekali', () async {
      repositori.penahan = Completer<void>();
      final PengajuanPeminjaman isian = pengajuan(
        'C-110',
        rentang(kamis(9), 60),
      );

      final Future<void> pertama = vm.ajukan.jalankan(isian);
      await pumpEventQueue(); // biarkan use case sampai ke simpan()
      expect(vm.ajukan.sedangBerjalan, isTrue);
      await vm.ajukan.jalankan(isian); // ditolak penjaga Perintah

      repositori.penahan!.complete();
      await pertama;
      expect(repositori.jumlahSimpan, 1);
    });

    test('pengajuan yang melanggar aturan: perintah gagal', () async {
      await vm.ajukan.jalankan(
        pengajuan('C-110', rentang(kamis(9), 60), peserta: 15),
      );

      expect(vm.ajukan.gagal, isTrue);
      expect(
        vm.ajukan.hasil,
        ditolak(
          'Peserta (15) melebihi kapasitas Ruang Diskusi C.110 (12 orang).',
        ),
      );
    });
  });
}

// ======= BERKAS: test/ui/daftar_ruang/halaman_daftar_ruang_test.dart =======

Future<void> pasangDaftarRuang(
  WidgetTester tester,
  RepositoriRuang repositori,
) async {
  await tester.pumpWidget(
    Provider<RepositoriRuang>.value(
      value: repositori,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        home: const HalamanDaftarRuang(),
      ),
    ),
  );
}

void ujiHalamanDaftarRuang() {
  group('HalamanDaftarRuang', () {
    testWidgets('saringan "≥ 80" hanya menyisakan ruang besar', (
      WidgetTester tester,
    ) async {
      // Jeda 300 ms tidak membuat tes lambat: di widget test, waktunya
      // palsu dan dimajukan oleh pump.
      await pasangDaftarRuang(tester, RepositoriRuangMemori());
      await tester.pumpAndSettle();
      expect(find.text('Laboratorium Komputer 1'), findsOneWidget);

      await tester.tap(find.text('≥ 80'));
      await tester.pumpAndSettle();

      expect(find.byType(KartuRuang), findsNWidgets(2));
      expect(find.text('Ruang Seminar C.105'), findsOneWidget);
      expect(find.text('Aula Fakultas'), findsOneWidget);
      expect(find.text('Laboratorium Komputer 1'), findsNothing);
    });

    testWidgets('server bermasalah: pesan dan Coba lagi', (
      WidgetTester tester,
    ) async {
      final RepositoriRuangUji repositori = RepositoriRuangUji()
        ..gagal = const ServerBermasalah(503);

      await pasangDaftarRuang(tester, repositori);
      await tester.pumpAndSettle();
      expect(
        find.text('Server sedang bermasalah (kode 503). Coba lagi nanti.'),
        findsOneWidget,
      );

      repositori.gagal = null;
      await tester.tap(find.text('Coba lagi'));
      await tester.pumpAndSettle();

      expect(find.text('Laboratorium Komputer 1'), findsOneWidget);
      expect(repositori.dipanggil, 2);
    });
  });
}

// ====== BERKAS: test/ui/jadwal_ruang/halaman_jadwal_ruang_test.dart ======

/// Tombol (FilledButton, FilledButton.icon, dan lain-lain) yang memuat
/// tulisan [teks]. FilledButton.icon sebenarnya kelas TURUNAN dari
/// FilledButton, jadi dicari dengan predikat "is ButtonStyleButton".
Finder tombol(String teks) => find.ancestor(
  of: find.text(teks),
  matching: find.byWidgetPredicate((Widget w) => w is ButtonStyleButton),
);

bool aktif(WidgetTester tester, Finder finder) =>
    tester.widget<ButtonStyleButton>(finder).enabled;

void ujiHalamanJadwalRuang() {
  group('HalamanJadwalRuang', () {
    late RepositoriPeminjamanDitahan repositori;

    setUp(() {
      repositori = RepositoriPeminjamanDitahan();
    });

    Future<void> pasang(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<Pengguna>.value(value: budi),
            Provider<RepositoriPeminjaman>.value(value: repositori),
            Provider<AjukanPeminjaman>.value(
              value: AjukanPeminjaman(
                // RepositoriRuangUji menjawab tanpa jeda sama sekali.
                // (RepositoriRuangMemori tetap memakai Future.delayed,
                // walaupun jedanya nol, dan pump() tanpa durasi TIDAK
                // memajukan jam palsu. Lihat modul Bagian 9.)
                ruang: RepositoriRuangUji(),
                peminjaman: repositori,
                // Jam palsu di masa lalu: kapan pun tes dijalankan, jam
                // 09.00 hari ini dianggap belum lewat.
                sekarang: () => DateTime(2026, 1, 1),
              ),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            ),
            home: const HalamanJadwalRuang(ruang: ruangDiskusi),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> isiFormulir(
      WidgetTester tester, {
      required String peserta,
    }) async {
      await tester.tap(find.text('Ajukan peminjaman'));
      await tester.pumpAndSettle(); // tunggu lembar terbuka
      await tester.enterText(
        find.widgetWithText(TextField, 'Keperluan'),
        'Rapat himpunan',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Jumlah peserta'),
        peserta,
      );
    }

    testWidgets('jadwal kosong: ruang bebas seharian', (
      WidgetTester tester,
    ) async {
      await pasang(tester);

      expect(
        find.text('Belum ada peminjaman. Ruang bebas seharian.'),
        findsOneWidget,
      );
    });

    testWidgets('tombol Ajukan MATI selama menyimpan', (
      WidgetTester tester,
    ) async {
      await pasang(tester);
      await isiFormulir(tester, peserta: '8');
      repositori.penahan = Completer<void>();

      await tester.tap(tombol('Ajukan'));
      await tester.pump(); // satu bingkai: keadaan "sedang menyimpan"

      expect(aktif(tester, tombol('Ajukan')), isFalse);
      expect(
        find.descendant(
          of: tombol('Ajukan'),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );

      // Ketukan kedua pada tombol yang mati diabaikan.
      await tester.tap(tombol('Ajukan'), warnIfMissed: false);
      await tester.pump();
      expect(repositori.jumlahSimpan, 1);

      repositori.penahan!.complete(); // "server" selesai menyimpan
      await tester.pumpAndSettle();

      expect(find.textContaining('Peminjaman PJ-001 tercatat'), findsOneWidget);
      expect(find.text('Rapat himpunan'), findsOneWidget); // masuk jadwal
    });

    testWidgets('melanggar aturan: alasan tampil, lembar tetap terbuka', (
      WidgetTester tester,
    ) async {
      await pasang(tester);
      await isiFormulir(tester, peserta: '15');

      await tester.tap(tombol('Ajukan'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Peserta (15) melebihi kapasitas Ruang Diskusi C.110 (12 orang).',
        ),
        findsOneWidget,
      );
      expect(find.byType(LembarPengajuan), findsOneWidget);
      expect(aktif(tester, tombol('Ajukan')), isTrue); // boleh dicoba lagi
    });
  });
}

// =========== BERKAS: test/ui/alur_pinjam_ruang_test.dart ===========

void ujiAlurLengkap() {
  testWidgets('alur lengkap: pilih ruang, ajukan, lihat di Peminjaman Saya', (
    WidgetTester tester,
  ) async {
    // Akar komposisi yang SAMA dengan aplikasi, lingkungan pengembangan.
    await tester.pumpWidget(
      MultiProvider(
        providers: buatPenyedia(Lingkungan.pengembangan),
        child: const AplikasiPinjamRuang(lingkungan: Lingkungan.pengembangan),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Ruang Diskusi C.110 berada di bawah: gulir dulu, baru ketuk.
    //    Geseran terakhir scrollUntilVisible baru tampil setelah bingkai
    //    berikutnya, jadi pumpAndSettle dulu sebelum mengetuk.
    await tester.scrollUntilVisible(find.text('Ruang Diskusi C.110'), 100);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ruang Diskusi C.110'));
    await tester.pumpAndSettle();

    // 2. Pilih hari kerja BERIKUTNYA, agar jam 09.00 pasti belum lewat.
    await tester.tap(find.byType(ChoiceChip).at(1));
    await tester.pumpAndSettle();

    // 3. Isi lembar pengajuan.
    await tester.tap(find.text('Ajukan peminjaman'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Keperluan'),
      'Rapat himpunan',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Jumlah peserta'),
      '8',
    );
    await tester.tap(tombol('Ajukan'));
    await tester.pumpAndSettle();

    // Data contoh berisi 4 peminjaman, jadi nomornya PJ-005.
    expect(find.textContaining('Peminjaman PJ-005 tercatat'), findsOneWidget);

    // 4. Kembali, lalu buka tab Peminjaman Saya.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Peminjaman Saya'));
    await tester.pumpAndSettle();

    expect(find.text('Rapat himpunan'), findsOneWidget);
    expect(find.text('Belajar kelompok Basis Data'), findsOneWidget);
    expect(find.textContaining('2 dari 2 peminjaman aktif'), findsOneWidget);
  });
}

// HASIL (baris terakhir; angka waktu di depannya bisa berbeda):
// 00:13 +34: All tests passed!
