// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 06: Widget Test dengan ViewModel dan Data Palsu
// Topik: Tampilan "Antrean Konsultasi Dosen" (ViewModel dan repository
//        palsu dari Contoh 04) diuji di SEMUA keadaannya:
//        - memuat -> daftar; gagal -> pesan + "Coba lagi"; kosong;
//        - tombol Kirim MATI selama mengirim, lalu SnackBar nomor;
//        - layar sempit 320 piksel dengan huruf 200%;
//        - mode gelap;
//        - pedoman aksesibilitas (ukuran target sentuh, label, kontras).
//        Lingkaran memuat yang terus berputar membuat pumpAndSettle()
//        tidak pernah selesai. Karena itu, repository palsu bisa
//        DITAHAN dan DILEPASKAN oleh tes.
// =====================================================================
// CARA MENJALANKAN:
// Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_06_widget_test_dengan_viewmodel_test.dart
// Ingin melihat aplikasinya? Di DartPad, ganti nama main() milik tes
// menjadi mainTes(), lalu tambahkan:
//    void main() => runApp(
//      Provider<RepositoriAntrean>.value(
//        value: RepositoriAntreanPalsu(isi: contohAntrean),
//        child: const AplikasiAntrean(),
//      ),
//    );
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

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

// ===================== BERKAS: lib/ui/core/tema.dart =====================

final ThemeData temaTerang = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
);

final ThemeData temaGelap = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
);

// ================== BERKAS: lib/ui/core/aplikasi.dart ==================

class AplikasiAntrean extends StatelessWidget {
  const AplikasiAntrean({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antrean Konsultasi',
      debugShowCheckedModeBanner: false,
      theme: temaTerang,
      darkTheme: temaGelap, // dipakai saat HP dalam mode gelap
      home: const HalamanAntrean(),
    );
  }
}

// ================= BERKAS: lib/ui/core/pesan_gagal.dart =================

class PesanGagal extends StatelessWidget {
  const PesanGagal({super.key, required this.pesan, required this.onCobaLagi});

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
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

// ========= BERKAS: lib/ui/antrean/widgets/halaman_antrean.dart =========

class HalamanAntrean extends StatelessWidget {
  const HalamanAntrean({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          AntreanViewModel(repositori: context.read<RepositoriAntrean>())
            ..muat(),
      child: const _TampilanAntrean(),
    );
  }
}

class _TampilanAntrean extends StatelessWidget {
  const _TampilanAntrean();

  Future<void> _bukaFormulir(BuildContext context) async {
    final AntreanViewModel vm = context.read<AntreanViewModel>();
    final Antrean? baru = await showModalBottomSheet<Antrean>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) => ChangeNotifierProvider.value(
        value: vm,
        child: const LembarAmbilNomor(),
      ),
    );
    vm.bersihkanPesanKirim(); // pesan lama tidak muncul lagi
    if (baru == null || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nomor antrean Anda: ${baru.nomor}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AntreanViewModel vm = context.watch<AntreanViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Antrean Konsultasi')),
      body: switch (vm.status) {
        StatusMuat.memuat => const Center(child: CircularProgressIndicator()),
        StatusMuat.gagal => PesanGagal(
          pesan: vm.pesanGalat ?? '',
          onCobaLagi: vm.muat,
        ),
        StatusMuat.berhasil when vm.daftar.isEmpty => const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Belum ada antrean. Jadilah yang pertama!',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        StatusMuat.berhasil => ListView(
          padding: const EdgeInsets.only(bottom: 88),
          children: [
            for (final Antrean a in vm.daftar)
              ListTile(
                leading: CircleAvatar(child: Text('${a.nomor}')),
                title: Text(a.nama),
                subtitle: Text(a.keperluan),
              ),
          ],
        ),
      },
      // Tombol hanya muncul setelah daftar berhasil dimuat.
      floatingActionButton: vm.status == StatusMuat.berhasil
          ? FloatingActionButton.extended(
              onPressed: () => _bukaFormulir(context),
              icon: const Icon(Icons.how_to_reg),
              label: const Text('Ambil nomor'),
            )
          : null,
    );
  }
}

// ======== BERKAS: lib/ui/antrean/widgets/lembar_ambil_nomor.dart ========

class LembarAmbilNomor extends StatefulWidget {
  const LembarAmbilNomor({super.key});

  @override
  State<LembarAmbilNomor> createState() => _LembarAmbilNomorState();
}

class _LembarAmbilNomorState extends State<LembarAmbilNomor> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _keperluan = TextEditingController();

  @override
  void dispose() {
    _nama.dispose();
    _keperluan.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    final AntreanViewModel vm = context.read<AntreanViewModel>();
    final bool berhasil = await vm.ambilNomor(
      nama: _nama.text,
      keperluan: _keperluan.text,
    );
    if (!mounted) return;
    if (berhasil) {
      Navigator.pop(context, vm.nomorSaya);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AntreanViewModel vm = context.watch<AntreanViewModel>();
    final String? pesan = vm.pesanKirim;
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
              'Ambil nomor antrean',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('isian_nama'),
              controller: _nama,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('isian_keperluan'),
              controller: _keperluan,
              decoration: const InputDecoration(
                labelText: 'Keperluan',
                border: OutlineInputBorder(),
              ),
            ),
            if (pesan != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  pesan,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('tombol_kirim'),
              // null = tombol MATI selama pengiriman berjalan.
              onPressed: vm.mengirim ? null : _kirim,
              icon: vm.mengirim
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(vm.mengirim ? 'Mengirim...' : 'Kirim'),
            ),
          ],
        ),
      ),
    );
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

// ====== BERKAS: test/ui/antrean/halaman_antrean_test.dart ======

const List<Antrean> contohAntrean = [
  Antrean(nomor: 1, nama: 'Rina', keperluan: 'Bimbingan proposal'),
  Antrean(nomor: 2, nama: 'Dimas', keperluan: 'Tanda tangan KRS'),
];

/// Memasang aplikasi ASLI, tetapi dengan repository palsu.
Future<void> pasangAplikasi(
  WidgetTester tester,
  RepositoriAntreanPalsu repositori,
) async {
  await tester.pumpWidget(
    Provider<RepositoriAntrean>.value(
      value: repositori,
      child: const AplikasiAntrean(),
    ),
  );
}

/// Membuka lembar formulir lewat tombol "Ambil nomor".
Future<void> bukaFormulir(WidgetTester tester) async {
  await tester.tap(find.text('Ambil nomor'));
  await tester.pumpAndSettle(); // tunggu animasi lembar selesai
}

/// Kecerahan tema (terang atau gelap) yang dipakai widget [sasaran].
///
/// Sengaja dibuat TANPA async. Aturan use_build_context_synchronously
/// memprotes BuildContext yang dipakai sesudah `await`, juga di dalam
/// tes (walaupun di tes sebenarnya aman), dan CI menganggapnya gagal.
/// Fungsi tanpa async tidak punya `await`, jadi tidak ada yang diprotes.
Brightness kecerahanTema(WidgetTester tester, Finder sasaran) {
  final BuildContext konteks = tester.element(sasaran);
  return Theme.of(konteks).brightness;
}

void main() {
  late RepositoriAntreanPalsu repositori;

  setUp(() {
    repositori = RepositoriAntreanPalsu(isi: contohAntrean);
  });

  testWidgets('lingkaran memuat tampil, lalu berganti daftar antrean', (
    WidgetTester tester,
  ) async {
    repositori.tahan = true; // "server" belum menjawab

    await pasangAplikasi(tester, repositori);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Rina'), findsNothing);
    // Jangan pumpAndSettle() di sini: lingkaran memuat terus berputar,
    // sehingga layar tidak pernah "tenang" dan tesnya gagal.

    repositori.lepaskan();
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Rina'), findsOneWidget);
    expect(find.text('Dimas'), findsOneWidget);
    expect(find.text('Ambil nomor'), findsOneWidget);
  });

  testWidgets('gagal memuat: pesan dan tombol Coba lagi yang berfungsi', (
    WidgetTester tester,
  ) async {
    repositori.gagalSaatMemuat = const TanpaKoneksi();

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    expect(
      find.text('Tidak dapat terhubung. Periksa koneksi internet Anda.'),
      findsOneWidget,
    );
    expect(find.text('Ambil nomor'), findsNothing);

    repositori.gagalSaatMemuat = null; // koneksi kembali
    await tester.tap(find.text('Coba lagi'));
    await tester.pumpAndSettle();

    expect(find.text('Rina'), findsOneWidget);
    expect(repositori.jumlahMemuat, 2);
  });

  testWidgets('antrean kosong menampilkan ajakan', (WidgetTester tester) async {
    await pasangAplikasi(tester, RepositoriAntreanPalsu());
    await tester.pumpAndSettle();

    expect(
      find.text('Belum ada antrean. Jadilah yang pertama!'),
      findsOneWidget,
    );
  });

  testWidgets('isian kosong: alasan tampil dan server tidak dihubungi', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);

    await tester.tap(find.text('Kirim'));
    await tester.pump();

    expect(find.text('Nama wajib diisi.'), findsOneWidget);
    expect(repositori.jumlahMengambil, 0);
  });

  testWidgets('tombol Kirim mati selama mengirim, lalu nomor diumumkan', (
    WidgetTester tester,
  ) async {
    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);
    await tester.enterText(find.byKey(const Key('isian_nama')), 'Sari');
    await tester.enterText(
      find.byKey(const Key('isian_keperluan')),
      'Konsultasi judul skripsi',
    );

    repositori.tahan = true;
    await tester.tap(find.text('Kirim'));
    await tester.pump(); // satu bingkai: keadaan "sedang mengirim"

    final Finder tombol = find.byKey(const Key('tombol_kirim'));
    expect(tester.widget<ButtonStyleButton>(tombol).enabled, isFalse);
    expect(find.text('Mengirim...'), findsOneWidget);

    // Ketukan kedua pada tombol yang mati tidak berbuat apa-apa.
    await tester.tap(tombol, warnIfMissed: false);
    await tester.pump();
    expect(repositori.jumlahMengambil, 1);

    repositori
      ..tahan = false
      ..lepaskan();
    await tester.pumpAndSettle();

    expect(find.text('Nomor antrean Anda: 3'), findsOneWidget);
    expect(find.text('Sari'), findsOneWidget); // daftar sudah dibaca ulang
    expect(find.byType(LembarAmbilNomor), findsNothing); // lembar tertutup
  });

  testWidgets('layar sempit 320 piksel dengan huruf 200% tidak meluap', (
    WidgetTester tester,
  ) async {
    // Ukuran layar dan ukuran huruf diatur, lalu dikembalikan seusai tes.
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();
    await bukaFormulir(tester);
    await tester.tap(find.text('Kirim'));
    await tester.pump();

    // Tidak perlu expect khusus: jika ada yang meluap (overflow), Flutter
    // melaporkan galat dan tes ini otomatis GAGAL.
    expect(find.text('Nama wajib diisi.'), findsOneWidget);
  });

  testWidgets('mode gelap memakai tema gelap', (WidgetTester tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    // Tema yang dipakai di titik teks 'Rina' harus tema gelap.
    expect(kecerahanTema(tester, find.text('Rina')), Brightness.dark);
  });

  testWidgets('memenuhi pedoman aksesibilitas', (WidgetTester tester) async {
    final SemanticsHandle pegangan = tester.ensureSemantics();

    await pasangAplikasi(tester, repositori);
    await tester.pumpAndSettle();

    // Target sentuh minimal 48 x 48 (Android) dan semuanya berlabel.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    // Kontras teks cukup untuk dibaca.
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    pegangan.dispose();
  });
}

// HASIL (baris terakhir; angka waktu di depannya bisa berbeda):
// 00:04 +8: All tests passed!
