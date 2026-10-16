// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 16: UJIAN AKHIR SEMESTER
// CONTOH 02: Pengatur Waktu Presentasi
// Topik: Alat bantu GLADI RESIK dan hari-H UAS. Waktu satu tim dibagi
//        menjadi beberapa BAGIAN (Panduan UAS Bagian 3): presentasi dan
//        demo, uji langsung, tanya jawab, dan catatan penguji.
//        Pola yang dipakai sudah Anda kenal:
//        1. ViewModel (ChangeNotifier) menyimpan state dan logikanya;
//        2. JAM DISUNTIKKAN lewat constructor, sehingga logikanya bisa
//           diuji tanpa menunggu bermenit-menit (Pertemuan 14);
//        3. sisa waktu DIHITUNG dari selisih jam, bukan dari jumlah
//           detak Timer, agar tetap tepat walaupun aplikasi sempat
//           tertunda;
//        4. warna dari ColorScheme: cukup, hampir habis, lewat waktu;
//        5. mulai lebar 840, daftar bagian pindah ke samping.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Proyek Flutter: salin berkas ini ke lib/main.dart, lalu
//    flutter run -d chrome (atau jalankan di HP Android).
// Tekan Mulai. Pindah ke bagian berikutnya saat penguji memintanya.
// Hari-H: atur layar HP agar tidak mati sendiri selama presentasi.
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const AplikasiPengaturWaktu());

// =========================== DATA RENCANA ===========================

/// Satu bagian waktu presentasi.
class BagianPresentasi {
  const BagianPresentasi(this.nama, this.durasi, this.petunjuk);

  final String nama;
  final Duration durasi;
  final String petunjuk; // apa yang dikerjakan selama bagian ini
}

/// Rencana waktu satu tim saat UAS (Panduan UAS Bagian 3): 20 menit.
/// Ikuti pengumuman dosen jika durasinya berbeda.
const List<BagianPresentasi> rencanaUas = <BagianPresentasi>[
  BagianPresentasi(
    'Presentasi dan demo',
    Duration(minutes: 7),
    'Masalah dan pengguna, lalu demo alur utama aplikasi',
  ),
  BagianPresentasi(
    'Uji langsung',
    Duration(minutes: 3),
    'Penguji meminta: mode pesawat, layar lebar, flutter test',
  ),
  BagianPresentasi(
    'Tanya jawab',
    Duration(minutes: 8),
    'Setiap anggota menjelaskan kode bagiannya',
  ),
  BagianPresentasi(
    'Catatan penguji',
    Duration(minutes: 2),
    'Penguji mencatat nilai; tim berikutnya bersiap',
  ),
];

// ============================ VIEWMODEL ============================

enum StatusWaktu { cukup, hampirHabis, lewatWaktu }

class PengaturWaktuViewModel extends ChangeNotifier {
  PengaturWaktuViewModel({
    required this._rencana,
    DateTime Function()? jam,
    this.ambangHampirHabis = const Duration(minutes: 1),
  }) : _jam = jam ?? DateTime.now;

  final List<BagianPresentasi> _rencana;
  final DateTime Function() _jam; // aslinya DateTime.now; di tes: jam palsu
  final Duration ambangHampirHabis;

  int _indeks = 0;
  Duration _terpakaiSebelumJeda = Duration.zero;
  DateTime? _mulaiBerjalan; // null = jam sedang berhenti

  List<BagianPresentasi> get rencana => _rencana;
  int get indeks => _indeks;
  BagianPresentasi get bagian => _rencana[_indeks];
  bool get berjalan => _mulaiBerjalan != null;
  bool get bagianTerakhir => _indeks == _rencana.length - 1;

  /// Waktu yang sudah terpakai di bagian ini. DIHITUNG dari jam setiap
  /// kali dibaca, jadi tidak pernah "ketinggalan" walaupun Timer di
  /// layar sempat tertunda (misalnya saat tab browser disembunyikan).
  Duration get terpakai {
    final DateTime? mulai = _mulaiBerjalan;
    if (mulai == null) return _terpakaiSebelumJeda;
    return _terpakaiSebelumJeda + _jam().difference(mulai);
  }

  /// Sisa waktu bagian ini. NEGATIF jika sudah lewat waktu.
  Duration get sisa => bagian.durasi - terpakai;

  StatusWaktu get status {
    final Duration s = sisa;
    if (s.isNegative) return StatusWaktu.lewatWaktu;
    if (s <= ambangHampirHabis) return StatusWaktu.hampirHabis;
    return StatusWaktu.cukup;
  }

  /// 0.0 (baru mulai) sampai 1.0 (waktu habis), untuk bilah kemajuan.
  double get kemajuan {
    final double rasio = terpakai.inMilliseconds / bagian.durasi.inMilliseconds;
    return rasio.clamp(0.0, 1.0);
  }

  void mulai() {
    if (berjalan) return;
    _mulaiBerjalan = _jam();
    notifyListeners();
  }

  void jeda() {
    if (!berjalan) return;
    _terpakaiSebelumJeda = terpakai; // simpan dulu, baru hentikan
    _mulaiBerjalan = null;
    notifyListeners();
  }

  /// Pindah ke bagian berikutnya. Jika jam sedang berjalan, bagian baru
  /// langsung berjalan juga.
  void berikutnya() {
    if (bagianTerakhir) return;
    _indeks++;
    _terpakaiSebelumJeda = Duration.zero;
    if (berjalan) _mulaiBerjalan = _jam();
    notifyListeners();
  }

  void ulangDariAwal() {
    _indeks = 0;
    _terpakaiSebelumJeda = Duration.zero;
    _mulaiBerjalan = null;
    notifyListeners();
  }

  /// Dipanggil Timer di View agar angka di layar diperbarui. Logika
  /// waktunya tetap di ViewModel, bukan di Timer.
  void segarkan() {
    if (berjalan) notifyListeners();
  }
}

/// Memecah sisa waktu menjadi (sudah lewat?, jumlah detik). Sisa yang
/// positif dibulatkan ke ATAS seperti jam hitung mundur: 6 menit 59,2
/// detik tetap ditampilkan 07:00.
({bool lewat, int detik}) pecahSisa(Duration sisa) {
  final int ms = sisa.inMilliseconds;
  if (ms < 0) return (lewat: true, detik: -ms ~/ 1000);
  return (lewat: false, detik: (ms + 999) ~/ 1000);
}

/// 06:59 untuk sisa waktu, +01:05 untuk kelebihan waktu.
String formatSisa(Duration sisa) {
  final (:bool lewat, :int detik) = pecahSisa(sisa);
  final String menit = (detik ~/ 60).toString().padLeft(2, '0');
  final String sisaDetik = (detik % 60).toString().padLeft(2, '0');
  return '${lewat ? '+' : ''}$menit:$sisaDetik';
}

/// Kalimat untuk pembaca layar, misalnya "Sisa waktu 6 menit 59 detik".
String bacaanSisa(Duration sisa) {
  final (:bool lewat, :int detik) = pecahSisa(sisa);
  final String awal = lewat ? 'Lewat waktu' : 'Sisa waktu';
  return '$awal ${detik ~/ 60} menit ${detik % 60} detik';
}

// ============================== VIEW ==============================

class AplikasiPengaturWaktu extends StatefulWidget {
  const AplikasiPengaturWaktu({super.key});

  @override
  State<AplikasiPengaturWaktu> createState() => _AplikasiPengaturWaktuState();
}

class _AplikasiPengaturWaktuState extends State<AplikasiPengaturWaktu> {
  // ViewModel dibuat SEKALI di sini, lalu dibuang saat aplikasi ditutup.
  final PengaturWaktuViewModel _viewModel = PengaturWaktuViewModel(
    rencana: rencanaUas,
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengatur Waktu UAS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: HalamanPengaturWaktu(viewModel: _viewModel),
    );
  }
}

class HalamanPengaturWaktu extends StatefulWidget {
  const HalamanPengaturWaktu({super.key, required this.viewModel});

  final PengaturWaktuViewModel viewModel;

  @override
  State<HalamanPengaturWaktu> createState() => _HalamanPengaturWaktuState();
}

class _HalamanPengaturWaktuState extends State<HalamanPengaturWaktu> {
  late final Timer _detak;

  @override
  void initState() {
    super.initState();
    // Empat kali per detik cukup agar angka berganti tepat pada waktunya.
    _detak = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => widget.viewModel.segarkan(),
    );
  }

  @override
  void dispose() {
    _detak.cancel(); // WAJIB: Timer yang tidak dihentikan terus berjalan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PengaturWaktuViewModel vm = widget.viewModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengatur Waktu UAS'),
        actions: [
          IconButton(
            onPressed: vm.ulangDariAwal,
            tooltip: 'Ulang dari awal',
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: SafeArea(
        // Hanya bagian ini yang dibangun ulang setiap kali ViewModel
        // memanggil notifyListeners().
        child: ListenableBuilder(
          listenable: vm,
          builder: (BuildContext context, Widget? _) {
            final bool lebar = MediaQuery.widthOf(context) >= 840;
            if (lebar) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: PanelWaktu(viewModel: vm, tinggiAngka: 200),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  SizedBox(
                    width: 360,
                    child: SingleChildScrollView(
                      child: DaftarBagian(viewModel: vm),
                    ),
                  ),
                ],
              );
            }
            return ListView(
              children: [
                PanelWaktu(viewModel: vm, tinggiAngka: 120),
                const Divider(height: 1),
                DaftarBagian(viewModel: vm),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Nama bagian, angka besar, bilah kemajuan, dan tombol.
class PanelWaktu extends StatelessWidget {
  const PanelWaktu({
    super.key,
    required this.viewModel,
    required this.tinggiAngka,
  });

  final PengaturWaktuViewModel viewModel;
  final double tinggiAngka;

  @override
  Widget build(BuildContext context) {
    final PengaturWaktuViewModel vm = viewModel;
    final ColorScheme warna = Theme.of(context).colorScheme;
    final TextTheme gaya = Theme.of(context).textTheme;
    // Pasangan warna latar + tulisan dipilih dari status (Pertemuan 7).
    // Keterangan berupa TULISAN, jadi tidak hanya mengandalkan warna.
    final (Color latar, Color tulisan, String keterangan) = switch (vm.status) {
      StatusWaktu.cukup => (
        warna.primaryContainer,
        warna.onPrimaryContainer,
        'Waktu masih cukup',
      ),
      StatusWaktu.hampirHabis => (
        warna.tertiaryContainer,
        warna.onTertiaryContainer,
        'Hampir habis',
      ),
      StatusWaktu.lewatWaktu => (
        warna.errorContainer,
        warna.onErrorContainer,
        'Lewat waktu',
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bagian ${vm.indeks + 1} dari ${vm.rencana.length}',
            style: gaya.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(vm.bagian.nama, style: gaya.headlineSmall),
          const SizedBox(height: 4),
          Text(vm.bagian.petunjuk, style: gaya.bodyMedium),
          const SizedBox(height: 16),
          Card(
            color: latar,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  // Pembaca layar membacakan kalimat, bukan "07 titik 00".
                  Semantics(
                    label: bacaanSisa(vm.sisa),
                    excludeSemantics: true,
                    child: SizedBox(
                      height: tinggiAngka,
                      child: FittedBox(
                        child: Text(
                          formatSisa(vm.sisa),
                          style: gaya.displayLarge?.copyWith(
                            color: tulisan,
                            // Lebar setiap angka sama, jadi tidak bergoyang.
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    keterangan,
                    style: gaya.titleMedium?.copyWith(color: tulisan),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: vm.kemajuan),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (vm.berjalan)
                FilledButton.icon(
                  onPressed: vm.jeda,
                  icon: const Icon(Icons.pause),
                  label: const Text('Jeda'),
                )
              else
                FilledButton.icon(
                  onPressed: vm.mulai,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(
                    vm.terpakai == Duration.zero ? 'Mulai' : 'Lanjutkan',
                  ),
                ),
              OutlinedButton.icon(
                // null = tombol nonaktif di bagian terakhir.
                onPressed: vm.bagianTerakhir ? null : vm.berikutnya,
                icon: const Icon(Icons.skip_next),
                label: const Text('Bagian berikutnya'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Daftar semua bagian: yang sudah lewat, yang sedang berjalan, dan
/// yang belum.
class DaftarBagian extends StatelessWidget {
  const DaftarBagian({super.key, required this.viewModel});

  final PengaturWaktuViewModel viewModel;

  IconData _ikon(int i) {
    if (i < viewModel.indeks) return Icons.check_circle; // sudah lewat
    if (i == viewModel.indeks) return Icons.play_circle; // sedang berjalan
    return Icons.schedule; // belum
  }

  @override
  Widget build(BuildContext context) {
    final List<BagianPresentasi> rencana = viewModel.rencana;
    final int totalMenit = rencana.fold(
      0,
      (int jumlah, BagianPresentasi b) => jumlah + b.durasi.inMinutes,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Rencana $totalMenit menit',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        for (int i = 0; i < rencana.length; i++)
          ListTile(
            selected: i == viewModel.indeks,
            leading: Icon(_ikon(i)),
            title: Text(rencana[i].nama),
            subtitle: Text(rencana[i].petunjuk),
            trailing: Text('${rencana[i].durasi.inMinutes} mnt'),
          ),
      ],
    );
  }
}
